//
//  homeView.h
//  example
//
//  Created by macOs on 2017/7/23.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView

@property (strong, nonatomic) UIScrollView *bannerView;
@property (strong, nonatomic) UIPageControl *pageControl;

-(void)initBannerView;

@end
