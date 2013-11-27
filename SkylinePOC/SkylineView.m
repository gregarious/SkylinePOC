//
//  SkylineView.m
//  SkylinePOC
//
//  Created by Greg Nicholas on 11/22/13.
//  Copyright (c) 2013 Scenable. All rights reserved.
//

#import "SkylineView.h"
#import "MarkerView.h"

@interface SkylineView ()
{
    NSMutableArray *localConstraints;
}
@end

@implementation SkylineView

- (id)initWithBackgroundView:(UIImageView *)backgroundView markers:(NSArray *)markers
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _backgroundView = backgroundView;
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_backgroundView];
        
        _markers = markers;
        for (MarkerView* marker in _markers) {
            marker.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:marker];
        }
    }
    return self;
}

- (void)updateConstraints
{
    if (localConstraints == nil) {
        localConstraints = [NSMutableArray new];
        
        // attach image to top & left edges (also set view's width/height by attaching to bottom & right edges)
        [localConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[background]|"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:@{@"background": self.backgroundView}]];
        [localConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[background]|"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:@{@"background": self.backgroundView}]];

        // add x,y position for markers
        for (MarkerView* marker in self.markers) {
            NSNumber *xPos = [NSNumber numberWithFloat:marker.imageCoordinate.x];
            NSNumber *yPos = [NSNumber numberWithFloat:marker.imageCoordinate.y];
            [localConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-xPos-[marker]"
                                                                                          options:0
                                                                                          metrics:@{@"xPos": xPos}
                                                                                            views:@{@"marker": marker}]];
            [localConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-yPos-[marker]"
                                                                                          options:0
                                                                                          metrics:@{@"yPos": yPos}
                                                                                            views:@{@"marker": marker}]];
        }
        [self addConstraints:localConstraints];
    }
    
    [super updateConstraints];
}

@end
