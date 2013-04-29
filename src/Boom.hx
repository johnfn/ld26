import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Boom extends Entity {
  private var life:Int = 150;

  public function new() {
    super();

    var spritemap = new Spritemap("gfx/boom.png", 25, 25);
    spritemap.add("boom", [0, 1, 2, 3], 20, false); //note - not specifying a framerate currently
    this.graphic = spritemap;
    spritemap.play("boom", true);
  }

  public override function update() {
    --life;
    if (life < 0) {
      destroy();
    }
  }
}
