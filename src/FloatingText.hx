import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class FloatingText extends Entity {
  var text:FancyText;
  var lifespan:Int = 180;

  public function new(content:String, x:Int, y:Int) {
    super();

    text = new FancyText(content, x, y);

    graphic = text;
  }

  public override function update() {
    this.text.y -= 3;
    --lifespan;

    if (this.text.y < 0 || lifespan < 0) {
      this.destroy();
    }
  }
}