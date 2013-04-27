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
  var playerIcon:Entity;

  public function new(startX:Int, startY:Int) {
    super();

    var scene = cast(HXP.scene, scenes.MainScene);
    var playerX = Math.floor(scene.player.x / Constants.SIZE);
    var playerY = Math.floor(scene.player.y / Constants.SIZE);

    // add "minimap" text.

    minimapPixels = [];
    for (x in 0...15) {
      minimapPixels.push([]);
      for (y in 0...15) {
        var collMask:Grid = cast(scene.mapEntity.mask, Grid);
        var cr;
        var destX:Int = startX + x * 3;
        var destY:Int = startY + y * 3;

        if (collMask.getTile(x, y)) {
          cr = new Rectangle(0, 0, 3, 3);
        } else {
          cr = new Rectangle(3, 0, 3, 3);
        }

        if (x == playerX && y == playerY) {
          playerIcon = new Entity(destX, destY);

          var spritemap = new Spritemap("gfx/minimap.png", 3, 3);
          spritemap.add("normal", [2, 3], 5, true);
          spritemap.play("normal");

          playerIcon.graphic = spritemap;
          HXP.scene.add(playerIcon);
        } else {

          var i:Image = new Image("gfx/minimap.png", cr);
          minimapPixels[x][y] = i;
          HXP.scene.addGraphic(i);

          i.x = destX;
          i.y = destY;
        }
      }
    }
  }

  public function destroy() {
    // remove all pixels (better is to just hide them)
    // remove player icon
  }
}