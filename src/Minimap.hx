import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.*;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Stamp;
import com.haxepunk.masks.Grid;

import nme.geom.Rectangle;

class Minimap extends Entity {
  var minimapPixels:Array<Array<Image>>;

  public function new(startX:Int, startY:Int) {
    super();

    minimapPixels = [];
    for (x in 0...15) {
      minimapPixels.push([]);
      for (y in 0...15) {
        var collMask:Grid = cast(cast(HXP.scene, scenes.MainScene).mapEntity.mask, Grid);
        var cr;
        if (collMask.getTile(x, y)) {
          cr = new Rectangle(0, 0, (x % 4) * 3 + 3, 3);
        } else {
          cr = new Rectangle(3, 0, (x % 4) * 3 + 3, 3);
        }

        var i:Image = new Image("gfx/minimap.png", cr);
        minimapPixels[x][y] = i;
        HXP.scene.addGraphic(i);

        i.x = startX + x * 3;
        i.y = startY + y * 3;
      }
    }
  }
}