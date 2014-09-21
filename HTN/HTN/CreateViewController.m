//
//  CreateViewController.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController (){
    ChartView *chart;
    NSMutableArray *data;
    bool recording;
}

-(void)startRecording;
-(void)stopRecording;

@end

@implementation CreateViewController


- (id) init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    recording = false;
    if( [self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    UINavigationItem *item = self.navigationItem;
    item.title = @"New Activity";
    
    UINib *nib = [UINib nibWithNibName:@"CWFieldCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CWFieldCell"];
    
    nameField = [self.tableView dequeueReusableCellWithIdentifier:@"CWFieldCell"];
    nameField.label.text = @"Name";
    nameField.field.delegate = self;
    
    numberField = [self.tableView dequeueReusableCellWithIdentifier:@"CWFieldCell"];
    numberField.field.keyboardType = UIKeyboardTypeNumberPad;
    numberField.label.text = @"Amount/day";
    numberField.field.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign)];
    tap.delegate = self;
    //[self.tableView addGestureRecognizer:tap];
    
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    frame.origin.y = frame.size.height*2/3-55;
    frame.size.height = frame.size.height/3;
    chart = [[ChartView alloc] initWithFrame:frame dataSets:3 max:300];
    [self.view addSubview:chart];
}


-(void)didReceiveOrientation:(CGFloat)rx ry:(CGFloat)ry rz:(CGFloat)rz
                          dx:(CGFloat)dx dy:(CGFloat)dy dz:(CGFloat)dz{
    [chart addPoint:dx forSet:0];
    [chart addPoint:dy forSet:1];
    [chart addPoint:dz forSet:2];
    [data addObject:[NSNumber numberWithDouble:dx]];
    [data addObject:[NSNumber numberWithDouble:dy]];
    [data addObject:[NSNumber numberWithDouble:dz]];
}

-(void)resign{
    [nameField.field resignFirstResponder];
    [numberField.field resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[MyoListener shared].delegates removeObject:self];
}


-(void)done{
    NSLog(@"%@ %@", nameField.field.text, numberField.field.text);
    [[DataCollector shared] addData:@{@"Name":nameField.field.text,
                                      @"Amount":numberField.field.text,
                                      @"Data":data}];
    [self cancel];
}

-(void)startRecording{
    if( !data )
        data = [NSMutableArray array];
    [[MyoListener shared].delegates addObject:self];
}

-(void)stopRecording{
    [[MyoListener shared].delegates removeObject:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 1){
        [self resign];
        if( indexPath.row == 0 ){
            recording = !recording;
            [self.tableView reloadData];
            if( recording ){
                [self startRecording];
            }else{
                [self stopRecording];
            }
        }else if( indexPath.row == 1){
            data = [NSMutableArray array];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"PlainCell";
    
    UITableViewCell *cell = nil;
    
    if(indexPath.section == 0)
    switch (indexPath.row) {
        case 0: cell = nameField; break;
        case 1: cell = numberField; break;
        default:
            break;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = indexPath.row == 0 ? (recording?@"Stop recording":@"Start recording"):@"Clear recording";
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return cell;
}

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath == 0)
    return NO;
    return YES;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if( section == 0 )
    return @"Details";
    return @"Recording";
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
