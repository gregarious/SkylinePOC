//
//  ViewController.m
//  SkylinePOC
//
//  Created by Greg Nicholas on 11/22/13.
//  Copyright (c) 2013 Scenable. All rights reserved.
//

#import "ViewController.h"
#import "MarkerView.h"
#import "SkylineView.h"

@interface ViewController ()
{
    UIScrollView *scrollView;
    SkylineView *skylineView;
    UIView *detailView;
    NSMutableArray *detailViewConstraints;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    scrollView = [UIScrollView new];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.backgroundColor = [UIColor grayColor];
    
    // support hiding the detail pane when tapped
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(hideDetailPane)]];

    [self.view addSubview:scrollView];

    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skyline"]];
    
    NSArray *markers = @[[[MarkerView alloc] initWithCoordinate:CGPointMake(44, 125) name:@"Heinz Field"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(686, 60) name:@"U.S. Steel Tower"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(419, 92) name:@"One PPG Place"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(715, 70) name:@"Smithfield Street Bridge"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(700, 94) name:@"One Oxford Centre"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(787, 304) name:@"Landmarks Building"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(842, 167) name:@"PNC Firstside Center"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(984, 98) name:@"University of Pittsburgh’s Cathedral of Learning"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(759, 96) name:@"Grant Building"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(725, 70) name:@"BNY Mellon Center"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(1048, 164) name:@"Three Rivers Heritage Trail"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(971, 130) name:@"Duquesne University"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(296, 145) name:@"11 Stanwix Street"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(362, 172) name:@"151 First Side"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(101, 532) name:@"K&L Gates Center"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(606, 112) name:@"Henry W. Oliver Building"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(656, 111) name:@"525 William Penn Place"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(323, 275) name:@"Station Square"],
                         [[MarkerView alloc] initWithCoordinate:CGPointMake(497, 246) name:@"Monongahela River"]];
    for (MarkerView *marker in markers) {
        marker.userInteractionEnabled = YES;
        [marker addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(handleMarkerTap:)]];
    }
    
    skylineView = [[SkylineView alloc] initWithBackgroundView:backgroundView markers:markers];
    [scrollView addSubview:skylineView];
    

    
    // fill entire contents of main view frame with scroll view
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"scrollView": scrollView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"scrollView": scrollView}]];

    // attach scroll view's content view to all edges
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[skyline]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"skyline": skylineView}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[skyline]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"skyline": skylineView}]];
    
    self.navigationItem.title = @"Grandview Avenue";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain
                                                                            target:nil action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleMarkerTap:(UITapGestureRecognizer *)sender
{
    MarkerView *marker = (MarkerView *)sender.view;
    [self showDetailPaneForMarker:marker];
}

- (void)showDetailPaneForMarker:(MarkerView *)markerView
{
    detailView = [UIView new];
    detailView.backgroundColor = [UIColor whiteColor];
    
    /** configure name label **/
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, self.topLayoutGuide.length+20, 300, 30)];
    label.text = markerView.name;
    [detailView addSubview:label];
    
    [self.view addSubview:detailView];
    
    /** configure swipe right close action **/
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(hideDetailPane)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [detailView addGestureRecognizer:swipeRecognizer];
    
    /** disable and readjust scroll view **/
    [scrollView setScrollEnabled:NO];

    CGFloat anchorX = markerView.imageCoordinate.x-((1.0/6.0)*self.view.frame.size.width)+.5*markerView.frame.size.width;
    // clamp content of scroll view to left edge
    if (anchorX < 0) {
        anchorX = 0.0;
    }
    // TODO: add logic to clamp scroll view content to right edge of visible part of view
    
    [scrollView setContentOffset:CGPointMake(anchorX, 0) animated:YES];

    
    /** set layout constraints for detail view **/
    detailView.translatesAutoresizingMaskIntoConstraints = NO;
    NSNumber *detailWidth = [NSNumber numberWithFloat:self.view.frame.size.width*2/3];
    
    detailViewConstraints = [NSMutableArray new];
    [detailViewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailView]|"
                                                                                       options:0
                                                                                       metrics:nil
                                                                                         views:@{@"detailView": detailView}]];

    [detailViewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[detailView(detailWidth)]|"
                                                                                       options:0
                                                                                       metrics:@{@"detailWidth": detailWidth}
                                                                                         views:@{@"detailView": detailView}]];
    [self.view addConstraints:detailViewConstraints];

    
    /** hide all markers that are not the one tapped **/
    for (MarkerView *m in skylineView.markers) {
        if (m != markerView) {
            m.hidden = YES;
        }
    }
}

- (void)hideDetailPane
{
    // remove detail view constraints
    if (detailViewConstraints != nil) {
        [self.view removeConstraints:detailViewConstraints];
        detailViewConstraints = nil;
    }

    // remove detail view
    [detailView removeFromSuperview];
    detailView = nil;

    // show all markers
    for (MarkerView *m in skylineView.markers) {
        m.hidden = NO;
    }
    
    // ensure scroll view snaps back to right edge
    if (scrollView.contentOffset.x > skylineView.frame.size.width - scrollView.frame.size.width) {
        CGPoint maxOffset = scrollView.contentOffset;
        maxOffset.x = skylineView.frame.size.width - scrollView.frame.size.width - 1;
        [scrollView setContentOffset:maxOffset animated:YES];
    }
    [scrollView setScrollEnabled:YES];
}


@end
