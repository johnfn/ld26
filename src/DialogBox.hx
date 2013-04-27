import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class DialogBox extends Entity {
  private var texts:Array<String>;
  private var textbox:FancyText;

  private var bg:Entity;
  private var imgWidth:Int  = 300;
  private var imgHeight:Int = 200;

  public function new(texts:Array<String>) {
    super();

    this.x = 100;
    this.y = 100;

    var bgImg = new Image("gfx/dialogbox.png"); // i'm so lazy
    bg = new Entity();
    bg.graphic = bgImg;
    HXP.scene.add(this.bg);

    bg.x = this.x;
    bg.y = this.y;

    this.texts = texts;
    this.textbox = new FancyText(texts.shift(), 20, 20, imgWidth - 40, imgHeight - 40, {wordWrap: true, color: 0xffffff});

    HXP.log('here it is ${imgWidth}');
    HXP.log('here it is ${this.textbox.width}');
    this.graphic = textbox;
  }

  public function destroy() {
    HXP.scene.remove(this.bg);

    HXP.scene.remove(this);
    this.graphic = null;
  }

  public override function update() {
    if (Input.released(Key.X)) {
      if (this.texts.length == 0) {
        this.destroy();
      } else {
        this.textbox.text = this.texts.shift();
      }
    }
  }
}
