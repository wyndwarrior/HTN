//
//  CreateViewController.h
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWFieldCell.h"
#import "ChartView.h"
#import "MyoListener.h"
#import "DataCollector.h"

@interface CreateViewController : UITableViewController <UITextFieldDelegate, UIGestureRecognizerDelegate, MyoListenerProtocol>{
    
    CWFieldCell *nameField;
    CWFieldCell *numberField;
}

@end
