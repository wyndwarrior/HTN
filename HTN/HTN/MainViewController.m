//
//  MainViewController.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

-(void)setupOnce;
-(void)connect;


@property(nonatomic, strong) ChartView *chart1;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
    [self connect];
    [self setupOnce];
    
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    self.tabBarItem.title = @"Home";
    
    if( [self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Calibrate" UIBarButtonItemStylePlain target:self action:@selector(calibrate)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Pair" style:UIBarButtonItemStylePlain target:self action:@selector(connect)];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"Home";
    
}

- (void)connect{
    UINavigationController *settings = [TLMSettingsViewController settingsInNavigationController];
    
    [self presentViewController:settings animated:YES completion:nil];
}

- (void)setupOnce{
    [[TLMHub sharedHub] setShouldNotifyInBackground:YES];
    
    self.chart1 = [[ChartView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) dataSets:3 max:300];
    [self.view addSubview:self.chart1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
