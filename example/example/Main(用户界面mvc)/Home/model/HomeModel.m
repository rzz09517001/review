//
//  homeModel.m
//  example
//
//  Created by macOs on 2017/7/23.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "HomeModel.h"
#import <UIKit/UIKit.h>
#import "BannerModel.h"

@implementation HomeModel


-(NSMutableArray *)bannerResource {
    NSMutableArray *banners = [NSMutableArray array];
    for (int i = 1; i < 7; i ++) {
        BannerModel *bannerModel = [[BannerModel alloc] init];
        bannerModel.id = i;
        bannerModel.name  = [NSString stringWithFormat:@"banner - %d", i];
        bannerModel.href  = @"http://www.baidu.com";
        bannerModel.img = [NSString stringWithFormat:@"banner-%d.jpg",i];
        [banners addObject:bannerModel];
    }
    return banners;
}

@end
