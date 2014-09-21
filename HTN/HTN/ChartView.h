//
//  ChartView.h
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBLineChartView.h"

@interface ChartView : UIView <JBLineChartViewDataSource, JBLineChartViewDelegate>

-(void)addPoint:(CGFloat)point forSet:(NSInteger)set index:(NSInteger)index;
-(id)initWithFrame:(CGRect)frame dataSets:(NSInteger)sets max:(CGFloat)maxx;
-(void)clear;
@property(nonatomic, assign) bool showAll;
@property(nonatomic, assign) int startIndex;
@property(nonatomic, assign) int endIndex;
@property (nonatomic, strong) NSMutableArray *index;
@property(nonatomic, assign) bool area;

@end
