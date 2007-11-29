import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecityeditor.screens.EditPageScreen;
import ua.com.syo.battlecityeditor.model.Model;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 28 ��� 2007
 */
class ua.com.syo.battlecityeditor.view.UIManager extends MovieClip implements AsBroadcasterI 
{
	public static var className:String="__Prototype.ua.com.syo.battlecityeditor.view.UIManager";
	public var classFunction:Function=ua.com.syo.battlecityeditor.view.UIManager;
	
	private static var instance : UIManager;
	private var editPage:EditPageScreen;
	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):UIManager
	{
		if(UIManager.instance==undefined)
		{
			registerClass("__Packages.ua.com.syo.battlecityeditor.view.UIManager",UIManager);
			var mc : MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecityeditor.view.UIManager",name,depth,initObject);
			UIManager.instance=UIManager(mc);
			UIManager.instance.buildInstance();
			return UIManager.instance;
		}
		else
		{
			return UIManager.instance;
		}
	}
	public function buildInstance():Void
	{
	}
	/**
	 * returns the singleton;
	 */
	public static function getInstance() : UIManager
	{
		if (instance == null)
		{
			instance = new UIManager();
		}
		return instance;
	}
	
	public function init(): Void
	{
		AsBroadcaster.initialize(this);
	}
	
	public function showEditPage(): Void
	{
		
		this.editPage=EditPageScreen.create(this, "editPage", this.getNextHighestDepth());
		this.editPage.init();
		this.editPage.addListener(this);
	}
	
	private function onDrawStage(stageMap_array:Array, tanksStr:String): Void
	{
		Model.getInstance().onDrawStage(stageMap_array, tanksStr);
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