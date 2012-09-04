//
//  AppDelegate.m
//  Demo
//
//  Created by Huang YiFeng on 8/10/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)test1:(NSString *)dateString
{
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    df.dateFormat = @"yyyy-MM-dd";
    
    NSDate *date = [df dateFromString:dateString];
    NSDateFormatter *df2 = [[[NSDateFormatter alloc] init] autorelease];
    df2.dateFormat = @"eee";
    NSLog(@"%@",[df2 stringFromDate:date]);
}

- (void)test2WithLegs:(NSInteger)legs count:(NSInteger)count
{
//    float yushu = (legs - 2*count) % 2;
//    if (0 == yushu)
//    {
//        
//    }
//    
//    if (0 < crane && crane < count)
//    {
//        <#statements#>
//    }
}

- (void)test3
{
//    NSDate *now = [NSDate date];
//    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
//    df.dateFormat = @"HH:mm";
//    df.timeZone = [NSTimeZone timeZoneWithName:<#(NSString *)#>]
    NSString *target = @"22";
    NSArray *arr = [target componentsSeparatedByString:@"1"];
    NSRange range = [target rangeOfString:@"1"];
    NSLog(@"%@",arr);
}

- (void)testArray
{
    NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],
                    [NSNumber numberWithInt:1],
                    [NSNumber numberWithInt:2],
                    nil];
    NSLog(@"before arr is %@",arr);
    
    for (NSNumber *number  in arr)
    {
        number = [NSNumber numberWithInt:10];
        NSLog(@"number is %@",number);
    }
    
    NSLog(@"after arr is %@",arr);
}



- (void)dealloc
{
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
//    [self test1:@"1997-08-08"];
//    [self test3];
    [self testArray];
}

@end
