/**
 * @author Krivosheya Sergey
 * www: http://syo.com.ua
 * email: syopic@gmail.com
 * 2006
 */
import ua.com.syo.battlecity.components.NESTextField;
import ua.com.syo.battlecity.data.DataLabels;
import ua.com.syo.battlecity.components.NESNumField;
/*
 * View preloader screen
 */
class ua.com.syo.battlecityeditor.screens.Preloader extends MovieClip 
{
	private var loading_tf: NESTextField;
	private var proc_nf: NESNumField;
	
	public static function create(clip: MovieClip,name: String,depth: Number,initObject: Object): Preloader
	{
		registerClass("__Packages.ua.com.syo.battlecityeditor.screens.Preloader", Preloader);
		var instance: MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecityeditor.screens.Preloader", name, depth, initObject);
		var classInstance: Preloader = Preloader(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance(): Void
	{
		this.loading_tf = NESTextField.create(this, "loading_tf", this.getNextHighestDepth());
		this.proc_nf = NESNumField.create(this, "proc_nf", this.getNextHighestDepth());
	}
	
	public function init(): Void
	{
		this.loading_tf.init(82, 110, DataLabels.PRELOADER_STATUS, 0x000000);
		this.proc_nf.init(145, 110, 3, "right", 0xFFFFFF);
	}
	
	/**
	 * Update procent value
	 */
	public function update(loaded: Number, total: Number): Void 
	{
		var proc: Number = loaded / total * 100;
		this.proc_nf.setValue(proc.toString());
	}
	
	/**
	 * Remove preloader
	 */
	public function remove(): Void 
	{
		this.removeMovieClip();
	}
}