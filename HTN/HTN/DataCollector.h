//
//  DataCollector.h
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityMatcher.h"

#define DOCS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define PREFSFILE [DOCS stringByAppendingPathComponent:@"prefs.plist"]

@interface DataCollector : NSObject{
    NSMutableDictionary *prefs;
}

@property(nonatomic, strong) NSMutableArray *allData;

+(DataCollector *)shared;
-(void)addData:(NSDictionary *)dict;
+(void)savePlist:(id)plist toFile:(NSString *)file;
-(void)setPref:(NSString *)k val:(id)obj;
-(void)initPrefs;

@end
