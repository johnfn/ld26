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
  private var mainscene:scenes.MainScene;

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

    mainscene = cast(HXP.scene, scenes.MainScene);
    mainscene.pause(this);
  }

  public function destroy() {
    HXP.scene.remove(this.bg);

    HXP.scene.remove(this);
    this.graphic = null;
    mainscene.unpause();
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
