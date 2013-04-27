import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class Player extends Entity {
  public var health:Int = 6;
  public var totalHealth:Int = 6;

  public var coins:Int = 0;

  private var spritemap:Spritemap;
  private var playerWidth:Int = 25;
  private var playerHeight:Int = 25;

  private var hitBottom:Bool = false;

  private var vx = 0;
  private var vy = 0;
  private var facing:Int = 1;

  private var gunCooldown:Int = 10;
  private var gunCooldownMax:Int = 10;

  private var noMoveFlickerCountdown:Int = 15;

  public function new() {
    super();

    spritemap = new Spritemap("gfx/player.png", playerWidth, playerHeight);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.play("normal");

    this.graphic = spritemap;
    this.setHitbox(playerWidth - 2, playerHeight - 2); // fit in small spaces

    this.x = 50;
    this.y = 50;

    this.type = "player";
  }

  private function genericCollision(e:Entity):Bool {
    if (e.type == "coin") {
      var c = cast(e, Coin);
      c.destroy(this);

      return false;
    }

    if (e.type == "enemy") {
      noMoveFlickerCountdown = 30;
      this.moveBy(-facing * 20, 0, "wall");
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

    return genericCollision(e);
  }

  public function damage(amt:Int):Void {
    this.health -= amt;
  }

  private function shoot() {
    HXP.scene.add(new Bullet(this, Std.random(5) + 2, this.facing * 10, 0));
  }

  private function resetState() {
    hitBottom = false;
  }

  private function checkLeftMap() {
    var scene:scenes.MainScene = cast(HXP.scene, scenes.MainScene);

    if (scene.map.contains(this)) {
      return;
    }

    if (this.x >= scene.map.mapWidth) {
      this.x -= scene.map.mapWidth;

      scene.map.switchMap(1, 0);
      return;
    }

    if (this.x < 0) {
      this.x += scene.map.mapWidth;

      scene.map.switchMap(-1, 0);
      return;
    }

    if (this.y >= scene.map.mapHeight) {
      this.y -= scene.map.mapHeight;

      scene.map.switchMap(0, 1);
      return;
    }

    if (this.y < 0) {
      this.y += scene.map.mapHeight;

      scene.map.switchMap(0, -1);
      return;
    }

    // could prob throw an assert here...

    HXP.log("uh oh.");
  }

  public override function update() {
    vx = 0;

    if (noMoveFlickerCountdown > 0) {
      noMoveFlickerCountdown--;
      Constants.flicker(this, noMoveFlickerCountdown);
      return;
    }

    if (Input.check(Key.D)) {
      vx += 6;
    }

    if (Input.check(Key.A)) {
      vx -= 6;
    }

    if (vx != 0) this.facing = HXP.sign(vx);

    if (Input.check(Key.SPACE)) {
      if (this.gunCooldown <= 0) {
        shoot();
        this.gunCooldown = this.gunCooldownMax;
      }
    }

    this.gunCooldown -= 1;

    vy += 1;

    if (hitBottom) {
      vy = 0;

      if (Input.check(Key.W)) {
        vy -= 15;
      }
    }

    resetState(); // moveBy sets state via moveCollide{X,Y}

    this.moveBy(vx, 0, ["wall", "enemy", "coin", "treasure"], true);

    checkLeftMap();

    this.moveBy(0, vy, ["wall", "enemy", "coin", "treasure"], true);

    checkLeftMap();

    super.update();
  }
}