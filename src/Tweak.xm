#import "Headers/SBUIController.h"
#import "Headers/SBApplicationIcon.h"
#import "HTNController.h"

%hook SBUIController
-(id)init{
    %orig;
    [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"hi2" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    [HTNController shared].window = self.window;
    return self;
}

-(void)launchIcon:(id)arg1 fromLocation:(int)arg2{
    if(![[[arg1 application] bundleIdentifier] isEqualToString:@"com.wynd.dreamboard"]){
        %orig;
        return;
    }
    [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Nopeeee" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    [[HTNController shared] connect];
}

%end
