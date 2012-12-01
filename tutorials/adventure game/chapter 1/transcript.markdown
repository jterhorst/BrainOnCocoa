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

````
- (IBAction)startGame:(id)sender;

- (IBAction)goNorth:(id)sender;
- (IBAction)goSouth:(id)sender;
- (IBAction)goEast:(id)sender;
- (IBAction)goWest:(id)sender;
````

Also paste these into the .m, but add curly braces after each. This is where we'll put the code that those buttons trigger. The .h just informs Interface Builder and other parts of our app as to what to expect this AppDelegate to do.

In each code stub, add a line with an NSLog, just to see the console confirm when our buttons work correctly.

````
NSLog(@"north");
NSLog(@"south");
NSLog(@"east");
NSLog(@"west");
NSLog(@"restart game");
````

Go back to MainMenu.xib, and let's hook them up. Hold down "Control", and left-drag from the button to "File's Owner". Select the cooresponding action from the popup for that button.

Okay, good. Now click the Play button in the top-left corner of the Xcode project, and let's run our app!

The console should open and spit something out when you click the buttons. If it doesn't, you need to go back and double-check your button connections.

In our game, we're going to have at least one player, and many rooms, and eventually those rooms will contain many enemies. Each of these will be an object, each type of which is declared by a class: a player class and a room class for now. We need to create these two classes.

In Xcode, right-click the top-most directory of the project, and choose "New file...". Under "OS X", choose "Cocoa", and make it an "Objective-C class". Next. The Class will be named "JTPlayer", and it's a subclass of NSObject. Next. Save the file in the project directory.

Now, follow the same process again, with this class being named "JTRoom".

Each of these classes basically defines what a player or room is capable of doing. In our Player class, I'm going to define three properties:

````
@interface JTPlayer : NSObject

@property (nonatomic, assign) float xPosition;
@property (nonatomic, assign) float yPosition;

@property (nonatomic, assign) NSUInteger health; // value between 0 and 100

@end
````

The floats are just decimals, and can be negative. These are its position in 2D space, in relation to the center of our playing area. And we have a number between 0 and 100 for his health. We'll work with that later.

Similarly, our rooms have a position in space, as well as an area, width and height. Let's update JTRoom.h

````
@interface JTRoom : NSObject

// x, y, width, height

@property (nonatomic, assign) float xPosition;
@property (nonatomic, assign) float yPosition;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

@end
````

Since these properties automatically generate a bunch of code for us, we don't need to edit the .m files for these classes.

## The logic

Back in our AppDelegate, we need to start putting these pieces together. We're going to declare one player for the game, and an array that will hold all of our rooms. In Cocoa, ````NSMutableArray```` is a subclass of ````NSArray````, meaning it has all of the array's abilities, plus the ability to be mutable, or modifiable.

````
@property (nonatomic, strong) JTPlayer * currentPlayer;
@property (nonatomic, strong) NSMutableArray * rooms;

````

Above that, you'll need to ````#import```` those classes, so our AppDelegate knows about those properties we declared.

````
#import "JTPlayer.h"
#import "JTRoom.h"
````

Now, let's flesh out our logic in the AppDelegate.m. First, I'm going to drop in four methods that allow us to stamp out some rooms quickly in relation to existing rooms.

````
// creating rooms easily

- (JTRoom *)createRoomToNorthOfRoom:(JTRoom *)existingRoom withWidth:(float)newWidth andHeight:(float)newHeight;
{
	JTRoom * newRoom = [[JTRoom alloc] init];
	newRoom.xPosition = existingRoom.xPosition;
	newRoom.yPosition = existingRoom.yPosition - newHeight;
	newRoom.width = newWidth;
	newRoom.height = newHeight;
	
	return newRoom;
}

- (JTRoom *)createRoomToSouthOfRoom:(JTRoom *)existingRoom withWidth:(float)newWidth andHeight:(float)newHeight;
{
	JTRoom * newRoom = [[JTRoom alloc] init];
	newRoom.xPosition = existingRoom.xPosition;
	newRoom.yPosition = existingRoom.yPosition + existingRoom.height;
	newRoom.width = newWidth;
	newRoom.height = newHeight;
	
	return newRoom;
}

- (JTRoom *)createRoomToWestOfRoom:(JTRoom *)existingRoom withWidth:(float)newWidth andHeight:(float)newHeight;
{
	JTRoom * newRoom = [[JTRoom alloc] init];
	newRoom.xPosition = existingRoom.xPosition - newWidth;
	newRoom.yPosition = existingRoom.yPosition;
	newRoom.width = newWidth;
	newRoom.height = newHeight;
	
	return newRoom;
}

- (JTRoom *)createRoomToEastOfRoom:(JTRoom *)existingRoom withWidth:(float)newWidth andHeight:(float)newHeight;
{
	JTRoom * newRoom = [[JTRoom alloc] init];
	newRoom.xPosition = existingRoom.xPosition + existingRoom.width;
	newRoom.yPosition = existingRoom.yPosition;
	newRoom.width = newWidth;
	newRoom.height = newHeight;
	
	return newRoom;
}
````

These methods can take an existing room, and a width and height you define, and set up a new room in the proper place.

Let's update our ````startGame:```` method to use this new stuff. This resets everything, sets up the container for rooms, and creates our player and puts him at zero-zero, which is the middle.

````
- (IBAction)startGame:(id)sender;
{
	self.rooms = [NSMutableArray array];
	
	self.currentPlayer = [[JTPlayer alloc] init];
	self.currentPlayer.xPosition = 0;
	self.currentPlayer.yPosition = 0;
	self.currentPlayer.health = 100;
	
	JTRoom * firstRoom = [[JTRoom alloc] init];
	firstRoom.xPosition = -100;
	firstRoom.yPosition = -100;
	firstRoom.width = 200;
	firstRoom.height = 200;
	
	[self.rooms addObject:firstRoom];
	
	JTRoom * secondRoom = [self createRoomToEastOfRoom:firstRoom withWidth:140 andHeight:30];
	
	[self.rooms addObject:secondRoom];
	
	
	NSLog(@"room: %@", secondRoom);
}
````

and update this method, so 	````startGame```` is called on launch…

````
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	
	[self startGame:nil];
}
````

You can run it at this point, but you won't see any play area yet. Let's add that next.

Right-click and add a new class again. Call it PlayerView this time, and inherit from NSView.

We're going to set this view up with a dataSource - meaning it will query the dataSource every time it needs to update with the position of the player and rooms.

````
@class JTPlayerView;

@protocol JTPlayerViewDataSource <NSObject>

- (NSArray *)roomsToDrawInView:(JTPlayerView *)aView;
- (NSPoint)positionOfPlayerInView:(JTPlayerView *)aView;

@end
````

This code goes above the class to declare how the dataSource works. Then we'll set up an outlet to hook up in the UI, and a way to update this view.

````
@interface JTPlayerView : NSView

@property (nonatomic, assign) IBOutlet id<JTPlayerViewDataSource> dataSource;

- (void)updateView;

@end
````
The ````IBOutlet```` just declares it in a way that interface builder can point to it from code. The ````id```` just genericizes it, meaning it has no specific class.


Then, at the top of the .m, make sure to ````#import "JTRoom.h" ```` and add these two methods:

````

- (void)updateView;
{
	[self setNeedsDisplay:YES];
}


- (void)drawRect:(NSRect)dirtyRect
{
	// fill the whole canvas with white
    [[NSColor whiteColor] set];
	[[NSBezierPath bezierPathWithRect:[self bounds]] fill];
	
	NSPoint centerPoint = NSMakePoint([self bounds].size.width / 2, [self bounds].size.height / 2);
	
	NSArray * rooms = [_dataSource roomsToDrawInView:self];
	
	[[NSColor purpleColor] set];
	[NSBezierPath setDefaultLineWidth:2.0];
	
	// draw the rooms
	for (JTRoom * room in rooms)
	{
		NSRect roomRect = NSMakeRect(centerPoint.x + room.xPosition, centerPoint.y + room.yPosition, room.width, room.height);
		
		[[NSBezierPath bezierPathWithRect:roomRect] stroke];
	}
	
	// draw the player
	[[NSColor redColor] set];
	
	NSPoint playerPoint = [_dataSource positionOfPlayerInView:self];
	
	[[NSBezierPath bezierPathWithRect:NSMakeRect(centerPoint.x + playerPoint.x - 10, centerPoint.y + playerPoint.y - 10, 20, 20)] fill];
	
}
````
The drawRect: method is the meat of it, painting the view with the fills and strokes we give it. ````[self bounds]```` is the entire internal rectangle of the view, which we fill like paint. Like layers of paint, you can fill or draw on all or parts of it, and you can see previous drawing you did where it shows through if you miss a spot.


## UI

Let's place our view into the UI, then hook it up to the AppDelegate and make it work.

In AppDelegate.h, we'll drop in an ````IBOutlet````, so we can manipulate the view in code.

````
@property (assign) IBOutlet JTPlayerView * playerView;
````
Also, do an ````#import "JTPlayerView.h"```` at the top to load in that code.


Click on MainMenu.xib, bring your window up again, and in the Object Library, find "Custom View" about halfway down. Drag it into the window top-left, and resize to fit. In the properties for the view, we must declare the class to "JTPlayerView" and press return.
Confirm it shows in the view itself, then control-drag from your view to "File's Owner", and connect it as dataSource. Then, control-drag back in the other direction and hook it up with playerView.

Once we implement those dataSource methods in the AppDelegate, the view will be able to see the rooms and player's position.

````
- (NSArray *)roomsToDrawInView:(JTPlayerView *)aView;
{
	return self.rooms;
}

- (NSPoint)positionOfPlayerInView:(JTPlayerView *)aView;
{
	return NSMakePoint(self.currentPlayer.xPosition, self.currentPlayer.yPosition);
}
````

Under the very last line of ````startGame````, add this line:
````
[self.playerView updateView];
````

Now we can run it, and see our view get the data and draw it. The updateView calls in the AppDelegate force the view to redraw when our data is ready.

Okay, now let's update our north/south/east/west buttons to move our player around.


````
- (IBAction)goNorth:(id)sender;
{
	self.currentPlayer.yPosition = self.currentPlayer.yPosition + 50;
	
	[self.playerView updateView];
}

- (IBAction)goSouth:(id)sender;
{
	self.currentPlayer.yPosition = self.currentPlayer.yPosition - 50;
	
	[self.playerView updateView];
}

- (IBAction)goEast:(id)sender;
{
	self.currentPlayer.xPosition = self.currentPlayer.xPosition + 50;
	
	[self.playerView updateView];
}

- (IBAction)goWest:(id)sender;
{
	self.currentPlayer.xPosition = self.currentPlayer.xPosition - 50;
	
	[self.playerView updateView];
}
````

And that should do it. You can now run the app, and move your player around.

In future tutorials, we can add artwork, make the keyboard control the player, and add clipping and doors to our rooms, so our player doesn't just walk through these walls.
