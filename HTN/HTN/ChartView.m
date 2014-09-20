//
//  ChartView.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "ChartView.h"

@interface ChartView ()

@property (nonatomic, strong) JBLineChartView *chartView;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ChartView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if( self ){
        self.chartView = [[JBLineChartView alloc] init];
        self.chartView.frame = CGRectMake(0,0,frame.size.width, frame.size.height);
        self.chartView.delegate = self;
        self.chartView.dataSource = self;
        self.chartView.backgroundColor = [UIColor yellowColor];
        self.chartView.maximumValue = 360;
        self.chartView.minimumValue = 0;
        self.data = [NSMutableArray array];
        [self addSubview:self.chartView];
        [self.chartView reloadData];
    }
    return self;
}

-(void)addPoint:(CGFloat)point{
    while(self.data.count >= 100)
        [self.data removeObjectAtIndex:0];
    [self.data addObject:[NSNumber numberWithFloat:point]];
    [self.chartView reloadData];
}

- (BOOL)shouldExtendSelectionViewIntoHeaderPaddingForChartView:(JBChartView *)chartView{
    return YES;
}

- (BOOL)shouldExtendSelectionViewIntoFooterPaddingForChartView:(JBChartView *)chartView{
    return NO;
}

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex{
    return self.data.count;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex{
    return YES;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex{
    return YES;
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return [[self.data objectAtIndex:horizontalIndex] floatValue];
}


- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex{
    return [UIColor blueColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return [UIColor blueColor];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex{
    return 1.0;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return 1.0;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView verticalSelectionColorForLineAtLineIndex:(NSUInteger)lineIndex{
    return [UIColor whiteColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor blackColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return [UIColor greenColor];
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex{
    return JBLineChartViewLineStyleSolid;
}



@end
