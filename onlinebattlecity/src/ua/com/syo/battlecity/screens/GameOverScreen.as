import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.components.NESTextField;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.components.NESNumField;
import ua.com.syo.battlecity.sound.AllSounds;

/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 16 ��� 2007
 */
class ua.com.syo.battlecity.screens.GameOverScreen extends MovieClip implements AsBroadcasterI {
	private var canvas_mc : MovieClip;
	private var bricks_mc : MovieClip;
	private var goText1 : NESTextField;
	private var goText2 : NESTextField;
	private var hiScore : NESTextField;
	private var hiScore_num : NESNumField;

	public static function create(clip : MovieClip,name : String,depth : Number,initObject : Object) : GameOverScreen {
		registerClass("__Packages.ua.com.syo.battlecity.screens.GameOverScreen", GameOverScreen);
		var instance : MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.GameOverScreen", name, depth, initObject);
		var classInstance : GameOverScreen = GameOverScreen(instance);
		classInstance.buildInstance();
		return classInstance;
	}

	public function buildInstance() : Void {
		this.attachMovie("rectangle", "rectangle", this.getNextHighestDepth());
		this.bricks_mc = this.createEmptyMovieClip("bricks", this.getNextHighestDepth());
		this.canvas_mc = this.createEmptyMovieClip("canvas", this.getNextHighestDepth());
		this.goText1 = NESTextField.create(this.canvas_mc, "goText1", this.canvas_mc.getNextHighestDepth());
		this.goText2 = NESTextField.create(this.canvas_mc, "goText2", this.canvas_mc.getNextHighestDepth());
		
		this.hiScore = NESTextField.create(this.canvas_mc, "hiScore", this.canvas_mc.getNextHighestDepth());
		this.hiScore_num = NESNumField.create(this.canvas_mc, "hiScore_num", this.canvas_mc.getNextHighestDepth());
	}

	public function init() : Void {
		AsBroadcaster.initialize(this);
		
		for (var i : Number = 0;i < 32; i++) {
			for (var j : Number = 0;j < 32; j++) {
				this.bricks_mc.attachMovie("brick", "b" + i * 100 + j, this.bricks_mc.getNextHighestDepth(), {_x:i * 8, _y:j * 8});
			}
		}
		
		this.goText1.init(0, 0, "game", 0xD82800);
		this.goText2.init(0, 0, "over", 0xD82800);
		
		this.goText1._xscale = this.goText1._yscale = this.goText2._xscale = this.goText2._yscale = 400;
		
		this.goText1._x = 64;
		this.goText1._y = 64;
		
		this.goText2._x = 64;
		this.goText2._y = 116;
		
		this.bricks_mc.setMask(this.canvas_mc);
		
		this.runDelay();
		
		AllSounds.getInstance().playGameover();
	}

	private function runDelay() : Void {
		var delay : Number = 100;
		var $scope : GameOverScreen = this;
		this.onEnterFrame = function():Void {
			delay--;
			if (delay < 0) {
				if (GlobalStorage.hiScore < GlobalStorage.score) {
					$scope.showHiScore();
				}
				else {
					$scope.close();
				}
			}
		};	
	}

	private function showHiScore() : Void {
		this.goText1.removeMovieClip();
		this.goText2.removeMovieClip();
		
		this.hiScore.init(0, 0, "hiscore", 0xFFFFFF);
		this.hiScore_num.init(0, 0, 7, "right", 0xFFFFFF);
		this.hiScore_num.setValue(GlobalStorage.score.toString());
		
		this.hiScore._xscale = this.hiScore._yscale = this.hiScore_num._xscale = this.hiScore_num._yscale = 400;
		
		this.hiScore._x = 21;
		this.hiScore._y = 48;
		this.hiScore_num._x = 21;
		this.hiScore_num._y = 96;
		
		this.bricks_mc.setMask(this.canvas_mc);
		
		AllSounds.getInstance().playHi();
		
		var delay : Number = 350;
		var inDelay : Number = 4;
		var $scope : GameOverScreen = this;
		this.onEnterFrame = function():Void {
			var my_color : Color;
			var myColorTransform : Object;
			//
			delay--;
			inDelay--;
			if (delay < 0) {
				$scope.close();
			}
			else
			if (inDelay == 2) {
				my_color = new Color($scope.bricks_mc);
				myColorTransform = { ra: 100, rb: -33, ga: 100, gb: 32, ba: 100, bb: 143, aa: 100, ab: 0};
				my_color.setTransform(myColorTransform);
			}
			else
			if (inDelay <= 0) {
				my_color = new Color($scope.bricks_mc);
				myColorTransform = { ra: 100, rb: -65, ga: 100, gb: 13, ba: 100, bb: 27, aa: 100, ab: 0};
				my_color.setTransform(myColorTransform);
				inDelay = 4;
			}
		};	
	}

	private function close() : Void {
		this.broadcastMessage("onCloseGameOverScreen");
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