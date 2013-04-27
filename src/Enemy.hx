import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Enemy extends Entity {
  var _health:Int = 20;
  var _maxHealth:Int = 20;
  var healthbar:EnemyHealthbar;
  var dyingCount:Int = 60;
  var dying:Bool = false;

  public function new() {
    super();

    healthbar = new EnemyHealthbar(this);

    type = "enemy";

    graphic = new Image("gfx/enemy-shooter.png");

    this.setHitbox(Constants.SIZE, Constants.SIZE);

    healthbar = new EnemyHealthbar(this);
    HXP.scene.add(healthbar);
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

  public function destroy() {
    HXP.scene.remove(this);
    this.graphic = null;

    healthbar.destroy();
  }

  public function slowlyDie() {
    // flicker
    dyingCount--;
    Constants.flicker(this, dyingCount);

    if (dyingCount < 0) {
      destroy();
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
    }
  }
}
