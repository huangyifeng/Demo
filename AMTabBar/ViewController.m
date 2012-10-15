//
//  ViewController.m
//  AMTabBar
//
//  Created by HuangYiFeng on 10/15/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, retain)NSArray *_dataArray;

- (void)refreshDisplayLabel;

@end

@implementation ViewController

@synthesize tabBar;
@synthesize displayLabel;
@synthesize _dataArray;

- (void)dealloc
{
    [tabBar release];
    [displayLabel release];
    [_dataArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self._dataArray = [NSArray arrayWithObjects:@"item1", @"item2", @"item3", nil];
    [self.tabBar renderWithTitles:self._dataArray];
    
    [self refreshDisplayLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)refreshDisplayLabel
{
    self.displayLabel.text = [self._dataArray objectAtIndex:self.tabBar.selectedIndex];
}

#pragma mark - AMTabBarDelegate
- (void)tabBar:(AMTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    [self refreshDisplayLabel];
}

@end
