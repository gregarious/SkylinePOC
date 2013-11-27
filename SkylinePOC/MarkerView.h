//
//  MarkerView.h
//  SkylinePOC
//
//  Created by Greg Nicholas on 11/22/13.
//  Copyright (c) 2013 Scenable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkerView : UIImageView

@property (nonatomic, assign) CGPoint imageCoordinate;
@property (nonatomic, copy) NSString *name;

- (id)initWithCoordinate:(CGPoint)coord name:(NSString *)name;

@end
