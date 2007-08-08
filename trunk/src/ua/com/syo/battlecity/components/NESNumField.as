/**
 * @author Krivosheya Sergey
 * www: http://syo.com.ua
 * email: syopic@gmail.com
 * 2006
 */
/**
 * Numfields in NES style
 */
class ua.com.syo.battlecity.components.NESNumField extends MovieClip 
{
	private var canvas_mc: MovieClip;
	private var maxChar: Number;
	private var align: String = "left";
	private var value: Number;
	
	public static function create(clip: MovieClip,name: String,depth: Number,initObject: Object): NESNumField
	{
		registerClass("__Packages.ua.com.syo.battlecity.components.NESNumField", NESNumField);
		var instance: MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.components.NESNumField", name, depth, initObject);
		var classInstance: NESNumField = NESNumField(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance(): Void
	{
		this.canvas_mc = this.createEmptyMovieClip("canvas_mc", this.getNextHighestDepth());
	}
	
	public function init(x: Number, y: Number, maxChar: Number, align: String, color: Number): Void
	{
		this.maxChar = maxChar;
		this.align = align;
		
		for (var i: Number = 0;i < this.maxChar; i++)
		{
			this.canvas_mc.attachMovie("numeric", "num_" + i, this.canvas_mc.getNextHighestDepth(), {_x:i * 8 + x, _y:y});
			// Set color
			var char_color: Color = new Color(canvas_mc["num_" + i]);
			char_color.setRGB(color);
		}
	}
	
	/**
	 * Set value
	 */
	public function setValue(value: String): Void 
	{
		this.value = Number(value);
		var shortMc: MovieClip;
		var startCharPosition: Number = this.maxChar - value.length;
		
		var i: Number;
		//		clear
		for (i = 0;i < maxChar; i++)
		{
			shortMc = this.canvas_mc["num_" + i];
			shortMc.gotoAndStop("n");
		}
		
		for (i = 0;i < value.length; i++)
		{
			var char: String = value.slice(i, i + 1);
			if (this.align == "right") 
			{
				shortMc = this.canvas_mc["num_" + (startCharPosition + i)];
			} else 
			{
				shortMc = this.canvas_mc["num_" + i];
			}
			shortMc.gotoAndStop("n" + char);
		}
	} 
	
	public function getValue(): Number
	{
		return this.value;
	}
}