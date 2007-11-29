import ua.com.syo.battlecity.components.NESTextField;
import ua.com.syo.battlecity.common.AsBroadcasterI;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 4 �� 2007
 */
class ua.com.syo.battlecityeditor.view.ConfirmDialog extends MovieClip implements AsBroadcasterI
{
	private var back: MovieClip;
	private var infoText: NESTextField;
	private var okText: NESTextField;
	private var cancelText: NESTextField;
	
	public static function create(clip: MovieClip,name: String,depth: Number,initObject: Object): ConfirmDialog
	{
		registerClass("__Packages.ua.com.syo.battlecityeditor.view.ConfirmDialog", ConfirmDialog);
		var instance: MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecityeditor.view.ConfirmDialog", name, depth, initObject);
		var classInstance: ConfirmDialog = ConfirmDialog(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance(): Void
	{
		this.back = this.attachMovie("rectangle", "back", this.getNextHighestDepth(), {_width:256, _height:256, _alpha:70});
		
		this.infoText = NESTextField.create(this, "infoText", this.getNextHighestDepth());
		this.cancelText = NESTextField.create(this, "cancel", this.getNextHighestDepth());
		this.okText = NESTextField.create(this, "okText", this.getNextHighestDepth());
	}
	
	public function init(): Void
	{
		AsBroadcaster.initialize(this);
		
		this.back.onPress = function():Void 
		{
		};
		this.back.useHandCursor = false;
		
		
		this.infoText.init(70, 100, "save stage?", 0xAAAAAA, false);
		this.okText.init(70, 120, "yes", 0xFFFFFF, true);
		this.cancelText.init(110, 120, "cancel", 0xFFFFFF, true);
		
		var $scope: ConfirmDialog = this;
		this.cancelText.onPress = function(): Void
		{
			$scope.confirm("cancel");
		};
		
		this.cancelText.onRollOver = function(): Void
		{
			MovieClip(this)._alpha = 50;
		};
		
		this.cancelText.onRollOut = function(): Void
		{
			MovieClip(this)._alpha = 100;
		};
		
		this.cancelText.onDragOut = function(): Void
		{
			MovieClip(this)._alpha = 100;
		};
		
		
		this.okText.onPress = function(): Void
		{
			$scope.confirm("ok");
		};
		
		this.okText.onRollOver = function(): Void
		{
			MovieClip(this)._alpha = 50;
		};
		
		this.okText.onRollOut = function(): Void
		{
			MovieClip(this)._alpha = 100;
		};
		
		this.okText.onDragOut = function(): Void
		{
			MovieClip(this)._alpha = 100;
		};
	}
	
	private function confirm(type: String): Void
	{
		broadcastMessage("onConfirm", type);
	}
	
	public function destroy(): Void
	{
		this.removeMovieClip();
	}
	
	function addListener(listenerObj: Object): Boolean 
	{
		return null;
	}
	
	function broadcastMessage(eventName: String): Void 
	{
	}
	
	function removeListener(listenerObj: Object): Boolean 
	{
		return null;
	}
}