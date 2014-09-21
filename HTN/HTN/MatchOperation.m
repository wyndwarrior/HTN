//
//  MatchOperation.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/21/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "MatchOperation.h"

@implementation MatchOperation

-(id)initWithData:(NSArray *)array delegate:(id<MatchOperationDelegate>)del{
    self = [super init];
    if( self ){
        self.data = array;
        self.delegate = del;
    }
    return self;
}

-(void)main{
    while( self.data.count == 0 ){
        sleep(0);
    }
    while( true ){
        NSArray *arr = [DataCollector shared].allData;
        double minx = 1e99;
        int minn = -1;
        for(int i = 0; i<arr.count; i++){
            NSDictionary *dict = [arr objectAtIndex:i];
            NSArray *values = [dict objectForKey:@"Data"];
            if( values.count < self.data.count){
                int maxx = MIN((int)self.data.count * 150/100, (int)self.data.count);
                double score = [ActivityMatcher match:values ar2:self.data from1:0 to1:values.count from2:self.data.count-maxx to2:self.data.count];
                //NSLog(@"%@ %.2f", [dict objectForKey:@"Name"], score);
                if( score < minx){
                    minx = score;
                    minn = i;
                }
            }
        }
        if( minn != -1){
            //NSLog(@"== %@", [[arr objectAtIndex:minn] objectForKey:@"Name"]);
            [self.delegate didChangeActivity:[[arr objectAtIndex:minn] objectForKey:@"Name"]];
        }
    }
}

@end
