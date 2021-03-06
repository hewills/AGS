AGSScriptModule    Steve McCrea Animates a water surface like the once-popular Java lake applet. Lake 1.0 (	  // Main script for module 'Lake'
// v1.0 by Steve McCrea, 8th July 2006

// uses this code taken from a java lake applet's source
// h/14*(i+28)*sin(h/14*(h-i)/(i+1) + phase)/h

function Lake::DefaultConstruct()
{
  this.enabled = true;
  this.x = 0;
  this.y = 100;
  this.w = 320;
  this.h = 100;
  this.speed = 1.0;
  
  this.useScreenshot = false;
  this.backgroundFrameIndex = 0;
  
  this.yRipplePhaseScale = 1.0;
  this.yRippleSize = 1.0;
  this.yRippleDensity = 1.0;
  
  this.xRipplePhaseScale = 0.5;
  this.xRippleDensity = 8.0;
  this.xRippleSize = 1.0;

  this.yPhase = 0.0;
  this.xPhase = 0.5*Maths.Pi;
}

function Lake::SetScreenshotBufferBackgroundFrames(int displayFrame, int bufferFrame)
{
  this.useScreenshot = true;
  this.backgroundFrameIndex = bufferFrame;
  
  SetBackgroundFrame(displayFrame);
}

function Lake::Update()
{
  if (this.enabled)
  {
    float phaseScalar = Maths.Pi/IntToFloat(GetGameSpeed());

		this.yPhase += this.speed*this.yRipplePhaseScale*phaseScalar;
		while (this.yPhase > 2.0*Maths.Pi) this.yPhase -= 2.0*Maths.Pi;
		
		this.xPhase += this.speed*this.xRipplePhaseScale*phaseScalar;
		while (this.xPhase > 2.0*Maths.Pi) this.xPhase -= 2.0*Maths.Pi;
	
		float fh = IntToFloat(this.h);
		
		if (this.useScreenshot)
		{
		  // copy to "back buffer"
		  DynamicSprite *bg = DynamicSprite.CreateFromScreenShot();
		  int bgFrame = GetBackgroundFrame();
		  SetBackgroundFrame(this.backgroundFrameIndex);
		  RawDrawImage(0, 0, bg.Graphic);
		  SetBackgroundFrame(bgFrame);
		  bg.Delete();
		}

		int i = 0;
		while (i < this.h)
		{
			float fi = IntToFloat(i);
			float yAngle = ((this.yRippleDensity*fh/14.0)*(fh-fi)/(fi+1.0)) + this.yPhase;
			float yoff = this.yRippleSize*((28.0+fi)/14.0)*(1.0 + Maths.Sin(yAngle));
			int yoffi = FloatToInt(yoff);
			int yi = i - yoffi;
			if (yi >= 0)
			{
			  float xAngle = ((this.xRippleDensity*fh/14.0)*(fh-fi)/(fi+1.0)) + this.xPhase;
				float xoff = this.xRippleSize*((28.0+fi)/14.0)*(1.0 + Maths.Sin(xAngle));
				int xoffi = FloatToInt(xoff);
 				DynamicSprite *s = DynamicSprite.CreateFromBackground(this.backgroundFrameIndex, this.x + xoffi, this.y - yi, this.w - 2*xoffi, 1);
				RawDrawImageResized(this.x, this.y + i, s.Graphic, this.w, 1);
			}
			i++;
		}
	}
} c  // Script header for module 'Lake'
//
// Add a Lake to the top of a room script
//   Lake swimmingPoolSurface;
// In the room's player enters room (before fade in)
//   swimmingPoolSurface.DefaultConstruct();
// In the room's repeatedly execute
//   swimmingPoolSurface.Update();
//
// If you want to use screenshots (to reflect everything, not just the background), call
//   swimmingPoolSurface.SetScreenshotBufferBackgroundFrames(0, 1);
// after the DefaultConstruct.
//

struct Lake {
  // sets up the module with sensible default values
  import function DefaultConstruct();
  // sets up using a screenshot (must have the 'animated' background frame)
  import function SetScreenshotBufferBackgroundFrames(int displayFrame, int bufferFrame);
  // call this from repeatedly execute
  import function Update();
  
  // whether to apply the effect
  bool enabled;
  // the area of the screen which is the water surface
  // it must be more than half way down the screen
  int x, y, w, h;
  // the speed of the ripple animation
  float speed;
  // whether to use background or screenshot
  bool useScreenshot;
  // if using the background, can reflect a different background
  // if using a screenshot, it's drawn to this frame first
  int backgroundFrameIndex;

  // how much to offset reflections
  float yRippleSize;
  // a parameter to control the y animation
  float yRipplePhaseScale;
  // how tightly packed the ripples are
  float yRippleDensity;

  // how much to offset reflections
  float xRippleSize;
  // a parameter to control the x animation
  float xRipplePhaseScale;
  // how tightly packed the ripples are
  float xRippleDensity;

  // normally updated internally but can be played with for special effects  
  float xPhase;
  float yPhase;
};

//
// Author: Steve McCrea
// Version: 1.0
// Released: 8th July 2006
 A^@�       ej��