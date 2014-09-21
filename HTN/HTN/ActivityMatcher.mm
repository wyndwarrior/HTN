//
//  ActivityMatcher.m
//  HTN
//
//  Created by Yu Xuan Liu on 9/20/14.
//  Copyright (c) 2014 Yu Xuan Liu. All rights reserved.
//

#import "ActivityMatcher.h"
#import <vector>
using namespace std;

typedef struct __v3 {
    double x,y,z;
} v3;

@implementation ActivityMatcher


#define N 100

/*
 
 ----------ar2----------
       |--ar1--|
 */

static void convert(vector<v3> & vec, NSArray* ar, int from, int to, int & groupsize){
    int n = to-from;
    int mn = MIN(N, n);
    
    if( groupsize == -1 )
        groupsize = n/mn;

    for(int i = from; i + groupsize<to; i+=groupsize){
        v3 vv;
        vv.x = vv.y = vv.z = 0;
        for(int k = 0; k<groupsize; k++){
            vv.x += [[ar objectAtIndex:i * 3 + k * 3 + 0] doubleValue];
            vv.y += [[ar objectAtIndex:i * 3 + k * 3 + 1] doubleValue];
            vv.z += [[ar objectAtIndex:i * 3 + k * 3 + 2] doubleValue];
        }
        vv.x /= groupsize;
        vv.y /= groupsize;
        vv.z /= groupsize;
        vec.push_back(vv);
    }
}

static double dist(v3 v1){
    return v1.x*v1.x+v1.y*v1.y+v1.z*v1.z;
}

+(double)match:(NSArray *)ar1 ar2:(NSArray *)ar2 from1:(int)from1 to1:(int)to1 from2:(int)from2 to2:(int)to2{
    from1/=3; to1/=3; from2/=3; to2/=3;
    //NSLog(@"%d %d %d %d", from1, to1, from2, to2);
    int groupsize = -1;
    vector<v3> v1, v2;
    //convert(v1, @[@1,@1,@1,@2,@2,@2,@3,@3,@3,@4,@4,@4], 0, 4, groupsize);
    convert(v1, ar1, from1, to1, groupsize);
    convert(v2, ar2, from2, to2, groupsize);
    //for(int i = 0; i<v2.size(); i++)
    //    NSLog(@"%d %.2f %.2f %.2f", i, v2[i].x, v2[i].y, v2[i].z);
    
    vector<vector<double> > mat(v1.size()+1);
    for(int i = 0; i<=v1.size(); i++)
        for(int j = 0; j <= v2.size(); j++){
            mat[i].push_back(0);
            if( i >= 1 && j >= 1){
                v3 vv;
                vv.x = fabs(v1[i-1].x - v2[j-1].x);
                vv.y = fabs(v1[i-1].y - v2[j-1].y);
                vv.z = fabs(v1[i-1].z - v2[j-1].z);
                double ddist = dist(vv);
                double dist1 = mat[i-1][j],
                dist2 = mat[i][j-1],
                dist3 = mat[i-1][j-1];
                mat[i][j] = ddist + MIN(MIN(dist1, dist2), dist3);
                //NSLog(@"%d %d = %.2f %.2f %.2f", i, j, mat[i][j].x, mat[i][j].y, mat[i][j].z);
            }
        }
    return mat[v1.size()][v2.size()];
}

@end
