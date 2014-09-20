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

-(void)addPoint:(CGFloat)point;

@end
