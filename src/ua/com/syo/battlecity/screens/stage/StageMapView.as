import ua.com.syo.battlecity.screens.stage.CurrentStageData;
import ua.com.syo.battlecity.components.Sprite;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 9 ��� 2007
 */
class ua.com.syo.battlecity.screens.stage.StageMapView extends MovieClip
{
	private var blackBack:MovieClip;
	
	private var gardenCanvas:MovieClip;
	
	private var scoreCanvas:MovieClip;
	
	private var bonusCanvas:MovieClip;
	
	private var enemyBombCanvas:MovieClip;
	private var playerBombCanvas:MovieClip;
	
	private var blastCanvas:MovieClip;
	
	private var playerTankCanvas:MovieClip;
	
	private var enemyTankCanvas:MovieClip;
	
	private var ferumCanvas:MovieClip;
	private var brickCanvas:MovieClip;
	private var waterCanvas:MovieClip;
	
	private var iceCanvas:MovieClip;
	
	private var eagle:MovieClip;

	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):StageMapView
	{
		registerClass("__Packages.ua.com.syo.battlecity.screens.stage.StageMapView",StageMapView);
		var instance:MovieClip=clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.stage.StageMapView",name,depth,initObject);
		var classInstance:StageMapView=StageMapView(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance():Void
	{
		this.blackBack=this.attachMovie("rectangle", "rectangle", 1);
		this.blackBack._width=this.blackBack._height=208;
		
		this.iceCanvas=this.createEmptyMovieClip("ice", 2, {_x:16, _y:8});
		this.waterCanvas=this.createEmptyMovieClip("water", 3, {_x:16, _y:8});
		
		this.brickCanvas=this.createEmptyMovieClip("brick", 4, {_x:16, _y:8});
		this.ferumCanvas=this.createEmptyMovieClip("ferum", 5, {_x:16, _y:8});
		
		this.playerTankCanvas=this.createEmptyMovieClip("tank", 6, {_x:16, _y:8});
		
		this.enemyTankCanvas=this.createEmptyMovieClip("enemy", 7, {_x:16, _y:8});
		
		
		
		this.playerBombCanvas=this.createEmptyMovieClip("playerBomb", 8, {_x:16, _y:8});
		this.enemyBombCanvas=this.createEmptyMovieClip("enemyBomb", 9, {_x:16, _y:8});
		
		
		this.blastCanvas=this.createEmptyMovieClip("blast", 10, {_x:16, _y:8});
		
		
		this.gardenCanvas=this.createEmptyMovieClip("blast", 11, {_x:16, _y:8});
		
		this.bonusCanvas=this.createEmptyMovieClip("bonus", 11, {_x:16, _y:8});
		
		
		
	}
	
	public function init(): Void
	{
		
	}
	
	public function drawStage(): Void
	{
		for (var i : Number = 0; i < 26; i++)
		{
			for (var j : Number = 0; j < 26; j++)
			{
				var spriteId:String=CurrentStageData.getSprite(i, j);
				setSpriteOnStage(i, j, spriteId);
			}
		}
	}
	
	public function setSpriteOnStage(x:Number, y:Number, type:String): Void
	{
		if (x==12 && y==24)
		{
			this.eagle=this.ferumCanvas.attachMovie("eagle", "eagle", x*100+y, {_x:x*8, _y:y*8});
			this.eagle.gotoAndStop(1);
			CurrentStageData.eagleInstance=this.eagle;
		}
		else
		{
			Sprite(CurrentStageData.getSpriteInstance(x, y)).destroy();
			switch (type)
			{
				
				case "b":
					var b:Sprite=Sprite.create(this.brickCanvas, "b"+x+"_"+y, this.brickCanvas.getNextHighestDepth());
					b.init(x*8, y*8, "brick");
					CurrentStageData.setSpriteInstance(x, y, b);
				break;
				case "f":
					var f:Sprite=Sprite.create(this.ferumCanvas, "f"+x+"_"+y, this.ferumCanvas.getNextHighestDepth());
					f.init(x*8, y*8, "ferum");
					CurrentStageData.setSpriteInstance(x, y, f);
				break;
				case "g":
					var g:Sprite=Sprite.create(this.gardenCanvas, "g"+x+"_"+y, this.gardenCanvas.getNextHighestDepth());
					g.init(x*8, y*8, "garden");
					CurrentStageData.setSpriteInstance(x, y, g);
				break;
				case "w":
					var w:Sprite=Sprite.create(this.waterCanvas, "w"+x+"_"+y, this.waterCanvas.getNextHighestDepth());
					w.init(x*8, y*8, "water");
					CurrentStageData.setSpriteInstance(x, y, w);
				break;
				case "i":
					var i:Sprite=Sprite.create(this.iceCanvas, "i"+x+"_"+y, this.iceCanvas.getNextHighestDepth());
					i.init(x*8, y*8, "ice");
					CurrentStageData.setSpriteInstance(x, y, i);
				break;
			}
		}
	}
	
	public function getTankContainer(): MovieClip
	{
		return this.playerTankCanvas;
	}
	
	public function getEnemyContainer(): MovieClip
	{
		return this.enemyTankCanvas;
	}
	
	public function getPlayerBombContainer(): MovieClip
	{
		return this.playerBombCanvas;
	}
	
	public function getEnemyBombContainer(): MovieClip
	{
		return this.enemyBombCanvas;
	}
	
	public function getBlastContainer(): MovieClip
	{
		return this.blastCanvas;
	}
	
	public function getBonusContainer(): MovieClip
	{
		return this.bonusCanvas;
	}

}