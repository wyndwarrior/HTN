//
//  MatchOperation.h
//  HTN
//
//  Created by Yu Xuan Liu on 9/21/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCollector.h"
#import "ActivityMatcher.h"

@protocol MatchOperationDelegate <NSObject>

-(void)didChangeActivity:(NSString*)act;

@end

@interface MatchOperation : NSOperation

-(id)initWithData:(NSArray *)array delegate:(id<MatchOperationDelegate>)del;

@property(atomic, strong) NSArray *data;
@property(atomic, weak) id<MatchOperationDelegate> delegate;
@end
