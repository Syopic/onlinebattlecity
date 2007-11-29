/**
 * @author Krivosheya Sergey
 * www: http://syo.com.ua
 * email: syopic@gmail.com
 * 2006
 */
/**
 * Textfields for label text in NES style
 */
class ua.com.syo.battlecity.components.NESTextField extends MovieClip 
{
	private var canvas_mc: MovieClip;
	
	public static function create(clip: MovieClip,name: String,depth: Number,initObject: Object): NESTextField
	{
		registerClass("__Packages.ua.com.syo.battlecity.components.NESTextField", NESTextField);
		var instance: MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.components.NESTextField", name, depth, initObject);
		var classInstance: NESTextField = NESTextField(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance(): Void
	{
		this.canvas_mc = this.createEmptyMovieClip("canvas_mc", this.getNextHighestDepth());
		this.canvas_mc._visible = false;
	}
	
	public function init(x: Number, y: Number, text: String, color: Number, isBack: Boolean): Void
	{
		this.canvas_mc._visible = true;
		for (var i: Number = 0;i < text.length; i++)
		{
			var char: String = text.slice(i, i + 1);
			if (char != " ") 
			{
				if (isBack)
				{
					canvas_mc.attachMovie("rectangle", "rectangle" + i, canvas_mc.getNextHighestDepth(), {_x:i * 8 + x, _y:y, _width:8, _height:8, _alpha:0});
				}
				canvas_mc.attachMovie(text.slice(i, i + 1), "char_" + i, canvas_mc.getNextHighestDepth(), {_x:i * 8 + x, _y:y});
				
				// Set color
				var char_color: Color = new Color(canvas_mc["char_" + i]);
				char_color.setRGB(color);
			}
		}
	}
}