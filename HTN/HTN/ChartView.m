//
//  ChartView.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "ChartView.h"

@interface ChartView (){
    int maxValue;
    UIColor* color[5];
}

@property (nonatomic, strong) JBLineChartView *chartView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) int counter;

@end

@implementation ChartView

-(id)initWithFrame:(CGRect)frame dataSets:(NSInteger)sets max:(CGFloat)maxx{
    self = [super initWithFrame:frame];
    if( self ){
        color[0] = [UIColor greenColor];
        color[1] = [UIColor redColor];
        color[2] = [UIColor blueColor];
        self.chartView = [[JBLineChartView alloc] init];
        self.chartView.frame = CGRectMake(0,0,frame.size.width, frame.size.height);
        self.chartView.delegate = self;
        self.chartView.dataSource = self;
        self.chartView.backgroundColor = [UIColor whiteColor];
        self.chartView.maximumValue = maxx;
        maxValue = maxx;
        self.chartView.minimumValue = 0;
        self.data = [NSMutableArray array];
        for(int i = 0; i<sets; i++)
            [self.data addObject:[NSMutableArray array]];
        [self addSubview:self.chartView];
        [self.chartView reloadData];
        self.counter = 0;
    }
    return self;
}

-(void)addPoint:(CGFloat)point forSet:(NSInteger)set{
    self.counter = (self.counter+1) % 2;
    if( self.counter )
        return;
    while([[self.data objectAtIndex:set] count] >= 30)
        [[self.data objectAtIndex:set] removeObjectAtIndex:0];
    [[self.data objectAtIndex:set] addObject:[NSNumber numberWithFloat:fmin(maxValue, point + maxValue/2)]];
    [self.chartView reloadData];
}

- (BOOL)shouldExtendSelectionViewIntoHeaderPaddingForChartView:(JBChartView *)chartView{
    return YES;
}

- (BOOL)shouldExtendSelectionViewIntoFooterPaddingForChartView:(JBChartView *)chartView{
    return NO;
}

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView{
    return self.data.count;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex{
    return [[self.data objectAtIndex:lineIndex] count];
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex{
    return YES;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex{
    return YES;
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return fmax(0, [[[self.data objectAtIndex:lineIndex] objectAtIndex:horizontalIndex] floatValue]);
}

#define RADIUS 2.5

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex{
    return color[lineIndex];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return color[lineIndex];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex{
    return RADIUS;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return RADIUS;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView verticalSelectionColorForLineAtLineIndex:(NSUInteger)lineIndex{
    return color[lineIndex];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return color[lineIndex];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return color[lineIndex];
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex{
    return JBLineChartViewLineStyleSolid;
}



@end
