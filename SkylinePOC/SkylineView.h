//
//  SkylineView.h
//  SkylinePOC
//
//  Created by Greg Nicholas on 11/22/13.
//  Copyright (c) 2013 Scenable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkylineView : UIView

@property (nonatomic, readonly, strong) UIImageView *backgroundView;
@property (nonatomic, readonly, strong) NSArray *markers;

- (id)initWithBackgroundView:(UIImageView *)backgroundView markers:(NSArray *)markers;

@end
