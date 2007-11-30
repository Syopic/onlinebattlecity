import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.model.HTTPServer;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.screens.stage.CurrentStageData;

/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 8 ��� 2007
 */
class ua.com.syo.battlecity.model.Model implements AsBroadcasterI {
	private static var instance : Model;
	private var server : HTTPServer;

	/**
	 * @return singleton instance of Model
	 */
	public static function getInstance() : Model {
		if (instance == null) {
			instance = new Model();
		}
		return instance;
	}

	public function init() : Void {
		AsBroadcaster.initialize(this);
		this.server = new HTTPServer();
		this.server.addListener(this);
	}

	public function getMapByStageNum(stage : Number) : Void {
		if (GlobalStorage.isClassicGame) {
			this.server.loadXML(GlobalStorage.pathToStages + "stage" + stage + ".xml", stage);
		}
		else {
			this.server.loadXML(GlobalStorage.pathToServer + "?_ax=battlecity:top&n=" + stage);
		}
	}

	public function getMapById(id : String) : Void {
		this.server.loadXML(GlobalStorage.pathToServer + "?_ax=battlecity:map&i=" + id);
	}

	//	Event from server
	public function onStageLoad(xml : XML) : Void {
		CurrentStageData.fillMap(xml);
		this.broadcastMessage("onStageLoad");
	}

	public function fixPlayedStage(id : String) : Void {
		this.server.fixPlayedStage(id);
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