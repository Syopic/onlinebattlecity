import ua.com.syo.battlecity.data.GlobalStorage;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 29 ��� 2007
 */
class ua.com.syo.battlecityeditor.model.Model 
{
	private static var instance: Model;
	
	/**
	 * returns the singleton;
	 */
	public static function getInstance(): Model
	{
		if (instance == null)
		{
			instance = new Model();
		}
		return instance;
	}
	
	public function init(): Void
	{
	}
	
	public function onDrawStage(stageMap_array: Array, tanksStr: String): Void
	{
		var str: String = this.serealiser(stageMap_array, tanksStr);
		var varSender: LoadVars = new LoadVars();
		var varR: LoadVars = new LoadVars();
		
		varR.onLoad = function(success: Boolean):Void 
		{
			if (success) 
			{
				getURL(GlobalStorage.pathToLink + varR["id"]);
				//trace("ID return: "+varR["id"]);
			} else {
				
			}
		};
		
		varSender["_ax"] = "battlecity:submit";
		varSender["map"] = str;
		varSender.sendAndLoad(GlobalStorage.pathToServer, varR, "POST");
	}
	
	private function serealiser(stageMap_array: Array, tanksStr: String): String
	{
		var compileStr: String = "<stage enemys=\"" + tanksStr + "\">\n";
		
		for (var i: Number = 0;i < 26; i++) 
		{
			var str: String = "	<r>";
			for (var j: Number = 0;j < 26; j++) 
			{
				if (Array(stageMap_array[i])[j] == undefined)
				{
					str += "_";
				}
				else
				{
					str += Array(stageMap_array[i])[j];
				}
			}
			str += "</r>\n";
			compileStr += str;
		}
		compileStr += "</stage>";
		
		return compileStr;
	}
}