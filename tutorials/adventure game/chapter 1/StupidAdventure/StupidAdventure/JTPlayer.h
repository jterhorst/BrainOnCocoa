//
//  JTPlayer.h
//  StupidAdventure
//
//  Created by Jason Terhorst on 11/25/12.
//  Copyright (c) 2012 Jason Terhorst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTPlayer : NSObject

@property (nonatomic, assign) float xPosition;
@property (nonatomic, assign) float yPosition;

@property (nonatomic, assign) NSUInteger health; // value between 0 and 100

@end
