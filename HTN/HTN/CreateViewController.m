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
}

@end

@implementation CreateViewController


- (id) init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    [self.tableView addGestureRecognizer:tap];
    
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    frame.origin.y = frame.size.height*2/3-55;
    frame.size.height = frame.size.height/3;
    chart = [[ChartView alloc] initWithFrame:frame dataSets:3 max:300];
    [self.view addSubview:chart];
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
}


-(void)done{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 1){
        
    }
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
        cell.textLabel.text = indexPath.row == 0 ? @"Start recording":@"Clear recording";
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
