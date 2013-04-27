package nme;


import nme.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("gfx/debug/console_debug.png", nme.NME_gfx_debug_console_debug_png);
			type.set ("gfx/debug/console_debug.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_logo.png", nme.NME_gfx_debug_console_logo_png);
			type.set ("gfx/debug/console_logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_output.png", nme.NME_gfx_debug_console_output_png);
			type.set ("gfx/debug/console_output.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_pause.png", nme.NME_gfx_debug_console_pause_png);
			type.set ("gfx/debug/console_pause.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_play.png", nme.NME_gfx_debug_console_play_png);
			type.set ("gfx/debug/console_play.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_step.png", nme.NME_gfx_debug_console_step_png);
			type.set ("gfx/debug/console_step.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/preloader/haxepunk.png", nme.NME_gfx_preloader_haxepunk_png);
			type.set ("gfx/preloader/haxepunk.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("font/04B_03__.ttf", nme.NME_font_04b_03___ttf);
			type.set ("font/04B_03__.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("gfx/bullet.png", nme.NME_gfx_bullet_png);
			type.set ("gfx/bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/player.png", nme.NME_gfx_player_png);
			type.set ("gfx/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/tilesheet.png", nme.NME_gfx_tilesheet_png);
			type.set ("gfx/tilesheet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("maps/map.tmx", nme.NME_maps_map_tmx);
			type.set ("maps/map.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			className.set ("font/04B_03__.ttf", nme.NME_font_5);
			type.set ("font/04B_03__.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_gfx_debug_console_debug_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_logo_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_output_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_pause_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_play_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_step_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_preloader_haxepunk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_font_04b_03___ttf extends nme.text.Font { }
class NME_gfx_bullet_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_player_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_tilesheet_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_maps_map_tmx extends nme.utils.ByteArray { }
class NME_font_5 extends nme.text.Font { }
