import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;

class GameMap extends TmxEntity {
  public static var widthInTiles:Int = 20;
  public static var heightInTiles:Int = 20;

  public var mapWidth:Int = 0;
  public var mapHeight:Int = 0;

  public function new(startX:Int, startY:Int) {
    super(Constants.MAP, widthInTiles, heightInTiles);

    mapWidth = widthInTiles   * Constants.SIZE;
    mapHeight = heightInTiles * Constants.SIZE;

    // load layers named bottom, main, top with the appropriate tileset
    loadGraphicXY("gfx/tilesheet.png", ["collisions"], startX, startY);

    // loads a grid layer named collision and sets the entity type to walls
    loadMaskXY("collisions", "walls", startX, startY);
  }

  public function contains(e:Entity):Bool {
    if (e.x < 0) return false;
    if (e.y < 0) return false;

    if (e.x + e.width > mapWidth)  return false;
    if (e.y + e.height > mapHeight) return false;

    return true;
  }
}