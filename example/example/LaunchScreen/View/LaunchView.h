//
//  LaunchView.h
//  example
//
//  Created by macOs on 2017/7/23.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchView : UIView

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageController;
@property (strong, nonatomic) UIButton *button;
-(void)initView;

@end
