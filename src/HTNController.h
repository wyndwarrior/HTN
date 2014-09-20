//
//  HTNController.h
//  
//
//  Created by Yu Xuan Liu on 9/20/14.
//
//

#import <Foundation/Foundation.h>
#import <MyoKit/MyoKit.h>

@interface HTNController : NSObject

@property(nonatomic, strong) UIWindow *window;

+(HTNController *)shared;
-(void)connect;


@end
