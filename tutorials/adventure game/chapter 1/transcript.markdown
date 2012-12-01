Hi!
In this tutorial, I'm going to quickly run through the beginnings of a simple adventure game for the Mac. There are 5 buttons: up, down, left, and right, and a button to start or reset the game. The red square is the player, and there's obviously no clipping in place yet.

Let's get started.

## New proj

Launch Xcode. File > New > Project...

Application > Cocoa Application. Next.

Call it "StupidAdventure". Make sure ARC is on. Put your initials in "Class Prefix". Mine are "JT". Next.

Save it where you want.

## Interface builder

When the project appears, you'll see a bunch of files on the left - these are what get built into your app.
Let's start with the UI. That's in MainMenu.xib.

They give you a blank window to start off.

Make sure the right sidebar, with the Object Library, is visible and drag a button onto your Window.
Double-click to change it and type "North". Resize it.

Make more buttons by duplicating this one with Command-D. Drag them around and line them up.

To make these buttons do something, let's go to our File's Owner, which is JTAppDelegate.h and add in the declarations for those button actions.

- (IBAction)startGame:(id)sender;

- (IBAction)goNorth:(id)sender;
- (IBAction)goSouth:(id)sender;
- (IBAction)goEast:(id)sender;
- (IBAction)goWest:(id)sender;

Also paste these into the .m, but add curly braces after each. This is where we'll put the code that those buttons trigger. The .h just informs Interface Builder and other parts of our app as to what to expect this AppDelegate to do.

In each code stub, add a line with an NSLog, just to see the console confirm when our buttons work correctly.

NSLog(@"north");
NSLog(@"south");
NSLog(@"east");
NSLog(@"west");
NSLog(@"restart game");

Go back to MainMenu.xib, and let's hook them up. Hold down "Control", and left-drag from the button to "File's Owner". Select the cooresponding action from the popup for that button.

Okay, good. Now click the Play button in the top-left corner of the Xcode project, and let's run our app!

The console should open and spit something out when you click the buttons. If it doesn't, you need to go back and double-check your button connections.

In our game, we're going to have at least one player, and many rooms, and eventually those rooms will contain many enemies. Each of these will be an object, each type of which is declared by a class: a player class and a room class for now. We need to create these two classes.

In Xcode, right-click the top-most directory of the project, and choose "New file...". Under "OS X", choose "Cocoa", and make it an "Objective-C class". Next. The Class will be named "JTPlayer", and it's a subclass of NSObject. Next. Save the file in the project directory.

Now, follow the same process again, with this class being named "JTRoom".

Each of these classes basically defines what a player or room is capable of doing. In our Player class, I'm going to define three properties:

@interface JTPlayer : NSObject

@property (nonatomic, assign) float xPosition;
@property (nonatomic, assign) float yPosition;

@property (nonatomic, assign) NSUInteger health; // value between 0 and 100

@end

The floats are just decimals, and can be negative. These are its position in 2D space, in relation to the center of our playing area. And we have a number between 0 and 100 for his health. We'll work with that later.

Similarly, our rooms have a position in space, as well as an area, width and height.

@interface JTRoom : NSObject

// x, y, width, height

@property (nonatomic, assign) float xPosition;
@property (nonatomic, assign) float yPosition;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

@end


