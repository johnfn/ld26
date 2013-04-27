import nme.display.BitmapData;
import nme.display.Sprite;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.atlas.AtlasData;
import com.haxepunk.graphics.atlas.AtlasRegion;
import com.haxepunk.graphics.Image;
import com.haxepunk.RenderMode;

typedef TextOptions = {
  @:optional var font:String;
  @:optional var size:Int;
#if (flash || js)
  @:optional var align:TextFormatAlign;
#else
  @:optional var align:String;
#end
  @:optional var wordWrap:Bool;
  @:optional var resizable:Bool;
  @:optional var color:Int;
  @:optional var leading:Int;
};

 typedef ColorSegment = {
   var start: Int;
   var end: Int;
   var color: Int;
 }

/**
 * Used for drawing text using embedded fonts.
 */
class FancyText extends Image
{
  public var resizable:Bool;
  public var textWidth(default, null):Int;
  public var textHeight(default, null):Int;

  var pairs: Array<ColorSegment>;


  /**
   * Constructor.
   * @param text    Text to display.
   * @param x       X offset.
   * @param y       Y offset.
   * @param width   Image width (leave as 0 to size to the starting text string).
   * @param height  Image height (leave as 0 to size to the starting text string).
   * @param options An object containing optional parameters contained in TextOptions
   */
  public function new(text:String, x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0, ?options:TextOptions)
  {
    pairs = [];
    if (options == null)
    {
      options = {};
      options.color = 0xFFFFFF;
    }

    if (options.font == null)  options.font = HXP.defaultFont;
    if (options.size == 0)     options.size = 16;
    if (options.align == null) options.align = TextFormatAlign.LEFT;

    var fontObj = nme.Assets.getFont(options.font);
    _format = new TextFormat(fontObj.fontName, options.size, options.color);
    _format.align = options.align;
    _format.leading = options.leading;

    _field = new TextField();
#if flash
    _field.embedFonts = true;
#end
    _field.wordWrap = options.wordWrap;
    _field.defaultTextFormat = _format;
    _field.text = text;

    resizable = options.resizable;

    if (width == 0) width = Std.int(_field.textWidth + 4);
    if (height == 0) height = Std.int(_field.textHeight + 4);

    var source:Dynamic;
    if (HXP.renderMode.has(RenderMode.HARDWARE))
    {
      HXP.rect.x = HXP.rect.y = 0;
      HXP.rect.width = _field.width;
      HXP.rect.height = _field.height;
      source = new AtlasRegion(null, 0, HXP.rect);
      _blit = false;
    }
    else
    {
      source = HXP.createBitmap(width, height, true);
    }
    super(source);

    this.text = text;
    this.x = x;
    this.y = y;
  }

  /** @private Updates the drawing buffer. */
  public override function updateBuffer(clearBefore:Bool = false)
  {
    _field.setTextFormat(_format);
    formatText();

    if (_blit) _field.width = _bufferRect.width;
    _field.width = textWidth = Math.ceil(_field.textWidth + 4);
    _field.height = textHeight = Math.ceil(_field.textHeight + 4);

    if (_blit)
    {
      if (resizable)
      {
        _bufferRect.width = textWidth;
        _bufferRect.height = textHeight;
      }

      if (textWidth > _source.width || textHeight > _source.height)
      {
        _source = HXP.createBitmap(
          Std.int(Math.max(textWidth, _source.width)),
          Std.int(Math.max(textHeight, _source.height)),
          true);

        _sourceRect = _source.rect;
        createBuffer();
      }
      else
      {
        _source.fillRect(_sourceRect, HXP.blackColor);
      }

      if (resizable)
      {
        _field.width = textWidth;
        _field.height = textHeight;
      }

      _source.draw(_field);
      super.updateBuffer(clearBefore);
    }
  }

  public override function render(target:BitmapData, point:Point, camera:Point)
  {
    if (_blit)
    {
      super.render(target, point, camera);
    }
    else
    {
      _field.x = (point.x + x - originX - camera.x * scrollX) * HXP.screen.fullScaleX;
      _field.y = (point.y + y - originY - camera.y * scrollY) * HXP.screen.fullScaleY;
    }
  }

  public override function destroy()
  {
    if (_parent != null)
    {
      _parent.removeChild(_field);
    }
  }

  /**
   * Moves the TextField to the correct sprite layer
   */
  private override function set_layer(value:Int):Int
  {
#if neko
    if (value == null) value = HXP.BASELAYER;
#end
    if (value == layer) return value;
    if (_blit == false)
    {
      destroy();
      _parent = AtlasData.getSpriteByLayer(value);
    }
    return super.set_layer(value);
  }

  /**
   * Text string.
   */
  public var text(default, set_text):String;
  /*
  private function set_text(value:String):String
  {
    if (text == value) return value;
    _field.text = text = value;
    updateBuffer();
    return value;
  }
  */

  /** Text has built-in color interpolation. That means that if you do
   *
   *      var t: Text = new Text("This is *so* cool!");
   *
   *  then the word "so" will be highlighted red.
   *
   *  If you want more colors, you can change the color of the next starred
   *  piece of text like so:
   *
   *      var t: Text = new Text("Lots *of* {0, 255, 0} *colors*.")
   *
   *  In that example, "of" would be red and "colors" would
   *  be green (R = 0, G = 255, B = 0 - those values are taken from the
   *  {0, 255, 0} block).
   *
   *  Finally, if you need an asterick in your text, use "**". For example:
   *
   *      var t: Text = new Text("Just some normal stars: ** **");
   *
   *  The person playing your game would see text that said
   *  "Just some normal stars: * *".
   *
   */
   public function set_text(value: String) : String {
    if (text == value) return value;

    var currentColor: Int = 0xff0000;
    // This regex either matches a *, a **, or something like {255, 255, 0}.
    var e: EReg = ~/\*{1,2}|\{([0-9]+)[\s]*,[\s]*([0-9]+)[\s]*,[\s]*([0-9]+)\}/g;
    var currentPair: ColorSegment = { start: -1, end: -1, color: currentColor };

    var resultText: String;
    var loc: Int = 0;

    pairs = [];

    var lastLoc = 0;

    resultText = e.map(value, function(r: EReg): String {
      var replacement: String = "";

      loc += e.matchedPos().pos - lastLoc;

      if (r.matched(0) == "*") {
        if (currentPair.start == -1) {
          currentPair.start = loc;
        } else {
          currentPair.end = loc;
          pairs.push(currentPair);

          currentColor = 0xff0000;
          currentPair = { start:-1, end: -1, color: currentColor };
        }

        replacement = "";
      } else if (r.matched(0) == "**") {
        replacement = "*";
      } else {
        var A:Int = 255;
        var R:Int = Std.parseInt(r.matched(1));
        var G:Int = Std.parseInt(r.matched(2));
        var B:Int = Std.parseInt(r.matched(3));
        currentColor = (A & 0xFF) << 24 | (R & 0xFF) << 16 | (G & 0xFF) << 8 | (B & 0xFF);

        currentPair.color = currentColor;
        replacement = "";

      }
      lastLoc = e.matchedPos().pos + r.matched(0).length;

      return replacement;
    });

    _field.text = resultText;
    updateBuffer();
    return resultText;
  }

  function formatText(): Void {
    var oldColor: Int = _format.color;

    _field.setTextFormat(_format);

    for (pair in pairs) {
      _format.color = pair.color;

      _field.setTextFormat(_format, pair.start, pair.end);
    }

    _format.color = oldColor;
  }



  /**
   * Font family.
   */
  public var font(default, set_font):String;
  private function set_font(value:String):String
  {
    if (font == value) return value;
#if nme
    value = nme.Assets.getFont(value).fontName;
#end
    _format.font = font = value;
    updateBuffer();
    return value;
  }

  /**
   * Font size.
   */
  public var size(default, set_size):Int;
  private function set_size(value:Int):Int
  {
    if (size == value) return value;
    _format.size = size = value;
    updateBuffer();
    return value;
  }

  // Text information.
  private var _field:TextField;
  private var _format:TextFormat;
  private var _parent:Sprite;
}