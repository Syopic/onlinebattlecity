import ua.com.syo.battlecity.data.GlobalStorage;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 19 ��� 2007
 */
class ua.com.syo.battlecity.screens.stage.Bonus extends MovieClip 
{
	private var bonus_mc:MovieClip; 
	private var blinkingDelay:Number=0;
	private var viewDelay:Number;
	private var type:Number;
	private var x:Number;
	private var y:Number;
	private var bonusId_array:Array=new Array("star", "grenade", "lifeAdd", "helmet", "clock", "spade");
	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):Bonus
	{
		registerClass("__Packages.ua.com.syo.battlecity.screens.stage.Bonus",Bonus);
		var instance:MovieClip=clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.stage.Bonus",name,depth,initObject);
		var classInstance:Bonus=Bonus(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance():Void
	{
		
	}
	
	public function init(x:Number, y:Number, type:Number): Void
	{
		this.x=x;
		this.y=y;
		this.type=type;
		this.bonus_mc=this.attachMovie(bonusId_array[type], "bonus", this.getNextHighestDepth());
		this.bonus_mc._x=x*8;
		this.bonus_mc._y=y*8;
		this.startBlink();
		this.viewDelay=GlobalStorage.bonusViewDelay;
	}
	
	private function startBlink(): Void
	{
		var $scope:Bonus=this;
		this.onEnterFrame=function(): Void
		{
			$scope.blinkingDelay--;
			
				
			if ($scope.blinkingDelay<0) {
				$scope.bonus_mc._visible=false;
				
			}
			else
			{
				$scope.bonus_mc._visible=true;
			}
			if ($scope.blinkingDelay<-7) {
				$scope.blinkingDelay=14;
			}
			if (--$scope.viewDelay<0)
			{
				$scope.destroy();
			}
		};
	}
	
	public function getType(): Number
	{
		return this.type;
	}

	public function getX(): Number
	{
		return this.x;
	}
		
	public function getY(): Number
	{
		return this.y;
	}		
	
	
	public function destroy(): Void
	{
		this.removeMovieClip();
	}
}