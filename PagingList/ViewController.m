//
//  ViewController.m
//  PagingList
//
//  Created by HuangYiFeng on 9/4/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "ViewController.h"
#import "TestPagingListViewController.h"

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

- (void)showPagingList:(id)sender
{
    TestPagingListViewController *test = [[[TestPagingListViewController alloc] init] autorelease];
    [self presentModalViewController:test animated:YES];
}

@end
