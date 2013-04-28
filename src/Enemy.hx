import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

// this class should not be initialized
class Enemy extends Entity {
  var _health:Int = 20;
  var _maxHealth:Int = 20;
  var healthbar:EnemyHealthbar;
  var dyingCount:Int = 60;
  var dying:Bool = false;
  var facing:Int = 1;

  public var wantsToShoot:Bool = true;

  public function new() {
    super();

    healthbar = new EnemyHealthbar(this);

    type = "enemy";

    graphic = new Image("gfx/enemy-shooter.png");

    this.setHitbox(Constants.SIZE, Constants.SIZE);

    healthbar = new EnemyHealthbar(this);
    HXP.scene.add(healthbar);
    HXP.scene.bringToFront(healthbar);
  }

  public function damage(amt:Int):Void {
    this._health -= amt;
  }

  public function health():Int {
    return _health;
  }

  public function maxHealth():Int {
    return _maxHealth;
  }

  public override function destroy() {
    HXP.scene.remove(this);
    this.graphic = null;

    healthbar.destroy();
  }

  private function shoot() {
    if (wantsToShoot) {
      HXP.scene.add(new Bullet(this, 1, this.facing * 10, 0));
    }
  }

  public function slowlyDie() {
    // flicker
    dyingCount--;
    Constants.flicker(this, dyingCount);

    if (dyingCount < 0) {
      destroy();

      var c:Coin = new Coin();
      c.x = this.x;
      c.y = this.y;

      HXP.scene.add(c);
    }
  }

  public override function update() {
    healthbar.update();
    super.update();

    if (this.health() < 0) {
      dying = true;
    }

    if (dying) {
      this.slowlyDie();
    } else {
      if (Std.random(20) == 0) {
        shoot();
      }
    }
  }
}
