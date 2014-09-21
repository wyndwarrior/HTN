//
//  MyoListener.h
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MyoKit/MyoKit.h>

@protocol MyoListenerProtocol <NSObject>

-(void)didReceiveOrientation:(CGFloat)rx ry:(CGFloat)ry rz:(CGFloat)rz
                          dx:(CGFloat)dx dy:(CGFloat)dy dz:(CGFloat)dz;

@end

@interface MyoListener : NSObject{
    
}

@property(nonatomic, weak) id<MyoListenerProtocol> delegate;

@end
