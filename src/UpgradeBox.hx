import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class UpgradeBox extends Entity {
  var texts:Array<TextEntity>;
  var boxes:Array<Array<UpgradeBoxBox>>;
  var boughtLevel:Array<Int>;

  public static var MAX_UPGRADES:Int = 5;

  private var imgWidth:Int  = 400;
  private var imgHeight:Int = 200;

  private var selection:Int = 0;

  public function new() {
    texts = [];
    boxes = [for (x in 0...2) []];
    boughtLevel = [0, 3];

    super();

    this.x = 100;
    this.y = 100;

    var bgImg = new Image("gfx/upgradebox.png");
    var container:Entity = new Entity();
    container.addGraphic(bgImg);
    HXP.scene.add(container);

    bgImg.x = this.x;
    bgImg.y = this.y;

    //texts.push(container);

    var d1:TextEntity = new TextEntity("Damage: ", true, this.x + 20, this.y + 50);
    HXP.scene.add(d1);

    texts.push(d1);

    var d2:TextEntity = new TextEntity("Health: ", true, this.x + 20, this.y + 80);
    HXP.scene.add(d2);

    texts.push(d2);

    var explainText = new FancyText("Click on {0,255,0}*green* boxes to buy that upgrade.");
    explainText.x = this.x;
    explainText.y = this.y;
    var explainTextContainer:Entity = new Entity();
    explainTextContainer.graphic = explainText;
    HXP.scene.add(explainTextContainer);

    addBoxes();
  }

  private function addBoxes() {
    for (type in 0...texts.length) {
      for (level in 0...MAX_UPGRADES) {
        var boxType:Int = 0;

        if (level > boughtLevel[type] + 1) {
          boxType = UpgradeBoxBox.IMPOSSIBLE;
        } else if (level == boughtLevel[type] + 1) {
          boxType = UpgradeBoxBox.BUYABLE;
        } else {
          boxType = UpgradeBoxBox.BOUGHT;
        }

        var box:UpgradeBoxBox = new UpgradeBoxBox(boxType, 5);
        HXP.scene.add(box);

        box.x = texts[type].x + 80 + level * 20;
        box.y = texts[type].y;

        boxes[type].push(box);
      }
    }
  }

  private function updateBoxes() {

  }
}