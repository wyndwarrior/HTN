//
//  ActivityMatcher.h
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityMatcher : NSObject
+(CGFloat)match:(NSArray *)ar1 ar2:(NSArray *)ar2 from1:(int)from1 to1:(int)to1 from2:(int)from2 to2:(int)to2;
@end
