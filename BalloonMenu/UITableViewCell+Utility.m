//
//  UITableViewCell+Utility.m
//  Gemini
//
//  Created by minoru_kojima on 11/05/26.
//  Copyright 2011 Cybozu, Inc. All rights reserved.
//

#import "UITableViewCell+Utility.h"


@implementation UITableViewCell (Utility)

+ (id)cellWithNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName
                                                 owner:self
                                               options:nil];

    for (id oneObject in nib)
    {
        if ([oneObject isKindOfClass:[UITableViewCell class]])
        {
            return oneObject;
        }
    }

    return nil;
}

@end
