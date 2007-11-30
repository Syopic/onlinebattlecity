/**
 * @author Krivosheya Sergey
 * www: http://syo.com.ua
 * email: syopic@gmail.com
 * 2006
 */
import ua.com.syo.battlecity.components.NESTextField;
import ua.com.syo.battlecity.data.DataLabels;
import ua.com.syo.battlecity.components.NESNumField;
import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.data.GlobalStorage;

/**
 * View splash menu with title
 */
class ua.com.syo.battlecity.screens.SplashMenu extends MovieClip implements AsBroadcasterI {

	private var canvas_mc : MovieClip;
	private var hiScore : NESNumField;
	private var onePlHiScore : NESNumField;
	private var onePl_tf : NESTextField;
	private var onePlHi_tf : NESTextField;
	private var onePlayer_tf : NESTextField;
	private var twoPlayer_tf : NESTextField;
	private var construction_tf : NESTextField;
	private var namcoCopy_tf : NESTextField;
	private var allRight_tf : NESTextField;
	private var syoCopy_tf : NESTextField;

	private var version_tf : NESTextField;

	private var bulletTank : MovieClip;

	private var closerTop : MovieClip;
	private var closerBottom : MovieClip;

	public static function create(clip : MovieClip,name : String,depth : Number,initObject : Object) : SplashMenu {
		registerClass("__Packages.ua.com.syo.battlecity.screens.SplashMenu", SplashMenu);
		var instance : MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.SplashMenu", name, depth, initObject);
		var classInstance : SplashMenu = SplashMenu(instance);
		SplashMenu(instance).buildInstance();
		return classInstance;
	}

	public function buildInstance() : Void {
		
		this.attachMovie("rectangle", "rectangle", this.getNextHighestDepth());
		
		this.canvas_mc = createEmptyMovieClip("canvas_mc", this.getNextHighestDepth());
		
		this.bulletTank = this.attachMovie("bulletTank", "bulletTank", this.getNextHighestDepth());
		this.bulletTank._visible = false;
		this.bulletTank._x = 63;
		this.bulletTank._y = 123;
		
		this.closerTop = this.attachMovie("closer", "closerTop", this.getNextHighestDepth());
		this.closerBottom = this.attachMovie("closer", "closerBottom", this.getNextHighestDepth());
		this.closerTop._y = -121;
		this.closerBottom._y = 233;
		
		this.canvas_mc.attachMovie("gameTitle", "gameTitle", this.canvas_mc.getNextHighestDepth(), {_x:28, _y:40});
		
		this.hiScore = NESNumField.create(this.canvas_mc, "hiScore", this.canvas_mc.getNextHighestDepth());
		this.onePlHiScore = NESNumField.create(this.canvas_mc, "onePlHiScore", this.canvas_mc.getNextHighestDepth());
		
		this.onePl_tf = NESTextField.create(this.canvas_mc, "onePl_tf", this.canvas_mc.getNextHighestDepth());
		this.onePlHi_tf = NESTextField.create(this.canvas_mc, "onePlHi_tf", this.canvas_mc.getNextHighestDepth());
		this.onePlayer_tf = NESTextField.create(this.canvas_mc, "onePlayer_tf", this.canvas_mc.getNextHighestDepth());
		this.twoPlayer_tf = NESTextField.create(this.canvas_mc, "twoPlayer_tf", this.canvas_mc.getNextHighestDepth());
		this.construction_tf = NESTextField.create(this.canvas_mc, "construction_tf", this.canvas_mc.getNextHighestDepth());
		this.namcoCopy_tf = NESTextField.create(this.canvas_mc, "namcoCopy_tf", this.canvas_mc.getNextHighestDepth());
		this.allRight_tf = NESTextField.create(this.canvas_mc, "allRight_tf", this.canvas_mc.getNextHighestDepth());
		this.syoCopy_tf = NESTextField.create(this.canvas_mc, "syoCopy_tf", this.canvas_mc.getNextHighestDepth());
		
		this.version_tf = NESTextField.create(this.canvas_mc, "version_tf", this.canvas_mc.getNextHighestDepth());
	}

	public function init() : Void {
		AsBroadcaster.initialize(this);
		
		this.onePl_tf.init(17, 16, DataLabels.SPLASH_ONE_PL, 0xFFFFFF);
		this.onePlHi_tf.init(88, 16, DataLabels.SPLASH_ONE_PL_HI, 0xFFFFFF);
		this.onePlayer_tf.init(90, 128, DataLabels.SPLASH_ONE_PLAYER, 0xFFFFFF);
		this.twoPlayer_tf.init(90, 144, DataLabels.SPLASH_TWO_PLAYER, 0x999999);
		this.construction_tf.init(90, 160, DataLabels.SPLASH_CONSTRUCTION, 0x999999);
		this.namcoCopy_tf.init(33, 176, DataLabels.SPLASH_NAMCO_COPYRIGHT, 0xFFFFFF);
		this.allRight_tf.init(49, 192, DataLabels.SPLASH_ALL_RIGHT, 0xFFFFFF);
		this.syoCopy_tf.init(49, 208, DataLabels.SPLASH_SYO_COPYRIGHT, 0xFFFFFF, true);
		
		this.version_tf.init(180, 16, DataLabels.SPLASH_VERSION, 0x666666);

		this.hiScore.init(120, 16, 8, "left", 0xFFFFFF);
		this.hiScore.setValue(GlobalStorage.hiScore.toString());
		
		this.onePlHiScore.init(33, 16, 6, "right", 0xFFFFFF);
		this.onePlHiScore.setValue(GlobalStorage.plOneHiScore.toString());
		
		this.canvas_mc._y = 232;
		
		this.moveUp();

		Key.addListener(this);
		
		this.syoCopy_tf.onPress = function(): Void {
			getURL("http://syo.com.ua", "_blank");
		};
	}

	/**
	 *  Move up splash menu
	 */
	private function moveUp() : Void {
		var $scope : SplashMenu = this;
		this.onEnterFrame = function():Void {
			if ($scope.canvas_mc._y > 0) { 
				$scope.canvas_mc._y--;
			} else {
				$scope.showSelector();
				delete $scope.onEnterFrame;
			}
		};		
	}

	public function onKeyDown() : Void {
		//		TODO add select other item of menu
		if(Key.isDown(Key.SPACE)) {
			if (canvas_mc._y == 0) {
				this.closeSplash();
				Key.removeListener(this);
			}
			else {
				this.showSelector();
			}
		}
	}	

	private  function showSelector() : Void {
		this.bulletTank._visible = true;
		canvas_mc._y = 0;
	} 

	private function closeSplash() : Void {
		var $scope : SplashMenu = this;
		this.onEnterFrame = function():Void {
			if ($scope.closerTop._y < -2) { 
				$scope.closerTop._y += 5;
				$scope.closerBottom._y -= 5;
			} else {
				$scope.onClose();
				delete $scope.onEnterFrame;
			}
		};
	}

	private function onClose() : Void {
		this.broadcastMessage("onClose");
	}

	public function destroy() : Void {
		this.removeMovieClip();
	}	

	
	function addListener() : Boolean {
		return null;
	}

	function broadcastMessage(eventName : String) : Void {
	}

	function removeListener() : Boolean {
		return null;
	}
}