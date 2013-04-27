import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Coin extends Entity {

  public function new() {
    super();

    var spritemap = new Spritemap("gfx/coin.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.play("normal");

    type = "coin";

    this.setHitbox(Constants.SIZE, Constants.SIZE);
    this.graphic = spritemap;
  }

  public function destroy() {
    HXP.scene.remove(this);
    this.graphic = null;
  }

  public override function update() {
    super.update();
  }
}