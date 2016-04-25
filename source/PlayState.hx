package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;
import openfl.events.MouseEvent;

class PlayState extends FlxState
{
	private var fps(default, set):Int;
	private var fpsText(default, null):FlxText;
	private var fpsDownButton(default, null):FlxButton;
	private var fpsUpButton(default, null):FlxButton;
	private var instructionsText(default, null):FlxText;
	private var eventText(default, null):FlxText;
	
	private var clearButton(default, null):FlxButton;
	private var counterButton(default, null):FlxButton;
	private var flMouseups:Int = 1;
	private var buttonMouseups:Int = 1;
	
	override public function create():Void
	{
		super.create();
		
		fpsText = new FlxText(0, 0, 0, "", 64);
		add(fpsText);
		
		fps = 5;
		
		eventText = new FlxText(10, 0, 0, "", 14);
		add(eventText);
		
		fpsDownButton = new FlxButton(0, 0, "fps--", function() { fps -= 1; });
		fpsDownButton.x = FlxG.width * 0.4 - fpsDownButton.width / 2;
		fpsDownButton.y = FlxG.height * 0.8;
		add(fpsDownButton);
		
		fpsUpButton = new FlxButton(0, 0, "fps++", function() { fps += 1; });
		fpsUpButton.x = FlxG.width * 0.6 - fpsUpButton.width / 2;
		fpsUpButton.y = FlxG.height * 0.8;
		add(fpsUpButton);
		
		counterButton = new FlxButton(0, 0, "counter", function() { buttonMouseups++; addEventText("Counter mouseup (x" + buttonMouseups + ")"); });
		counterButton.x = FlxG.width * 0.5 - counterButton.width / 2;
		counterButton.y = FlxG.height * 0.8;
		add(counterButton);
		
		clearButton = new FlxButton(0, 0, "clear", function() { flMouseups = 0; buttonMouseups = 1; eventText.text = ""; });
		clearButton.x = FlxG.width * 0.5 - clearButton.width / 2;
		clearButton.y = FlxG.height * 0.9;
		add(clearButton);
		
		instructionsText = new FlxText(0, 0, 0, "At low FPS, FlxButton up mouse events are missed. Adjust FPS and click the counter.", 12);
		instructionsText.screenCenter(FlxAxes.X);
		add(instructionsText);
		
		FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):Void {
			flMouseups++;
			addEventText("OpenFL mouseup (x" + flMouseups + ")");
		});
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function set_fps(n:Int):Int {
		n = Std.int(Math.min(60, Math.max(1, n)));
		FlxG.updateFramerate = n;
		addEventText("Flixel FPS changed to: " + n);
		fpsText.text = "FPS: " + Std.string(n);
		fpsText.screenCenter(FlxAxes.XY);
		return this.fps = n;
	}
	
	private function addEventText(s:String):Void {
		if(eventText != null) {
			eventText.text = eventText.text + "\n" + s;
		}
	}
}