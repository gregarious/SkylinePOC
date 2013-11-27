//
//  MarkerView.m
//  SkylinePOC
//
//  Created by Greg Nicholas on 11/22/13.
//  Copyright (c) 2013 Scenable. All rights reserved.
//

#import "MarkerView.h"

@implementation MarkerView

- (id)initWithCoordinate:(CGPoint)coord name:(NSString *)name
{
    self = [super initWithImage:[UIImage imageNamed:@"circle"]];
    if (self) {
        _imageCoordinate = coord;
        _name = name;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
