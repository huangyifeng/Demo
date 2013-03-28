//
//  TwoSideSlideMenu.m
//  Demo
//
//  Created by huang yifeng on 12-11-6.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "TwoSideSlideMenu.h"

@interface TwoSideSlideMenu ()

@property(nonatomic, retain)UIViewController    *_frontController;
@property(nonatomic, retain)UIViewController    *_leftController;
@property(nonatomic, retain)UIViewController    *_rightController;

@end

@implementation TwoSideSlideMenu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
