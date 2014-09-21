//
//  DataCollector.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "DataCollector.h"

@implementation DataCollector

+(DataCollector *)shared{
    static DataCollector *share = nil;
    if( !share )
        share = [[DataCollector alloc] init];
    return share;
}

-(id)init{
    self = [super init];
    if( self ){
        [self initPrefs];
        if( [prefs objectForKey:@"Data"]){
            self.allData = [prefs objectForKey:@"Data"];
            /*if( self.allData.count >=  2){
                //NSArray *a1 = [[self.allData objectAtIndex:0] objectForKey:@"Data"];
                //NSArray *a2 = [[self.allData objectAtIndex:1] objectForKey:@"Data"];
                //[ActivityMatcher match:a1 ar2:a2 from1:0 to1:a1.count from2:0 to2:a2.count];
            }*/
            
            //NSLog(@"%.2f", [ActivityMatcher match:@[@1,@1,@1,@2,@2,@2,@3,@3,@3,@4,@4,@4] ar2:@[@1,@1,@1,@2,@2,@2,@3,@3,@3,@4,@4,@4] from1:0 to1:4 from2:0 to2:4]);
        }else
            self.allData = [NSMutableArray array];
    }
    return self;
}

-(void)addData:(NSDictionary *) dict{
    [self.allData addObject:dict];
    [self setPref:@"Data" val:self.allData];
}


-(void)initPrefs{
    if( !prefs )
        prefs = [NSMutableDictionary dictionaryWithContentsOfFile:PREFSFILE];
    if( !prefs ) prefs = [NSMutableDictionary dictionary];
}

-(void)setPref:(NSString *)k val:(id)obj{
    [self initPrefs];
    if( obj)
        [prefs setObject:obj forKey:k];
    else [prefs removeObjectForKey:k];
    [self save];
}

-(void)save{
    
    [DataCollector savePlist:prefs toFile:PREFSFILE];
}

+(void)savePlist:(id)plist toFile:(NSString *)file{
    NSString *err = nil;
    [[NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListBinaryFormat_v1_0 errorDescription:&err] writeToFile:file atomically:YES];
}

@end
