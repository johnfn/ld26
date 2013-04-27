package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;

class MainScene extends Scene {
  public var mapEntity:TmxEntity;

  public function new() {
    super();
  }

  public override function begin() {
    mapEntity = new TmxEntity("maps/map.tmx");

    // load layers named bottom, main, top with the appropriate tileset
    mapEntity.loadGraphic("gfx/tilesheet.png", ["Tile Layer 1"]);

    // loads a grid layer named collision and sets the entity type to walls
    mapEntity.loadMask("collisions", "walls");

    add(mapEntity);
    add(new Player());

    new HUD();

    new Minimap(100, 100);
  }

  public override function update() {
    super.update();
  }
}