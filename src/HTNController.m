//
//  HTNController.m
//  
//
//  Created by Yu Xuan Liu on 9/20/14.
//
//

#import "HTNController.h"

@implementation HTNController

+(HTNController *)shared{
    static HTNController *shared = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared = [[HTNController alloc] init];
    });
    return shared;
}

-(id)init{
    self = [super init];
    if( self ){
        [TLMHub sharedHub];
    }
    return self;
}

-(void)connect{
    UINavigationController *settings = [TLMSettingsViewController settingsInNavigationController];
    [self.window addSubview:settings.view];
}

@end
