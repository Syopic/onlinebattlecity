import ua.com.syo.battlecity.components.NESNumField;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 9 ��� 2007
 */
class ua.com.syo.battlecity.screens.stage.InfoPanelView extends MovieClip 
{
	private var enemyLeftPanel:MovieClip;
	private var infoBlock:MovieClip;
	private var lifes_nf:NESNumField;
	private var stages_nf:NESNumField;
	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):InfoPanelView
	{
		registerClass("__Packages.ua.com.syo.battlecity.screens.stage.InfoPanelView",InfoPanelView);
		var instance:MovieClip=clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.stage.InfoPanelView",name,depth,initObject);
		var classInstance:InfoPanelView=InfoPanelView(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance():Void
	{
		this.enemyLeftPanel=this.createEmptyMovieClip("enemyLeftPanel", this.getNextHighestDepth());
		this.enemyLeftPanel._x=233;
		this.enemyLeftPanel._y=17;
		var incr:Number = 0;
		for (var i:Number = 0; i<10; i++) {
			for (var j:Number = 0; j<2; j++) {
				incr++;
				this.enemyLeftPanel.attachMovie("enemyIco", "ei"+incr, incr, {_x:j*8, _y:i*8});
			}
		}
		
		this.infoBlock=this.attachMovie("infoBlock", "infoBlock", this.getNextHighestDepth(), {_x:230, _y:128});
		this.lifes_nf=NESNumField.create(this, "lifes_nf", this.getNextHighestDepth());
		this.stages_nf=NESNumField.create(this, "stages_nf", this.getNextHighestDepth());
		
	}
		
	public function init(): Void
	{
		this.lifes_nf.init(240, 137, 2, "left", 0x000000);
		this.stages_nf.init(238, 192, 2, "left", 0x000000);
	}
	
	public function setEnemyLeft(enemyLeftNum:Number): Void
	{
		var incr:Number = 0;
		for (var i:Number = 0; i<10; i++) {
			for (var j:Number = 0; j<2; j++) {
				incr++;
				MovieClip(this.enemyLeftPanel["ei"+incr])._visible=!(incr>enemyLeftNum);
			}
		}
	}
	
	public function setLifes(lifesNum:Number): Void
	{
		this.lifes_nf.setValue(lifesNum.toString());
	}	
	
	public function setStageNum(stageNum:Number): Void
	{
		this.stages_nf.setValue(stageNum.toString());
	}	
}