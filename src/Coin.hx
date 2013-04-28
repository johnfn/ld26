import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Coin extends Entity {
  private var _destroyed:Bool = false;
  private var value:Int = 0;

  public function new(value:Int = 1) {
    super();

    this.value = value;

    var spritemap = new Spritemap("gfx/coin.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.play("normal");

    type = "coin";

    this.setHitbox(Constants.SIZE, Constants.SIZE);
    this.graphic = spritemap;
  }

  public function pickup(destroyer:Player) {
    if (!_destroyed) {
      _destroyed = true;
      destroyer.coins += this.value;

      var t:FloatingText = new FloatingText('{255,255,0} *+$value*', Std.int(this.x), Std.int(this.y));
      HXP.scene.add(t);
    }

    destroy();
  }

  public override function update() {
    super.update();
  }
}