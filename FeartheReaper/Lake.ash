// Script header for module 'Lake'
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
