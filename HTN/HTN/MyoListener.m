//
//  MyoListener.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "MyoListener.h"

@interface MyoListener (){
    CGFloat rx, ry, rz,
    cx, cy, cz;
    clock_t lastTime;
}

@end

@implementation MyoListener


+(MyoListener *)shared{
    static MyoListener *share = nil;
    if( !share )
        share = [[MyoListener alloc] init];
    return share;
}

-(id)init{
    self = [super init];
    if( self ){
        self.delegates = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didConnectDevice:)
                                                     name:TLMHubDidConnectDeviceNotification
                                                   object:nil];
        // Posted whenever a TLMMyo disconnects
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didDisconnectDevice:)
                                                     name:TLMHubDidDisconnectDeviceNotification
                                                   object:nil];
        // Posted whenever the user does a Sync Gesture, and the Myo is calibrated
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didRecognizeArm:)
                                                     name:TLMMyoDidReceiveArmRecognizedEventNotification
                                                   object:nil];
        // Posted whenever Myo loses its calibration (when Myo is taken off, or moved enough on the user's arm)
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didLoseArm:)
                                                     name:TLMMyoDidReceiveArmLostEventNotification
                                                   object:nil];
        // Posted when a new orientation event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveOrientationEvent:)
                                                     name:TLMMyoDidReceiveOrientationEventNotification
                                                   object:nil];
        // Posted when a new accelerometer event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveAccelerometerEvent:)
                                                     name:TLMMyoDidReceiveAccelerometerEventNotification
                                                   object:nil];
        // Posted when a new pose is available from a TLMMyo
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceivePoseChange:)
                                                     name:TLMMyoDidReceivePoseChangedNotification
                                                   object:nil];
    }
    return self;
}



- (void)didConnectDevice:(NSNotification *)notification {
    
}

- (void)didDisconnectDevice:(NSNotification *)notification {
}

- (void)didRecognizeArm:(NSNotification *)notification {
    TLMArmRecognizedEvent *armEvent = notification.userInfo[kTLMKeyArmRecognizedEvent];
    NSString *armString = armEvent.arm == TLMArmRight ? @"Right" : @"Left";
    NSString *directionString = armEvent.xDirection == TLMArmXDirectionTowardWrist ? @"Toward Wrist" : @"Toward Elbow";
}

- (void)didLoseArm:(NSNotification *)notification {
}

static CGFloat calibrate(CGFloat x, CGFloat offset){
    return fmod(fmod(x - offset + 180, 360) + 360, 360);
}

static CGFloat ddx(CGFloat x1, CGFloat x2, CGFloat diff){
    double dx1 = x1-x2,
    dx2 = x1+360-x2,
    dx3 = x1-x2-360,
    adx1 = fabs(dx1),
    adx2 = fabs(dx2),
    adx3 = fabs(dx3),
    ans;
    if( adx1 < adx2 && adx1 < adx3)
        ans = dx1;
    else if( adx2 < adx1 && adx2 < adx3)
        ans = dx2;
    else
        ans = dx3;
    if( fabs( diff ) < 1e-3 )
        return 0;
    //NSLog(@"(%.2f %.2f %.2f %.2f %.2f", adx1, adx2, adx3, ans/diff, ans);
    return 100 * ans / diff;
}

- (void)didReceiveOrientationEvent:(NSNotification *)notification {
    TLMOrientationEvent *orientationEvent = notification.userInfo[kTLMKeyOrientationEvent];
    TLMEulerAngles *angles = [TLMEulerAngles anglesWithQuaternion:orientationEvent.quaternion];
    CGFloat _rx = angles.pitch.degrees;
    CGFloat _ry = angles.yaw.degrees;
    CGFloat _rz = angles.roll.degrees;
    /*[self.chart1 addPoint:calibrate(rx, cx) forSet:0];
     [self.chart1 addPoint:calibrate(ry, cy) forSet:1];
     [self.chart1 addPoint:calibrate(rz, cz) forSet:2];*/
    clock_t old = lastTime;
    clock_t new = clock();
    double diff = (new-old)/1000.0;
    if( diff < 1 )
        return;
    lastTime = new;
    CGFloat dx = ddx(_rx, rx, diff );
    CGFloat dy = ddx(_ry, ry, diff );
    CGFloat dz = ddx(_rz, rz, diff );
    rx = _rx;
    ry = _ry;
    rz = _rz;
    for(id del in self.delegates)
        [del didReceiveOrientation:rx ry:ry rz:rz dx:dx dy:dy dz:dz];
}

- (void)didReceiveAccelerometerEvent:(NSNotification *)notification {
    // Retrieve the accelerometer event from the NSNotification's userInfo with the kTLMKeyAccelerometerEvent.
    TLMAccelerometerEvent *accelerometerEvent = notification.userInfo[kTLMKeyAccelerometerEvent];
    
    // Get the acceleration vector from the accelerometer event.
    GLKVector3 accelerationVector = accelerometerEvent.vector;
    
    // Calculate the magnitude of the acceleration vector.
    float magnitude = GLKVector3Length(accelerationVector);
    
    // Note you can also access the x, y, z values of the acceleration (in G's) like below
    float x = accelerationVector.x;
    float y = accelerationVector.y;
    float z = accelerationVector.z;
    
    /*[self.chart1 addPoint:x+10 forSet:0];
     [self.chart1 addPoint:y+10 forSet:1];
     [self.chart1 addPoint:z+10 forSet:2];*/
}

- (void)didReceivePoseChange:(NSNotification *)notification {
    // Retrieve the pose from the NSNotification's userInfo with the kTLMKeyPose key.
    TLMPose *pose = notification.userInfo[kTLMKeyPose];
    switch (pose.type) {
        case TLMPoseTypeUnknown:
        case TLMPoseTypeRest:
            break;
        case TLMPoseTypeFist:
            break;
        case TLMPoseTypeWaveIn:
            break;
        case TLMPoseTypeWaveOut:
            break;
        case TLMPoseTypeFingersSpread:
            break;
        case TLMPoseTypeThumbToPinky:
            break;
    }
}


@end
