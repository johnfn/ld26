import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Player extends Entity {
  private var spritemap:Spritemap;
  private var playerWidth:Int = 25;
  private var playerHeight:Int = 25;

  private var hitBottom:Bool = false;

  private var vx = 0;
  private var vy = 0;
  private var facing:Int = 1;

  private var gunCooldown:Int = 10;
  private var gunCooldownMax:Int = 10;

  public function new() {
    super();

    spritemap = new Spritemap("gfx/player.png", playerWidth, playerHeight);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.play("normal");

    this.graphic = spritemap;
    this.setHitbox(playerWidth, playerHeight);

    this.x = 50;
    this.y = 50;
  }

  public override function moveCollideX(e:Entity):Bool {

    return true;
  }

  public override function moveCollideY(e:Entity):Bool {
    if (this.vy > 0) {
      hitBottom = true;
    }

    return true;
  }

  private function shoot() {
    HXP.scene.add(new Bullet(this, this.facing * 10, 0));
  }

  private function resetState() {
    hitBottom = false;
  }

  public override function update() {
    vx = 0;

    if (Input.check(Key.D)) {
      vx += 6;
    }

    if (Input.check(Key.A)) {
      vx -= 6;
    }

    if (vx != 0) this.facing = HXP.sign(vx);

    if (Input.check(Key.SPACE)) {
      this.gunCooldown -= 1;

      if (this.gunCooldown <= 0) {
        shoot();
        this.gunCooldown = this.gunCooldownMax;
      }
    }

    vy += 1;

    if (hitBottom) {
      vy = 0;

      if (Input.check(Key.W)) {
        vy -= 15;
      }
    }

    resetState(); // moveBy sets state via moveCollide{X,Y}
    this.moveBy(vx, vy, "walls", true);

    super.update();

  }
}