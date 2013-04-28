import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class Player extends Entity {
  public var health:Int = 1;
  public var totalHealth:Int = 1;

  public var coins:Int = 5;

  private var spritemap:Spritemap;
  private var playerWidth:Int = 25;
  private var playerHeight:Int = 25;

  private var hitBottom:Bool = false;
  private var hitTop:Bool = false;

  private var vx:Float = 0;
  private var vy:Float = 0;
  private var facing:Int = 1;
  private var facingUp:Int = 0;

  private var gunCooldown:Int = 10;
  private var gunCooldownMax:Int = 10;

  private var noMoveFlickerCountdown:Int = 15;

  private var enterScreenLocX:Float = 0;
  private var enterScreenLocY:Float = 0;

  private var diedAlready:Bool = false;

  private var hasGun:Bool = false;

  public function new() {
    super();

    spritemap = new Spritemap("gfx/player.png", playerWidth, playerHeight);
    spritemap.add("right", [0]); //note - not specifying a framerate currently
    spritemap.add("up", [1]);
    spritemap.add("left", [2]);
    spritemap.add("crouch", [3]);
    spritemap.play("normal");

    this.graphic = spritemap;
    this.setHitbox(playerWidth - 2, playerHeight - 2); // fit in small spaces

    this.x = 50;
    this.y = 50;

    this.type = "player";
  }

  private function openTreasure() {
    var ms:scenes.MainScene = cast(HXP.scene, scenes.MainScene);

    if (ms.map.mapX == 1 && ms.map.mapY == 0 && !hasGun) {
      HXP.scene.add(new DialogBox(["You got *THE MINIMALIZER*!", "It allows you to minimalize the health of enemies.", "Simply apply the *x* key to perform shooting.", "I mean, to perform minimalization."]));
      hasGun = true;
    }
  }

  private function genericCollision(e:Entity):Bool {
    if (e.type == "coin") {
      var c = cast(e, Coin);
      c.pickup(this);

      return false;
    }

    if (Constants.isEnemy(e.type)) {
      var en:Enemy = cast(e, Enemy);
      noMoveFlickerCountdown = 30;
      if (en.touchDamage() > 0) {
        this.damage(en.touchDamage());
      }
      this.moveBy(-facing * 20, 0, "wall");
    }

    if (e.type == "Treasure") {
      var t:Treasure = cast(e, Treasure);
      t.open();

      openTreasure();
    }

    if (e.type == "HealthPlus") {
      var h:HealthPlus = cast(e, HealthPlus);
      h.get(this);
    }

    return true;
  }

  public override function moveCollideX(e:Entity):Bool {
    return genericCollision(e);
  }

  public override function moveCollideY(e:Entity):Bool {
    if (this.vy > 0) {
      hitBottom = true;
    }
    if (this.vy < 0) {
      hitTop = true;
    }

    return genericCollision(e);
  }

  public function die() {
    this.health = this.totalHealth;
    noMoveFlickerCountdown = 90;

    this.x = enterScreenLocX;
    this.y = enterScreenLocY;

    if (!diedAlready) {
      diedAlready = true;

      HXP.scene.add(new DialogBox(["YOU DIE!!!", "Luckily, the only consequence of dying is a respawn."]));
    }

    var ms:scenes.MainScene = cast(HXP.scene, scenes.MainScene);
    ms.map.respawnAllEnemies();
  }

  public function damage(amt:Int):Void {
    this.health -= amt;

    if (this.health <= 0) {
      die();
    }
  }

  private function shoot() {
    if (hasGun) {
      if (facingUp != 0) {
        HXP.scene.add(new Bullet(this, Std.random(5) + 2, 0, this.facingUp * -10));
      } else {
        HXP.scene.add(new Bullet(this, Std.random(5) + 2, this.facing * 10, 0));
      }
    }
  }

  private function resetState() {
    hitBottom = false;
    hitTop = false;
  }

  private function checkpoint() {
    if (this.collideTypes(Constants.enemTypes(), this.x, this.y) == null) {
      var d = Std.random(999);
      HXP.log('Checkpoint! $d');
      enterScreenLocX = this.x;
      enterScreenLocY = this.y;
    }
  }

  private function checkLeftMap() {
    var scene:scenes.MainScene = cast(HXP.scene, scenes.MainScene);

    if (this.x + this.width >= scene.map.mapWidth) {
      this.x -= scene.map.mapWidth - this.width;

      scene.map.switchMap(1, 0);
      checkpoint();
      return;
    }

    if (this.x < 0) {
      this.x += scene.map.mapWidth - this.width;

      scene.map.switchMap(-1, 0);
      checkpoint();
      return;
    }

    if (this.y + this.height >= scene.map.mapHeight) {
      this.y -= scene.map.mapHeight - this.height;

      scene.map.switchMap(0, 1);
      checkpoint();
      return;
    }

    if (this.y < 0) {
      this.y += scene.map.mapHeight - this.height;

      scene.map.switchMap(0, -1);
      checkpoint();
      return;
    }
  }

  public override function update() {
    vx = 0;

    if (noMoveFlickerCountdown > 0) {
      noMoveFlickerCountdown--;
      Constants.flicker(this, noMoveFlickerCountdown);
    }

    if (Input.check(Key.RIGHT)) {
      vx += 6;
    }

    if (Input.check(Key.LEFT)) {
      vx -= 6;
    }

    if (Input.check(Key.UP)) {
      facingUp = 1;
    } else if (Input.check(Key.DOWN)) {
      facingUp = -1;
    } else {
      facingUp = 0;
    }

    if (vx != 0) this.facing = HXP.sign(vx);

    if (Input.check(Key.Z)) {
      if (this.gunCooldown <= 0) {
        shoot();
        this.gunCooldown = this.gunCooldownMax;
      }
    }

    this.gunCooldown -= 1;

    if (this.collideTypes("Ladder", this.x, this.y) == null) {
      // normal mode
      vy += 0.5;

      if (hitBottom) {
        vy = 0;

        if (Input.check(Key.X)) {
          vy -= 10;
        }
      }

      if (!Input.check(Key.X) && vy < 0) {
        vy = 0;
      }

      if (hitTop) {
        vy = 0;
      }

    } else {
      // ladder mode
      HXP.log("ladder!");

      if (Input.check(Key.UP)) {
        vy = -3;
      } else if (Input.check(Key.DOWN)) {
        vy = 3;
      } else {
        vy = 0;
      }

      if (Input.check(Key.X) && vy >= -3) {
        vy -= 8;
      }
      hitBottom = false;
    }

    resetState(); // moveBy sets state via moveCollide{X,Y}

    // a bit of redundant work
    var collidables = ["wall", "coin", "Treasure", "HealthPlus"];
    collidables = collidables.concat(Constants.enemTypes());

    if (noMoveFlickerCountdown <= 0) {
      this.moveBy(vx, 0, collidables, true);
    }

    checkLeftMap();

    this.moveBy(0, vy, collidables, true);

    checkLeftMap();

    super.update();

    if (facingUp != 0) {
      if (facingUp > 0) {
        spritemap.play("up");
      } else {
        spritemap.play("crouch");
      }
    } else {
      if (facing == -1) {
        spritemap.play("left");
      } else {
        spritemap.play("right");
      }
    }
  }
}