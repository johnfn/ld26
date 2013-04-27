import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.HXP;


class GameMap extends TmxEntity {
  public static var widthInTiles:Int = 20;
  public static var heightInTiles:Int = 20;

  public var mapWidth:Int = 0;
  public var mapHeight:Int = 0;

  public var mapX:Int = 0;
  public var mapY:Int = 0;

  public var layers:Array<TmxEntity>;

  public function new(startX:Int, startY:Int) {
    super(Constants.MAP, widthInTiles, heightInTiles);

    layers = [new TmxEntity(Constants.MAP, widthInTiles, heightInTiles)];

    mapWidth = widthInTiles   * Constants.SIZE;
    mapHeight = heightInTiles * Constants.SIZE;

    mapX = startX;
    mapY = startY;

    for (l in layers) {
      HXP.scene.add(l);
    }

    switchMap(0, 0);
  }

  public function switchMap(dx:Int, dy:Int) {
    mapX += dx;
    mapY += dy;

    // load layers named bottom, main, top with the appropriate tileset
    loadGraphicXY("gfx/tilesheet.png", ["collisions"], mapX, mapY);
    loadMaskXY("collisions", "wall", mapX, mapY);

    layers[0].loadGraphicXY("gfx/tilesheet.png", ["treasure"], mapX, mapY);
    layers[0].loadMaskXY("treasure", "treasure", mapX, mapY);
  }

  public function contains(e:Entity):Bool {
    if (e.x < 0) return false;
    if (e.y < 0) return false;

    if (e.x + e.width > mapWidth)  return false;
    if (e.y + e.height > mapHeight) return false;

    return true;
  }
}