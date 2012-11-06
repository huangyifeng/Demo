//
//  ViewController.m
//  TwoSideSlideMenu
//
//  Created by HuangYiFeng on 11/6/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "ViewController.h"
#import <Crashlytics/Crashlytics.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - IBAction

- (void)buttonPressed:(id)sender
{
    [[Crashlytics sharedInstance] crash];
}

@end
