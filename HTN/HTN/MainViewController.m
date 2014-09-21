//
//  MainViewController.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    MatchOperation *matcher;
    NSOperationQueue *queue;
    UILabel *label;
    int counter;
}

-(void)connect;


@property(nonatomic, strong) ChartView *chart1;

@end

@implementation MainViewController

-(id)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self connect];

    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    self.tabBarItem.title = @"Home";
    
    //if( [self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Calibrate" style:UIBarButtonItemStylePlain target:[MyoListener shared] action:@selector(calibrate)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Pair" style:UIBarButtonItemStylePlain target:self action:@selector(connect)];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"Home";
    
    self.data = [NSMutableArray array];
    queue = [[NSOperationQueue alloc] init];
    matcher = [[MatchOperation alloc] initWithData:self.data delegate:self];
    [queue addOperation:matcher];
    counter = 0;
    
    
    [[TLMHub sharedHub] setShouldNotifyInBackground:YES];
    [[MyoListener shared].delegates addObject:self];
    self.chart1 = [[ChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height/3.0) dataSets:3 max:300];
    [self.view addSubview:self.chart1];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, 320, 30)];
    label.text = @"Rest";
    [self.view addSubview:label];
    
    //UIEdgeInsets inset = UIEdgeInsetsMake(self.view.frame.size.height/3.0, 0, 0, 0);
    //self.tableView.contentInset = inset;
    
}

-(void)calibrate{
    [self.chart1 clear];
    NSArray *ar = [[[DataCollector shared].allData objectAtIndex:counter] objectForKey:@"Data"];
    for(int i = 0; i<ar.count; i+=3){
        [self.chart1 addPoint:[ar[i] floatValue] forSet:0 index:0];
        [self.chart1 addPoint:[ar[i+1] floatValue] forSet:1 index:0];
        [self.chart1 addPoint:[ar[i+2] floatValue] forSet:2 index:0];
    }
    label.text =[[[DataCollector shared].allData objectAtIndex:counter] objectForKey:@"Name"];
    counter = (counter + 1)%[DataCollector shared].allData.count;
}

- (void)connect{
    UINavigationController *settings = [TLMSettingsViewController settingsInNavigationController];
    
    [self presentViewController:settings animated:YES completion:nil];
}


-(void)didChangeActivity:(NSString *)act{
    [label performSelectorOnMainThread:@selector(setText:) withObject:act waitUntilDone:NO];
}

-(void)didReceiveOrientation:(CGFloat)rx ry:(CGFloat)ry rz:(CGFloat)rz
                          dx:(CGFloat)dx dy:(CGFloat)dy dz:(CGFloat)dz{
    [self.chart1 addPoint:dx forSet:0 index:0];
    [self.chart1 addPoint:dy forSet:1 index:0];
    [self.chart1 addPoint:dz forSet:2 index:0];
    
    [self.data addObject:[NSNumber numberWithDouble:dx]];
    [self.data addObject:[NSNumber numberWithDouble:dy]];
    [self.data addObject:[NSNumber numberWithDouble:dz]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 0 )
        return self.view.frame.size.height/3.0;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"PlainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"Test";
    cell.detailTextLabel.text = @"3.5";
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    return cell;
}

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?4:1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section?@"Details":@"Graph";
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
