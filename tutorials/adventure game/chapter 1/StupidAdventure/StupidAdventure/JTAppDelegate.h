//
//  JTAppDelegate.h
//  StupidAdventure
//
//  Created by Jason Terhorst on 11/25/12.
//  Copyright (c) 2012 Jason Terhorst. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "JTPlayerView.h"

#import "JTPlayer.h"
#import "JTRoom.h"

@interface JTAppDelegate : NSObject <JTPlayerViewDataSource, NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet JTPlayerView * playerView;


@property (nonatomic, strong) JTPlayer * currentPlayer;
@property (nonatomic, strong) NSMutableArray * rooms;

- (IBAction)startGame:(id)sender;

- (IBAction)goNorth:(id)sender;
- (IBAction)goSouth:(id)sender;
- (IBAction)goEast:(id)sender;
- (IBAction)goWest:(id)sender;

@end
