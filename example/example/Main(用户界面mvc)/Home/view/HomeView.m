//
//  homeView.m
//  example
//
//  Created by macOs on 2017/7/23.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)initBannerView {
    [self scrollView];
    [self pageControl];
    
}

-(UIScrollView *)scrollView {
    if (!_bannerView) {
        _bannerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 150)];
        _bannerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_bannerView];
    }
    return _bannerView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, 150, self.frame.size.width - 20, 10)];
        _pageControl.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

@end
