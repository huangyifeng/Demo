//
//  ViewController.m
//  ScrollToolbar
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ViewController.h"
#import "ScrollToolbarButtonItem.h"
#import "ScrollToolbarButton.h"

@interface ViewController ()

@property(nonatomic, retain)NSArray *scrollToolbarItems;

@end

@implementation ViewController

@synthesize scrollToolbarItems = _scrollToolbarItems;

- (void)dealloc
{
    [_scrollToolbarItems release]; _scrollToolbarItems = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 8; i++)
    {
        ScrollToolbarButtonItem *buttonItem = [[[ScrollToolbarButtonItem alloc] init] autorelease];
        buttonItem.title = [NSString stringWithFormat:@"item%d",i];
        [items addObject:buttonItem];
    }
    self.scrollToolbarItems = items;
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

#pragma mark - ScrollToolbarDataSource

- (NSInteger)numberOfButtonInToolbar:(ScrollToolbar *)toolbar;
{
    return self.scrollToolbarItems.count;
}

- (ScrollToolbarButton *)toolbar:(ScrollToolbar *)toolbar buttonAtPosition:(NSInteger)position
{
    ScrollToolbarButtonItem *item = [self.scrollToolbarItems objectAtIndex:position];
    return [[[ScrollToolbarButton alloc] initWithToolbarItem:item] autorelease];
}


#pragma mark - ScrollToolbarDelegate

@end
