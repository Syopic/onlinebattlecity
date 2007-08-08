import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.data.GlobalStorage;
//import ua.com.syo.battlecity.data.StagesMock;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 8 ��� 2007
 */
class ua.com.syo.battlecity.model.HTTPServer implements AsBroadcasterI 
{
	public function HTTPServer()
	{
		AsBroadcaster.initialize(this);
	}
	
	public function loadXML(path: String): Void
	{
		var stage_xml: XML = new XML();
		stage_xml.load(path);
		stage_xml.ignoreWhite = true;
		
		var $scope: HTTPServer = this; 
		stage_xml.onLoad = function(success: Boolean):Void 
		{
			if (success) 
			{
				$scope.onStageLoad(XML(this));
			} else 
			{
				trace("[Error: ] Not load");
			}
		};
//		this.onStageLoad(StagesMock["stage"+stage]);
	}
	
	public function onStageLoad(xml: XML): Void
	{
		this.broadcastMessage("onStageLoad", xml);
	}
	
	public function fixPlayedStage(id: String): Void
	{
		var varSender: LoadVars = new LoadVars();
		var varR: LoadVars = new LoadVars();
		varSender["_ax"] = "battlecity:fix";
		varSender["i"] = id;
		trace("ID: " + id);
		varSender.sendAndLoad(GlobalStorage.pathToServer, varR, "POST");
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