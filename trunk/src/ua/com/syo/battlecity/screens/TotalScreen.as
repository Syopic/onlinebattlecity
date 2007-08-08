import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.components.NESNumField;
import ua.com.syo.battlecity.components.NESTextField;
import ua.com.syo.battlecity.data.DataLabels;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.sound.AllSounds;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 15 ��� 2007
 */
class ua.com.syo.battlecity.screens.TotalScreen extends MovieClip implements AsBroadcasterI
{
	private var canvas_mc:MovieClip;
	
	private var hiScore_num:NESNumField;
	private var hiScore_tf:NESTextField;
	
	private var stage_tf:NESTextField;
	private var stage_num:NESNumField;
	
	private var firstPlayer_tf:NESTextField;
	
	private var score_num:NESNumField;
	
	private var total_tf:NESTextField;
	
	private var total_num:NESNumField;
	
	private var whiteLine:MovieClip;
	
	private var rows_array:Array=new Array();
	
	private var showTotalIntervalId:Number;
	
	private var currenrRowForShow:Number;
	
	private var scores_array:Array;
	
	private var scoresIncr_array:Array;
	
	private var multipleScores_array:Array=new Array(100, 200, 300, 400);
	
	private var sum:Number;
	
	private var pointSum:Number;
	
	private var closerTop:MovieClip;
	
	private var closerBottom:MovieClip;
	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):TotalScreen
	{
		registerClass("__Packages.ua.com.syo.battlecity.screens.TotalScreen",TotalScreen);
		var instance:MovieClip=clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.TotalScreen",name,depth,initObject);
		var classInstance:TotalScreen=TotalScreen(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance():Void
	{
		this.attachMovie("rectangle", "rectangle", this.getNextHighestDepth());
		this.canvas_mc=createEmptyMovieClip("canvas_mc", this.getNextHighestDepth());
		
		this.hiScore_tf=NESTextField.create(this.canvas_mc, "hiScore_tf", this.canvas_mc.getNextHighestDepth());
		this.hiScore_num=NESNumField.create(this.canvas_mc, "hiScore_num", this.canvas_mc.getNextHighestDepth());
		
		this.stage_tf=NESTextField.create(this.canvas_mc, "stage_tf", this.canvas_mc.getNextHighestDepth());
		this.stage_num=NESNumField.create(this.canvas_mc, "stage_num", this.canvas_mc.getNextHighestDepth());
		
		this.firstPlayer_tf=NESTextField.create(this.canvas_mc, "firstPlayer_tf", this.canvas_mc.getNextHighestDepth());
		this.score_num=NESNumField.create(this.canvas_mc, "score_num", this.canvas_mc.getNextHighestDepth());
		
		this.total_tf=NESTextField.create(this.canvas_mc, "total_tf", this.canvas_mc.getNextHighestDepth());
		this.total_num=NESNumField.create(this.canvas_mc, "total_num", this.canvas_mc.getNextHighestDepth());
		
		this.whiteLine=this.canvas_mc.attachMovie("rectangle", "whiteLine", this.canvas_mc.getNextHighestDepth());
		
		this.closerTop=this.attachMovie("closer", "closerTop", this.getNextHighestDepth());
		this.closerBottom=this.attachMovie("closer", "closerBottom", this.getNextHighestDepth());
				
		this.closerTop._y=-121;
		this.closerBottom._y=233;
	}
	
	public function init(scores:Array, isGO:Boolean): Void
	{
		var i : Number;
//		
		this.scores_array=scores;
		this.rows_array=new Array();
		this.currenrRowForShow=0;
		this.sum=0;
		this.pointSum=0;
		
		this.scoresIncr_array=new Array(0, 0, 0, 0);
		
		for ( i= 0; i < this.scores_array.length; i++)
		{
			this.sum+= this.scores_array[i];
			this.pointSum+=this.scores_array[i]*this.multipleScores_array[i];
		}
		
		AsBroadcaster.initialize(this);
		
		this.hiScore_tf.init(65, 16, DataLabels.TOTAL_HI_SCORE, 0xD82800);
		this.hiScore_num.init(153, 16, 8, "left", 0xFC9838);
		this.hiScore_num.setValue(GlobalStorage.hiScore.toString());
		
		this.stage_tf.init(97, 32, DataLabels.STAGE, 0xFFFFFF);
		this.stage_num.init(153, 32, 3, "left", 0xFFFFFF);
		this.stage_num.setValue(GlobalStorage.currentStage.toString());
		
		this.firstPlayer_tf.init(25, 48, DataLabels.TOTAL_FIRST_PLAYER, 0xD82800);
		
		this.score_num.init(25, 64, 8, "right", 0xFC9838);
		
//		GlobalStorage.score+=this.pointSum;
		this.score_num.setValue(GlobalStorage.score.toString());
		
		this.total_tf.init(49, 176, DataLabels.TOTAL_TOTAL, 0xFFFFFF);
		
		this.total_num.init(97, 176, 2, "right", 0xFFFFFF);
		
		this.whiteLine._width=64;
		this.whiteLine._height=2;
		this.whiteLine._x=96;
		this.whiteLine._y=173;
		
		var c:Color=new Color(this.whiteLine);
		c.setRGB(0xFFFFFF);
		
		
		for (i = 0; i < 4; i++)
		{
			this.createTotalRow(i+1);
		}
		
		showTotalEnable();
		
		if (isGO)
		{
			var c1:Color=new Color(this.closerTop);
			c1.setRGB(0x000000);
			var c2:Color=new Color(this.closerBottom);
			c2.setRGB(0x000000);
		}
		
	}
	
	public function createTotalRow(rowIndex:Number): Void
	{
		var row:MovieClip=this.canvas_mc.createEmptyMovieClip("row"+rowIndex, this.canvas_mc.getNextHighestDepth());
		var score_num:NESNumField=NESNumField.create(row, "score_num", row.getNextHighestDepth());
		var pts_tf:NESTextField=NESTextField.create(row, "pts_tf", row.getNextHighestDepth());;
		var kill_num:NESNumField=NESNumField.create(row, "kill_num", row.getNextHighestDepth());;
		
		score_num.init(0,0, 4, "right", 0xFFFFFF);
		
		score_num._visible=false;
		
		pts_tf.init(40, 0, DataLabels.TOTAL_PTS, 0xFFFFFF);
		
		kill_num.init(72,0, 2, "right", 0xFFFFFF);
		kill_num._visible=false;
		
		row.attachMovie("<", "<", row.getNextHighestDepth(), {_x:88, _y:0});
		
		row.attachMovie("totalTank"+rowIndex, "tank"+rowIndex, row.getNextHighestDepth(), {_x:97, _y:-3});
		
		row._x=25;
		row._y=88+24*(rowIndex-1);
		
		this.rows_array.push(row);
	}
	
	public function setRowData(rowIndex:Number, num:Number, multiplier:Number): Void
	{
		AllSounds.getInstance().playTotal();
		NESNumField(MovieClip(this.rows_array[rowIndex])["kill_num"])._visible=true;
		NESNumField(MovieClip(this.rows_array[rowIndex])["kill_num"]).setValue((num).toString());
		NESNumField(MovieClip(this.rows_array[rowIndex])["score_num"])._visible=true;
		NESNumField(MovieClip(this.rows_array[rowIndex])["score_num"]).setValue((num*multiplier).toString());
	}
	
	public function showTotalEnable(): Void
	{
		if(this.showTotalIntervalId != null) 
		{
			clearInterval(this.showTotalIntervalId);
 		}
		this.showTotalIntervalId = setInterval(this, "showRows", GlobalStorage.totalShowDelay);
	}
	
	private function showRows(): Void
	{
		var left:Number=this.scores_array[this.currenrRowForShow];
		
		var value:Number=0;
		if (left>-1)
		{
			this.scores_array[this.currenrRowForShow]--;
			value=this.scoresIncr_array[this.currenrRowForShow]++;
			if (value>0 || (this.currenrRowForShow==0 && this.scores_array[this.currenrRowForShow]<0))
			{
				this.setRowData(this.currenrRowForShow, value, this.multipleScores_array[this.currenrRowForShow]);
			}
		}
		else
		{
			this.currenrRowForShow++;
			if (this.scores_array[this.currenrRowForShow]==0)
			{
				this.setRowData(this.currenrRowForShow, 0, this.multipleScores_array[this.currenrRowForShow]);
			}
			if (this.currenrRowForShow>4)
			{
				Key.addListener(this);
				this.runDelay();
				clearInterval(this.showTotalIntervalId);
				
				this.total_num.setValue(this.sum.toString());
			}
		}
	}
	
	public function onKeyDown():Void
	{
//		if(Key.isDown(Key.SPACE))
//		{
//			Key.removeListener(this);
//			closeTotal();
//			
//		}
	}	
	
	private function runDelay() : Void 
	{
		var delay:Number=100;
		var $scope:TotalScreen=this;
		this.onEnterFrame=function() :Void{
			delay--;
			if (delay<0)
			{
				$scope.closeTotal();
				delete $scope.onEnterFrame;
			}
		};	
	}
	
	public function closeTotal(): Void
	{
		var $scope:TotalScreen=this;
		this.canvas_mc.onEnterFrame=function():Void {
			if ($scope.closerTop._y<-2) { 
				$scope.closerTop._y+=5;
				$scope.closerBottom._y-=5;
			} else {
				$scope.onClose();
				delete $scope.canvas_mc.onEnterFrame;
			}
		};
	}
	
	private function onClose(): Void
	{
		Key.addListener(this);
		this.broadcastMessage("onCloseTotalScreen");
	}
	
	public function destroy(): Void
	{
		this.removeMovieClip();
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