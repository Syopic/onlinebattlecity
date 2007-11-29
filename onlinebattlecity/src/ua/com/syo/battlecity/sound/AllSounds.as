/**
 * @author Krivosheya Sergey
 */
class ua.com.syo.battlecity.sound.AllSounds extends MovieClip 
{
	private var isMute:Boolean=false;
	
	private static var instance : AllSounds;
	
	private var intro_s:Sound;
	private var shoot_s:Sound;
	private var eraseBrick_s:Sound;
	private var engine_s:Sound;
	private var block_s:Sound;
	private var move_s:Sound;
	private var buh_s:Sound;
	private var kill_s:Sound;
	private var star_s:Sound;
	private var pause_s:Sound;
	private var getLife_s:Sound;
	private var setBonus_s:Sound;
	private var total_s:Sound;
	private var gameover_s:Sound;
	private var hi_s:Sound;
	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object) : AllSounds
	{
		registerClass("__Prototype.ua.com.syo.battlecity.sound.AllSounds", AllSounds);
		var instance:MovieClip=clip.attachMovie("__Prototype.ua.com.syo.battlecity.sound.AllSounds",name,depth,initObject);
		var classInstance:AllSounds=AllSounds(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	public function buildInstance(): Void
	{
		
	}
	
	public static function getInstance() : AllSounds 
	{
		if (instance == null)
		{
			instance = new AllSounds();
		}
		return instance;
	}
	
	public function init(): Void
	{	
		var intro_mc:MovieClip = this.createEmptyMovieClip("intro", 1);
		this.intro_s=new Sound(intro_mc);
		this.intro_s.attachSound("intro_sound");
		
		var shoot_mc:MovieClip = this.createEmptyMovieClip("shoot", 2);
		this.shoot_s=new Sound(shoot_mc);
		this.shoot_s.attachSound("shoot_sound");
		
		var eraseBrick_mc:MovieClip = this.createEmptyMovieClip("eraseBrick", 3);
		this.eraseBrick_s=new Sound(eraseBrick_mc);
		this.eraseBrick_s.attachSound("eraseBrick_sound");
		
		var engine_mc:MovieClip = this.createEmptyMovieClip("engine", 4);
		this.engine_s=new Sound(engine_mc);
		this.engine_s.attachSound("engine_sound");
		
		var block_mc:MovieClip = this.createEmptyMovieClip("block", 5);
		this.block_s=new Sound(block_mc);
		this.block_s.attachSound("block_sound");
		
		var move_mc:MovieClip = this.createEmptyMovieClip("move", 6);
		this.move_s=new Sound(move_mc);
		this.move_s.attachSound("move_sound");
		
		var buh_mc:MovieClip = this.createEmptyMovieClip("buh", 7);
		this.buh_s=new Sound(buh_mc);
		this.buh_s.attachSound("buh_sound");
		
		var kill_mc:MovieClip = this.createEmptyMovieClip("kill", 8);
		this.kill_s=new Sound(kill_mc);
		this.kill_s.attachSound("kill_sound");
		
		var star_mc:MovieClip = this.createEmptyMovieClip("star", 9);
		this.star_s=new Sound(star_mc);
		this.star_s.attachSound("star_sound");
		
		var pause_mc:MovieClip = this.createEmptyMovieClip("pause", 10);
		this.pause_s=new Sound(pause_mc);
		this.pause_s.attachSound("pause_sound");
		
		var getLife_mc:MovieClip = this.createEmptyMovieClip("getLife", 11);
		this.getLife_s=new Sound(getLife_mc);
		this.getLife_s.attachSound("getLife_sound");
		
		var setBonus_mc:MovieClip = this.createEmptyMovieClip("setBonus", 12);
		this.setBonus_s=new Sound(setBonus_mc);
		this.setBonus_s.attachSound("setBonus_sound");
		
		var total_mc:MovieClip = this.createEmptyMovieClip("total", 13);
		this.total_s=new Sound(total_mc);
		this.total_s.attachSound("total_sound");
		
		var gameover_mc:MovieClip = this.createEmptyMovieClip("gameover", 14);
		this.gameover_s=new Sound(gameover_mc);
		this.gameover_s.attachSound("gameover_sound");
		
		var hi_mc:MovieClip = this.createEmptyMovieClip("hi", 15);
		this.hi_s=new Sound(hi_mc);
		this.hi_s.attachSound("hi_sound");
		
//		this.intro_s.setVolume(50);
		
	}
	
	public function mute(): Void
	{
		this.isMute=true;
	}
	
	public function playIntro(): Void
	{
		if (!this.isMute)
		{
			this.intro_s.start();
		}
	}
	
	public function stopIntro(): Void
	{
			this.intro_s.stop();
	}
	
	public function playPause(): Void
	{
		if (!this.isMute)
		{
			pause_s.start();
		}
	}
	
	public function playSetBonus(): Void
	{
		if (!this.isMute)
		{
			setBonus_s.start();
		}
	}
	
	public function playGetLife(): Void
	{
		if (!this.isMute)
		{
			getLife_s.start();
		}
	}
	
	public function playShoot(): Void
	{
		if (!this.isMute)
		{
			shoot_s.start();
		}
	}
	
	public function playeraseBrick(): Void
	{
		if (!this.isMute)
		{
			eraseBrick_s.start();
		}
	}
	
	public function playEngine(loops:Number): Void
	{
		if (!this.isMute)
		{
			engine_s.start(0, loops);
		}
	}
	
	public function stopEngine(): Void
	{
		if (!this.isMute)
		{
			this.engine_s.stop("engine_sound");
		}
	}
	
	public function playBlock(): Void
	{
		if (!this.isMute)
		{
			block_s.start();
		}
	}
	
	public function playMove(loops:Number): Void
	{
		if (!this.isMute)
		{
			move_s.start(0, loops);
		}
	}
	
	public function stopMove(): Void
	{
		if (!this.isMute)
		{
			this.move_s.stop("move_sound");
		}
	}
	
	public function playBuh(): Void
	{
		if (!this.isMute)
		{
			buh_s.start();
		}
	}
	
	public function playKill(): Void
	{
		if (!this.isMute)
		{
			kill_s.start();
		}
	}
	
	public function playStar(): Void
	{
		if (!this.isMute)
		{
			star_s.start();
		}
	}
	
	public function playTotal(): Void
	{
		if (!this.isMute)
		{
			total_s.start();
		}
	}
	
	public function playGameover(): Void
	{
		if (!this.isMute)
		{
			gameover_s.start();
		}
	}
	
	public function playHi(): Void
	{
		if (!this.isMute)
		{
			hi_s.start();
		}
	}

	public function stopAllSounds(): Void
	{
		this.stopEngine();
		this.stopMove();
	}
	
	public function setVolume(value:Number): Void
	{
		if (value==0)
		{
			this.isMute=true;
			this.engine_s.setVolume(0);
			this.move_s.setVolume(0);
		}
		else
		{
			this.isMute=false;
			this.engine_s.setVolume(100);
			this.move_s.setVolume(100);
		}
	}
}