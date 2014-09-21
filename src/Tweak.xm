#import "Headers/SBUIController.h"
#import "Headers/SBApplicationIcon.h"
#import "HTNController.h"

%hook SBUIController
-(id)init{
    %orig;
    //[[[UIAlertView alloc] initWithTitle:@"Alert" message:@"hi2" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    [HTNController shared].window = self.window;
    return self;
}

-(void)launchIcon:(id)arg1 fromLocation:(int)arg2{
    if(![[[arg1 application] bundleIdentifier] isEqualToString:@"com.google.ios.youtube"]){
        %orig;
        return;
    }
    [[[UIAlertView alloc] initWithTitle:@"This app is locked" message:@"It appears that you did not meet your fitness goals for the day. Please complete your activities to unlock this app." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
}

%end
