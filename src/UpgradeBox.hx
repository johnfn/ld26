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
  var costs:Array<Array<Int>>;
  var boughtLevel:Array<Int>;

  public static var MAX_UPGRADES:Int = 5;

  public var information:TextEntity;

  private var imgWidth:Int  = 400;
  private var imgHeight:Int = 200;

  private var selection:Int = 0;
  private var mainscene:scenes.MainScene;
  private var player:Player;

  public function new(player:Player) {
    texts = [];
    costs = [[1,2,3,4,5], [2,4,6,8,10]];
    boxes = [for (x in 0...2) []];
    boughtLevel = [0, 3];

    this.player = player;

    mainscene = cast(HXP.scene, scenes.MainScene);

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

    this.information = new TextEntity("Click on {0,255,0}*green* boxes to buy that upgrade.", this.x, this.y);
    HXP.scene.add(this.information);

    addBoxes();
    updateBoxes();

    mainscene.pause(this);
  }

  public function notify(str:String) {
    this.information.txt.text = str;
  }

  // true if you can buy it, false if it failed.
  public function buy(type:Int):Bool {
    var cost:Int = costs[type][boughtLevel[type] + 1];

    if (player.coins >= cost) {
      boughtLevel[type]++;
      player.coins -= cost;
      return true;
    } else {
      return false;
    }
  }

  private function addBoxes() {
    for (type in 0...texts.length) {
      for (level in 0...MAX_UPGRADES) {
        var box:UpgradeBoxBox = new UpgradeBoxBox(0, costs[type][level], this, type);
        HXP.scene.add(box);

        box.x = texts[type].x + 80 + level * 20;
        box.y = texts[type].y;

        boxes[type].push(box);
      }
    }
  }

  private function updateBoxes() {
    for (type in 0...texts.length) {
      for (level in 0...MAX_UPGRADES) {
        var boxStatus:Int = 0;

        if (level > boughtLevel[type] + 1) {
          boxStatus = UpgradeBoxBox.IMPOSSIBLE;
        } else if (level == boughtLevel[type] + 1) {
          boxStatus = UpgradeBoxBox.BUYABLE;
        } else {
          boxStatus = UpgradeBoxBox.BOUGHT;
        }

        boxes[type][level].setStatus(boxStatus);
      }
    }
  }

  public override function update() {
    updateBoxes();

    if (Input.pressed(Key.TAB)) {
      mainscene.unpause();
    }

    super.update();

    for (row in boxes) {
      for (up in row) {
        up.update();
      }
    }

    this.mainscene.hud.update();
  }
}