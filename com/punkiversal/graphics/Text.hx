package com.punkiversal.graphics;

import haxe.ds.StringMap;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;

import com.punkiversal.PV;
import com.punkiversal.Graphic;
import com.punkiversal.graphics.atlas.Atlas;

/**
 * Text option including the font, size, color...
 */
typedef TextOptions = {
	/** Optional. The font to use. Default value is com.punkiversal.PV.defaultFont. */
	@:optional var font:String;
	/** Optional. The font size. Default value is 16. */
	@:optional var size:Int;	
	/** Optional. The aligment of the text. Default value is left. */
#if (flash || js)
	@:optional var align:TextFormatAlign;
#else
	@:optional var align:String;
#end
	/** Optional. Automatic word wrapping. Default value is false. */
	@:optional var wordWrap:Bool;
	/** Optional. If the text field can automatically resize if its contents grow. Default value is true. */
	@:optional var resizable:Bool;
	/** Optional. The color of the text. Default value is white. */
	@:optional var color:Int;
	/** Optional. Vertical space between lines. Default value is 0. */
	@:optional var leading:Int;
	/** Optional. If the text field uses a rich text string. */
	@:optional var richText:Bool;
};

/**
 * Abstract representing either a `TextFormat` or a `TextOptions`.
 * 
 * Conversion is automatic, no need to use this.
 */
abstract StyleType(TextFormat)
{
	private function new(format:TextFormat) this = format;
	@:dox(hide) @:to public function toTextformat():TextFormat return this;

	@:dox(hide) @:from public static inline function fromTextFormat(format:TextFormat) return new StyleType(format);
	@:dox(hide) @:from public static inline function fromTextOptions(object:TextOptions) return fromDynamic(object);
	@:dox(hide) @:from public static inline function fromDynamic(object:Dynamic)
	{
		var format = new TextFormat();
		var fields = Type.getInstanceFields(TextFormat);
		
		for (key in Reflect.fields(object))
		{
			if (PV.indexOf(fields, key) > -1)
			{
				Reflect.setField(format, key, Reflect.field(object, key));
			}
			else
			{
				throw '"' + key + '" is not a TextFormat property';
			}
		}
		return new StyleType(format);
	}
}

/**
 * Used for drawing text using embedded fonts.
 */
class Text extends Image
{


}
