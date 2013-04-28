import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.masks.Grid;

class GameMap extends TmxEntity {
  public static var widthInTiles:Int = 20;
  public static var heightInTiles:Int = 20;

  public var mapWidth:Int = 0;
  public var mapHeight:Int = 0;

  public var mapX:Int = 0;
  public var mapY:Int = 0;

  public var layers:Array<TmxEntity>;
  private var dynItemTypes:Array<String>;

  public function new(startX:Int, startY:Int) {
    super(Constants.MAP, widthInTiles, heightInTiles);

    dynItemTypes = ["Treasure", "Jumper"];

    layers = [new TmxEntity(Constants.MAP, widthInTiles, heightInTiles)];

    mapWidth = widthInTiles   * Constants.SIZE;
    mapHeight = heightInTiles * Constants.SIZE;

    mapX = startX;
    mapY = startY;

    switchMap(0, 0);
  }

  private function initializeType(t:String) {
    layers[0].loadMaskXY(t, t, mapX, mapY);

    var g:Grid = cast(layers[0].mask, Grid);

    for (i in 0...g.width) {
      for (j in 0...g.height) {
        if (g.getTile(i, j)) {
          HXP.log(t);
          var t:Entity = Type.createInstance(Type.resolveClass(t), []);
          t.x = i * Constants.SIZE;
          t.y = j * Constants.SIZE;
          HXP.scene.add(t);
        }
      }
    }
  }

  public function switchMap(dx:Int, dy:Int) {
    var ms:scenes.MainScene = cast(HXP.scene, scenes.MainScene);

    for (t in dynItemTypes) {
      var arr:Array<Entity> = [];
      ms.getType(t, arr);

      for (e in arr) {
        e.destroy();
      }
    }

    mapX += dx;
    mapY += dy;

    // load layers named bottom, main, top with the appropriate tileset
    loadGraphicXY("gfx/tilesheet.png", ["collisions"], mapX, mapY);
    loadMaskXY("collisions", "wall", mapX, mapY);

    var xx:Entity = new Jumper();

    for (t in dynItemTypes) {
      initializeType(t);
    }
  }

  public function contains(e:Entity):Bool {
    if (e.x < 0) return false;
    if (e.y < 0) return false;

    if (e.x + e.width > mapWidth)  return false;
    if (e.y + e.height > mapHeight) return false;

    return true;
  }
}