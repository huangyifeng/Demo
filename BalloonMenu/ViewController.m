//
//  ViewController.m
//  BalloonMenu
//
//  Created by huang yifeng on 12-10-10.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ViewController.h"
#import "BalloonMenu.h"

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

- (void)teamButtonPressed:(id)sender
{
    BalloonMenu *bm = [[[BalloonMenu alloc] initWithNibName:@"BalloonMenu" bundle:nil] autorelease];
    bm.menuItems = self._balloonToolbar.items;
    [bm showBalloonMenu:self.view fromPoint:[sender center]];
}

@end
