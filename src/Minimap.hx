import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.*;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Stamp;

import nme.geom.Rectangle;

class Minimap extends Entity {
  var minimapPixels:Array<Array<Image>>;

  public function new() {
    minimapPixels = [];
    for (x in 0...10) {
      minimapPixels.push([]);
      for (y in 0...10) {
        var cr = new Rectangle((x % 4) * 3, 0, (x % 4) * 3 + 3, 3);
        var i:Image = new Image("gfx/minimap.png", cr);
        minimapPixels[x][y] = i;
        HXP.scene.addGraphic(i);

        i.x = x * 3;
        i.y = y * 3;
      }
    }

    super();
  }
}