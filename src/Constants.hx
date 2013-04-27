import com.haxepunk.Entity;

class Constants {
  public static var SIZE:Int = 25;
  public static var MAP:String = "maps/map.tmx";
  public static var DEBUG:Bool = true;

  public static function flicker(e:Entity, count:Int) {
    e.visible = (Std.int(count / 5) % 2 == 0);
  }
}