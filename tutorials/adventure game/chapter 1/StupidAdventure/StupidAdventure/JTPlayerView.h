//
//  JTPlayerView.h
//  StupidAdventure
//
//  Created by Jason Terhorst on 11/25/12.
//  Copyright (c) 2012 Jason Terhorst. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JTPlayerView;

@protocol JTPlayerViewDataSource <NSObject>

- (NSArray *)roomsToDrawInView:(JTPlayerView *)aView;
- (NSPoint)positionOfPlayerInView:(JTPlayerView *)aView;

@end


@interface JTPlayerView : NSView

@property (nonatomic, assign) IBOutlet id<JTPlayerViewDataSource> dataSource;

- (void)updateView;

@end
