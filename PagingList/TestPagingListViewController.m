//
//  TestPagingListViewController.m
//  Demo
//
//  Created by HuangYiFeng on 9/5/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "TestPagingListViewController.h"
#import "SinglePageViewController.h"

@interface TestPagingListViewController ()

@end

@implementation TestPagingListViewController

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

#pragma mark - override

- (UIViewController *)controllerWithPage:(NSInteger)pageIndex
{
    SinglePageViewController *pager = [[[SinglePageViewController alloc] initWithNibName:@"SinglePageViwController" bundle:nil] autorelease];
    pager.data = pageIndex;
    return pager;
}

- (NSInteger)getTotalPageCount
{
    return 10;
}

@end
