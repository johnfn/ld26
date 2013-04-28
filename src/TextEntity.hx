import com.haxepunk.Entity;
import com.haxepunk.HXP;

// note - cant move if it has a shadow lol

class TextEntity extends Entity {
  public var shadowHolder:Entity;
  public var shadow:FancyText;

  public var txt:FancyText;

  public function new(content:String, shadow:Bool = false, newx:Float = 0, newy:Float = 0) {
    super();

    if (shadow) {
      var shadowEnt:TextEntity = new TextEntity('{0,0,0}*$content*', false, newx + 2, newy + 2);

      HXP.scene.add(shadowEnt);
    }

    txt = new FancyText(content);
    this.graphic = txt;
    this.x = newx;
    this.y = newy;
  }
}