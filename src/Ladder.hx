import com.haxepunk.Scene;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.utils.*;
import com.haxepunk.graphics.Image;

class Ladder extends Entity {
  public function new() {
    super();
    this.type = "Ladder";
    this.graphic = new Image("gfx/ladder.png");
    this.setHitbox(Constants.SIZE, Constants.SIZE);
  }
}