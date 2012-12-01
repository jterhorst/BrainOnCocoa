//
//  JTAppDelegate.m
//  StupidAdventure
//
//  Created by Jason Terhorst on 11/25/12.
//  Copyright (c) 2012 Jason Terhorst. All rights reserved.
//

#import "JTAppDelegate.h"

@implementation JTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	
	[self startGame:nil];
}


- (NSArray *)roomsToDrawInView:(JTPlayerView *)aView;
{
	return self.rooms;
}

- (NSPoint)positionOfPlayerInView:(JTPlayerView *)aView;
{
	return NSMakePoint(self.currentPlayer.xPosition, self.currentPlayer.yPosition);
}




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
	
	[self.playerView updateView];
}


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


@end
