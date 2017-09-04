//
//  LaunchView.m
//  example
//
//  Created by macOs on 2017/7/23.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "LaunchView.h"

@implementation LaunchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)initView {
    [self scrollView];
    [self pageController];
    [self button];
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIPageControl *)pageController
{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 50, self.frame.size.width - 20, 20)];
        _pageController.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        [self addSubview:_pageController];
    }
    return _pageController;
}

-(UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame: CGRectMake(self.frame.size.width/2 - 50, self.frame.size.height -100, 100, 40)];
        [_button setTitle:@"立即体验" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.hidden =YES;
        [self addSubview:_button];
    }
    return _button;
}

@end
