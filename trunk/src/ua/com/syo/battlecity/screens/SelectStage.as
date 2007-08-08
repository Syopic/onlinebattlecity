import ua.com.syo.battlecity.components.NESTextField;
import ua.com.syo.battlecity.components.NESNumField;
import ua.com.syo.battlecity.data.DataLabels;
import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.data.GlobalStorage;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 7 ��� 2007
 */
class ua.com.syo.battlecity.screens.SelectStage extends MovieClip  implements AsBroadcasterI 
{

	private var label_tf:NESTextField;
	private var stage_nf:NESNumField;
	
	private var load_tf:NESTextField;
	private var ad_tf:NESTextField;
	
	private var currentStage:Number;
	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):SelectStage
	{
		registerClass("__Packages.ua.com.syo.battlecity.screens.SelectStage",SelectStage);
		var instance:MovieClip=clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.SelectStage",name,depth,initObject);
		var classInstance:SelectStage=SelectStage(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance():Void
	{
		this.label_tf=NESTextField.create(this, "label_tf", this.getNextHighestDepth());
		this.stage_nf=NESNumField.create(this, "stage_nf", this.getNextHighestDepth());
		
		this.load_tf=NESTextField.create(this, "load_tf", this.getNextHighestDepth());
		this.ad_tf=NESTextField.create(this, "ad_tf", this.getNextHighestDepth());
	}
	
	public function init(stage:Number):Void
	{
		this.currentStage=stage;
		AsBroadcaster.initialize(this);
		
		this.label_tf.init(96, 104, DataLabels.STAGE, 0x000000);
		this.stage_nf.init(143, 104, 3, "left", 0x000000);
		this.stage_nf.setValue(currentStage.toString());
		
		this.ad_tf.init(8, 220, DataLabels.LOAD_AD, 0x555555, true);
		
		this.ad_tf.onPress=function(): Void
		{
			getURL("http://battlecity.com.ua", "_blank");
		};
		
		Key.addListener(this);
	}
	
	public function onKeyDown():Void
	{
		if(Key.isDown(Key.UP))
		{
			this.currentStage++;
			if (this.currentStage>GlobalStorage.stagesNum)
			{
				this.currentStage=1;
			}
			setStage(this.currentStage);
		}
		if(Key.isDown(Key.DOWN))
		{
			this.currentStage--;
			if (this.currentStage<1)
			{
				this.currentStage=GlobalStorage.stagesNum;
			}
			setStage(this.currentStage);
		}
		if(Key.isDown(Key.SPACE))
		{
			Key.removeListener(this);
			this.broadcastMessage("onSelectStage", this.currentStage);
		}
	}	
	
	public function destroy(): Void
	{
		this.removeMovieClip();
	}
	
	public function setStage(stage:Number): Void
	{
		this.stage_nf.setValue(stage.toString());
	}
	
	public function showLoader(): Void
	{
		this.label_tf._visible=false;
		this.stage_nf._visible=false;
		this.load_tf.init(80, 104, DataLabels.LOAD_STAGE, 0x000000);
		
	}
	
	function addListener(listenerObj : Object) : Boolean {
		return null;
	}

	function broadcastMessage(eventName : String) : Void {
	}

	function removeListener(listenerObj : Object) : Boolean {
		return null;
	}

}