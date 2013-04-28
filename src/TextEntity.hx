import com.haxepunk.Entity;
import com.haxepunk.HXP;

// note - cant move if it has a shadow lol

class TextEntity extends Entity {
  public var shadowEnt:TextEntity;
  private var hasShadow:Bool;

  public var txt:FancyText;

  public function new(content:String, shadow:Bool = false, newx:Float = 0, newy:Float = 0) {
    super();

    hasShadow = shadow;
    if (shadow) {
      shadowEnt = new TextEntity('{0,0,0}*$content*', false, newx + 2, newy + 2);

      HXP.scene.add(shadowEnt);
    }

    txt = new FancyText(content);
    this.graphic = txt;
    this.x = newx;
    this.y = newy;
  }

  public function hide() {
    txt.visible = false;

    if (hasShadow) {
      shadowEnt.visible = false;
    }
  }

  public function show() {
    txt.visible = true;

    if (hasShadow) {
      shadowEnt.visible = true;
    }
  }
}