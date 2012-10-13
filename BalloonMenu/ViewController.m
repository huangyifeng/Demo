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

@property(nonatomic, retain)BalloonMenu *_balloonMenu;

@end

@implementation ViewController

@synthesize _balloonMenu = _balloonMenu;

- (void)dealloc
{
    [_balloonMenu release]; _balloonMenu = nil;
    [super dealloc];
}

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
    if (!self._balloonMenu)
    {
        self._balloonMenu = [[[BalloonMenu alloc] initWithNibName:@"BalloonMenu" bundle:nil] autorelease];
    }
    self._balloonMenu.menuItems = self._balloonToolbar.items;
    [self._balloonMenu showBalloonMenu:self.view.window fromPoint:[sender center]];
}

@end
