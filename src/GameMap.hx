import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.masks.Grid;

// Required or Haxe doesn't know what they are lol
import Shooter;
import Ladder;
import Jumper;
import Walker;
import Spike;

class GameMap extends TmxEntity {
  public static var widthInTiles:Int = 20;
  public static var heightInTiles:Int = 20;

  public var mapWidth:Int = 0;
  public var mapHeight:Int = 0;

  public var mapX:Int = 0;
  public var mapY:Int = 0;

  public var layers:Array<TmxEntity>;
  private var dynItemTypes:Array<String>;

  public var backdrop:TmxEntity;
  public var ladder:TmxEntity;

  public function new(startX:Int, startY:Int) {
    super(Constants.MAP, widthInTiles, heightInTiles);

    backdrop = new TmxEntity(Constants.MAP, widthInTiles, heightInTiles);

    dynItemTypes = ["Treasure", "Ladder", "HealthPlus"];

    for (e in Constants.enemTypes()) {
      dynItemTypes.push(e);
    }

    layers = [new TmxEntity(Constants.MAP, widthInTiles, heightInTiles)];

    mapWidth = widthInTiles   * Constants.SIZE;
    mapHeight = heightInTiles * Constants.SIZE;

    mapX = startX;
    mapY = startY;

    switchMap(0, 0);
  }

  private function initializeType(t:String) {
    var locs:Array<Array<Int>> = layers[0].getLocs(t, t, mapX, mapY);

    for (loc in locs) {
      var locx:Int = loc[0];
      var locy:Int = loc[1];

      var t:Entity = Type.createInstance(Type.resolveClass(t), []);
      t.x = locx * Constants.SIZE;
      t.y = locy * Constants.SIZE;
      HXP.scene.add(t);
    }
  }

  public function switchMap(dx:Int, dy:Int) {
    var ms:scenes.MainScene = cast(HXP.scene, scenes.MainScene);
    var removeItemTypes = dynItemTypes.concat(["bullet"]);

    for (t in removeItemTypes) {
      var arr:Array<Entity> = [];
      ms.getType(t, arr);

      for (e in arr) {
        e.destroy();
      }
    }

    mapX += dx;
    mapY += dy;

    backdrop.loadGraphicXY("gfx/tilesheet.png", ["sky"], mapX, mapY);
    HXP.scene.add(backdrop);

    // load layers named bottom, main, top with the appropriate tileset
    loadGraphicXY("gfx/tilesheet.png", ["collisions"], mapX, mapY);
    loadMaskXY("collisions", "wall", mapX, mapY);

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