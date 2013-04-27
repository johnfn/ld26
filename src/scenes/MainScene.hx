package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;

class MainScene extends Scene {
  public function new() {
    super();
  }

  public override function begin() {
    var e = new TmxEntity("maps/map.tmx");

    // load layers named bottom, main, top with the appropriate tileset
    e.loadGraphic("gfx/tilesheet.png", ["Tile Layer 1"]);

    // loads a grid layer named collision and sets the entity type to walls
    e.loadMask("collisions", "walls");

    add(e);

    add(new Player());

    new HUD();
  }

  public override function update() {
    super.update();
  }
}