import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Enemy extends Entity {
  var health:Int = 20;

  public function new() {
    super();

    type = "enemy";

    graphic = new Image("gfx/enemy-shooter.png");

    this.setHitbox(Constants.SIZE, Constants.SIZE);
  }

  public function damage(amt:Int):Void {
    this.health -= amt;
  }
}
