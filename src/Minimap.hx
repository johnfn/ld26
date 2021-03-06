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
  var minimapPixels:Array<Array<Entity>>;
  var playerIcon:Entity;
  var minimapText:FancyText;
  var show = false;
  var startX:Int;
  var startY:Int;

  public function new(startX:Int, startY:Int) {
    super();

    minimapText = new FancyText("Hurr it's a Minimap!", startX, startY - 25);

    this.startX = startX;
    this.startY = startY;
  }

  function load() {
    var scene = cast(HXP.scene, scenes.MainScene);
    var playerX = Math.floor(scene.player.x / Constants.SIZE);
    var playerY = Math.floor(scene.player.y / Constants.SIZE);

    minimapPixels = [];
    for (x in 0...15) {
      minimapPixels.push([]);
      for (y in 0...15) {
        var collMask:Grid = cast(scene.map.mask, Grid);
        var cr;
        var destX:Int = startX + x * 3;
        var destY:Int = startY + y * 3;

        if (collMask.getTile(x, y)) {
          cr = new Rectangle(0, 0, 3, 3);
        } else {
          cr = new Rectangle(3, 0, 3, 3);
        }

        var pix:Entity = new Entity();

        if (x == playerX && y == playerY) {
          var spritemap = new Spritemap("gfx/minimap.png", 3, 3);

          spritemap.add("normal", [2, 3], 5, true);
          spritemap.play("normal");

          pix.graphic = spritemap;
        } else {
          var i:Image = new Image("gfx/minimap.png", cr);

          pix.graphic = i;
        }

        pix.x = destX;
        pix.y = destY;
        HXP.scene.add(pix);
        minimapPixels[x][y] = pix;
      }
    }
  }

  public function toggle() {
    show = !show;

    if (show) {
      load();
    }

    for (row in minimapPixels) {
      for (pix in row) {
        if (show) {
          HXP.scene.add(pix);
        } else {
          HXP.scene.remove(pix);
        }
      }
    }

    if (show) {
      this.graphic = minimapText;
    } else {
      this.graphic = null;
    }
  }
}