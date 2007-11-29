import ua.com.syo.battlecityeditor.view.ConfirmDialog;
import ua.com.syo.battlecity.common.AsBroadcasterI;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 28 ��� 2007
 */
class ua.com.syo.battlecityeditor.screens.EditPageScreen extends MovieClip implements AsBroadcasterI
{
	private var blackBack: MovieClip;
	private var rollOverBack: MovieClip;
	private var brick_btn: MovieClip;
	private var ferum_btn: MovieClip;
	private var garden_btn: MovieClip;
	private var ice_btn: MovieClip;
	private var water_btn: MovieClip;
	private var clear_btn: MovieClip;
	private var save_btn: MovieClip;
	private var border: MovieClip;
	private var mouseBorder: MovieClip;
	private var pice: MovieClip;
	private var buttons_array: Array;
	private var tanks_array: Array;
	private var isDraw: Boolean;
	private var isLockGUI: Boolean;
	private var mapCanvas: MovieClip;
	private var currentPice: Number = 0;
	private var pice_array: Array = new Array("brick", "ferum", "garden", "ice", "water", "clear");
	private var type_array: Array = new Array();
	private var defaultTanks_array: Array = new Array(1, 1, 2, 2, 1, 5, 3, 3, 2, 2, 3, 7, 1, 1, 2, 2, 3, 7, 4, 4);
	private var confirmDialog: ConfirmDialog;
	public var stageMap_array: Array = new Array();
	
	public static function create(clip: MovieClip,name: String,depth: Number,initObject: Object): EditPageScreen
	{
		registerClass("__Packages.ua.com.syo.battlecityeditor.screens.EditPageScreen", EditPageScreen);
		var instance: MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecityeditor.screens.EditPageScreen", name, depth, initObject);
		var classInstance: EditPageScreen = EditPageScreen(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance(): Void
	{
		this.blackBack = this.attachMovie("rectangle", "rectangle", this.getNextHighestDepth(), {_x:8, _y:8});
		this.rollOverBack = this.attachMovie("rectangle", "rectangle", this.getNextHighestDepth(), {_x:8, _y:8, _width:204, _height:204});
		
		this.brick_btn = this.attachMovie("brick_btn", "brick_btn", this.getNextHighestDepth(), {_x:10, _y:227});
		this.ferum_btn = this.attachMovie("ferum_btn", "ferum_btn", this.getNextHighestDepth(), {_x:34, _y:227});
		this.garden_btn = this.attachMovie("garden_btn", "garden_btn", this.getNextHighestDepth(), {_x:58, _y:227});
		this.ice_btn = this.attachMovie("ice_btn", "ice_btn", this.getNextHighestDepth(), {_x:82, _y:227});
		this.water_btn = this.attachMovie("water_btn", "water_btn", this.getNextHighestDepth(), {_x:106, _y:227});
		this.clear_btn = this.attachMovie("clear_btn", "clear_btn", this.getNextHighestDepth(), {_x:130, _y:227});
		
		this.save_btn = this.attachMovie("save_btn", "save_btn", this.getNextHighestDepth(), {_x:168, _y:227});
		
		this.mapCanvas = createEmptyMovieClip("canvas", this.getNextHighestDepth());
		
		this.border = this.attachMovie("border", "border", this.getNextHighestDepth());
	}
	
	public function init(): Void
	{
		var i: Number;
		//		
		AsBroadcaster.initialize(this);
		
		this.stageMap_array = new Array(26);
		for ( i = 0;i < 26; i++) 
		{
			this.stageMap_array[i] = new Array(26);
		}
		
		this.type_array["brick"] = "b";
		this.type_array["ferum"] = "f";
		this.type_array["garden"] = "g";
		this.type_array["ice"] = "i";
		this.type_array["water"] = "w";
		this.type_array["clear"] = "_";
		
		this.isDraw = false;
		this.isLockGUI = false;
		
		this.buttons_array = new Array();
		this.buttons_array.push(this.brick_btn);
		this.buttons_array.push(this.ferum_btn);
		this.buttons_array.push(this.garden_btn);
		this.buttons_array.push(this.ice_btn);
		this.buttons_array.push(this.water_btn);
		this.buttons_array.push(this.clear_btn);
		this.buttons_array.push(this.save_btn);
		
		this.setCurrentSprite(this.brick_btn);
		
		for (i = 0;i < this.buttons_array.length; i++)
		{
			var $scope: EditPageScreen = this;
			MovieClip(this.buttons_array[i])["type"] = i;
			MovieClip(this.buttons_array[i]).onRollOver = function():Void
			{
				MovieClip(this)._alpha = 50;
			};
			MovieClip(this.buttons_array[i]).onRollOut = function():Void
			{
				MovieClip(this)._alpha = 100;
			};
			
			MovieClip(this.buttons_array[i]).onDragOut = function():Void
			{
				MovieClip(this)._alpha = 100;
			};
			
			MovieClip(this.buttons_array[i]).onPress = function():Void
			{
				$scope.currentPice = MovieClip(this)["type"];
				$scope.setCurrentSprite(MovieClip(this));
			};
		}
		var incr: Number = 0;
		for (i = 0;i < 10; i++)
		{
			for (var j: Number = 0;j < 2; j++)
			{
				incr++;	
				this.tanks_array[incr] = this.attachMovie("tank", "tank" + incr, this.getNextHighestDepth(), {_x:220 + j * 18, _y:15 + i * 20});
				MovieClip(this["tank" + incr])["type"] = this.defaultTanks_array[incr - 1];
				if (MovieClip(this["tank" + incr])["type"] > 4)
				{
					MovieClip(this["tank" + incr]).gotoAndStop(MovieClip(this["tank" + incr])["type"] - 4);
					var c1: Color = new Color(MovieClip(this["tank" + incr])["black_mc"]);
					var c2: Color = new Color(MovieClip(this["tank" + incr])["silver_mc"]);
					var c3: Color = new Color(MovieClip(this["tank" + incr])["white_mc"]);	
					c1.setRGB(0x8C0074);
					c2.setRGB(0xD82800);
					c3.setRGB(0xFCFCFC);
				}
				else
				{
					MovieClip(this["tank" + incr]).gotoAndStop(MovieClip(this["tank" + incr])["type"]);
				}
				
				MovieClip(this["tank" + incr]).onRollOver = function():Void
				{
					MovieClip(this)._alpha = 70;			
				};
				MovieClip(this["tank" + incr]).onRollOut = function():Void
				{
					MovieClip(this)._alpha = 100;			
				};
				MovieClip(this["tank" + incr]).onPress = function():Void
				{
					MovieClip(this)["type"]++;
					if (MovieClip(this)["type"] > 8)
					{
						MovieClip(this)["type"] = 1;
					}
					if (MovieClip(this)["type"] > 4)
					{
						MovieClip(this).gotoAndStop(MovieClip(this)["type"] - 4);
						var c1: Color = new Color(MovieClip(this)["black_mc"]);
						var c2: Color = new Color(MovieClip(this)["silver_mc"]);
						var c3: Color = new Color(MovieClip(this)["white_mc"]);	
						c1.setRGB(0x8C0074);
						c2.setRGB(0xD82800);
						c3.setRGB(0xFCFCFC);
					}
					else
					{
						MovieClip(this).gotoAndStop(MovieClip(this)["type"]);		
					}
				};
			}
		}
		this.initMouseDraw();
	}
	
	public function setCurrentSprite(btn: MovieClip): Void
	{
		if (btn == this.save_btn)
		{
			this.save_btn._alpha = 100;
			this.showConfirmDialog();
		}
		else
		{
			this.border._x = btn._x - 2;
			this.border._y = btn._y - 2;
			this.initMouseDraw();
		}
	}
	
	private function showConfirmDialog(): Void
	{
		this.isLockGUI = true;
		this.isDraw = false;
		this.confirmDialog = ConfirmDialog.create(this, "confirmDialog", this.getNextHighestDepth());
		this.confirmDialog.init();
		this.confirmDialog.addListener(this);
	}
	
	private function onConfirm(type: String): Void
	{
		if (type == "ok")
		{
			var tanksStr: String = "";
			
			for (var i: Number = 1;i < 21; i++)
			{
				tanksStr += Number(MovieClip(this["tank" + i])["type"]).toString();
			}
			
			broadcastMessage("onDrawStage", this.stageMap_array, tanksStr);
			
			this.confirmDialog.destroy();
			
			this.setCurrentSprite(this.brick_btn);
			this.isLockGUI = false;
			this.isDraw = true;
		}
		else
		{
			
			this.confirmDialog.destroy();
			
			this.setCurrentSprite(this.brick_btn);
			this.isLockGUI = false;
			this.isDraw = true;
		}
		this.initMouseDraw();
		this.border._x = -100;
	}
	
	private function initMouseDraw(): Void
	{
		
		this.pice = this.attachMovie(this.pice_array[this.currentPice], "pice", this.getNextHighestDepth(), {_visible:false});
		this.mouseBorder = this.attachMovie("mouseBorder", "mouseBorder", this.getNextHighestDepth(), {_visible:false});
		
		var $scope: EditPageScreen = this;

		this.onMouseMove = function(): Void
		{
			if (!$scope.isLockGUI)
			{
				$scope.mouseBorder._x = _root._xmouse - 2;
				$scope.mouseBorder._y = _root._ymouse - 2;
				
				$scope.pice._x = Math.round(_root._xmouse / 8) * 8;
				$scope.pice._y = Math.round(_root._ymouse / 8) * 8;
				
				if ($scope.rollOverBack.hitTest(_root._xmouse, _root._ymouse, 1) && $scope.pice._x < 216 && $scope.pice._y < 216)
				{
					$scope.mouseBorder._visible = true;
					$scope.pice._visible = true;
					Mouse.hide();
					
					if ($scope.isDraw)
					{
						$scope.setSprite($scope.pice._x, $scope.pice._y, $scope.pice_array[$scope.currentPice]);
					}
				}
				else
				{
					$scope.mouseBorder._visible = false;
					$scope.pice._visible = false;
					Mouse.show();
				}
				
				
				updateAfterEvent();
			}
		};
		
		this.onMouseDown = function(): Void
		{
			if (!$scope.isLockGUI)
			{
				if ($scope.pice._visible)
				{
					$scope.isDraw = true;
					$scope.setSprite($scope.pice._x, $scope.pice._y, $scope.pice_array[$scope.currentPice]);
				}
			}
		};
		
		this.onMouseUp = function(): Void
		{
			$scope.isDraw = false;
		};
	}
	
	private function setSprite(x: Number, y: Number, type: String): Void
	{
		var tx: Number = Math.round(x / 8) - 1;
		var ty: Number = Math.round(y / 8) - 1;
		
		Array(this.stageMap_array[ty])[tx] = this.type_array[type];
		this.mapCanvas.attachMovie(type, "s" + x * 100 + y, x * 100 + y, {_x:x, _y:y});
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