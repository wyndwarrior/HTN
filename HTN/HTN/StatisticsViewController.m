//
//  StatisticsViewController.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/21/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController (){
    NSMutableArray *data;
    UIColor *color[5];
}

@end


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.9]

@implementation StatisticsViewController

-(id)init{
    self = [super init];
    if( self ){
        
        color[0] = UIColorFromRGB(0x90ed7d);
        color[1] = UIColorFromRGB(0xf7a35c);
        color[2] = UIColorFromRGB(0x7cb5ec);
        self.tabBarItem = [[UITabBarItem alloc ] initWithTitle:@"Statistics" image:[UIImage imageNamed:@"bar_graph.png"] tag:0];
        self.navigationItem.title = @"Statistics";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JBBarChartView *barChartView = [[JBBarChartView alloc] initWithFrame:CGRectMake(0, 30, 320, 200)];
    barChartView.dataSource = self;
    barChartView.delegate = self;
    if( [self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:barChartView];
    data = [NSMutableArray array];
    for(int i = 0; i<12; i++)
        [data addObject:[NSNumber numberWithInt:rand()%30]];
    self.view.backgroundColor = [UIColor whiteColor];
    [barChartView reloadData];
    [self.view addSubview:barChartView];
    
    ChartView *chart = [[ChartView alloc] initWithFrame:CGRectMake(0, 240, 320, 200) dataSets:1 max:100];
    for(int i = 0; i<30; i++){
        [chart addPoint:rand()%360 forSet:0 index:0];
    }
    chart.area = true;
    [self.view addSubview:chart];
    //NSLog(@"%@", data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return 12;
}


-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index{
    //NSLog(@"%d %.2f", index, [[data objectAtIndex:index] floatValue]);
    return [[data objectAtIndex:index] floatValue];
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index
{
    return color[index%3];
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
