//
//  MainViewController.h
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyoKit/MyoKit.h>
#import "ChartView.h"
#import "MyoListener.h"
#import "DataCollector.h"
#import "MatchOperation.h"

@interface MainViewController : UITableViewController <MyoListenerProtocol, MatchOperationDelegate, UITableViewDataSource, UITableViewDelegate>

@property(atomic, strong) NSMutableArray *data;

@end
