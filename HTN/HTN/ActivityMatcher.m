//
//  ActivityMatcher.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "ActivityMatcher.h"

@implementation ActivityMatcher

#define N 100

+(double)match:(NSArray *)ar1 ar2:(NSArray *)ar2 from1:(int)from1 to1:(int)to1 from2:(int)from2 to2:(int)to2{
    int n1 = MIN(N, (to1-from1+1)),
        n2 = MIN(N, (to2-from2+1));
    
    NSLog(@"%d %d", n1, n2);
    return 0;
}

@end
