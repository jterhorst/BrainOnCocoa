//
//  JTPlayerView.m
//  StupidAdventure
//
//  Created by Jason Terhorst on 11/25/12.
//  Copyright (c) 2012 Jason Terhorst. All rights reserved.
//

#import "JTRoom.h"

#import "JTPlayerView.h"

@implementation JTPlayerView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


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

@end
