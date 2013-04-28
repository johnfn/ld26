import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class Jumper extends Enemy {
  var spritemap:Spritemap;

  public function new() {
    super();

    spritemap = new Spritemap("gfx/jumper.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("normal", [0]);
    spritemap.add("jumping", [1]);
    spritemap.play("normal");

    this.graphic = spritemap;
    this.wantsToShoot = false;
    this.type = "Jumper";
  }

  public override function update() {
    super.update();
  }
}