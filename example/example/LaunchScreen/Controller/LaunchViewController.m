//
//  LaunchViewController.m
//  example
//
//  Created by macOs on 2017/7/23.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "LaunchViewController.h"
#import "LaunchView.h"
#import "LaunchModel.h"
#import "ViewController.h"
#import "HomeViewController.h"

@interface LaunchViewController ()

@property (nonatomic, strong) LaunchView *launchView;
@property (nonatomic, strong) LaunchModel *launchModel;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _launchModel = [[LaunchModel alloc] init];
    NSArray *array = [_launchModel imgArray];
    _launchView = [[LaunchView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_launchView initView];
    [self.view addSubview:_launchView];
    _launchView.scrollView.delegate = self;
    //禁止scrollview下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    _launchView.scrollView.bounces = NO;//设置是否有橡皮筋效果属性
    _launchView.scrollView.pagingEnabled = YES;//设置是否使用分页属性；默认no
    //设置是否允许滚动属性：scrollEnabled；
    _launchView.scrollView.scrollEnabled = YES;
    //设置是否显示水平滚动条属性：showsHorizontalScrollIndicator；
    _launchView.scrollView.showsHorizontalScrollIndicator = NO;
    //设置是否显示竖直滚动条属性：showsVerticalScrollIndicator；
    _launchView.scrollView.showsVerticalScrollIndicator = NO;
    for (int i=0; i < [array count]; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(i*_launchView.scrollView.frame.size.width, 0, _launchView.scrollView.frame.size.width, _launchView.scrollView.frame.size.height)];
        [image setImage:array[i]];
        [_launchView.scrollView addSubview:image];
    }
    //设置内容范围属性：contentSize。
    _launchView.scrollView.contentSize = CGSizeMake([array count]*_launchView.scrollView.frame.size.width, _launchView.scrollView.frame.size.height);
    //设置总页数
    _launchView.pageController.numberOfPages = [array count];
    //设置当前页
    _launchView.pageController.currentPage = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 是否第一次登录或者更新后第一次登录

 @return yes表示第一次
 */
- (BOOL)isFirstLaunched {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"last_run_version_key"]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"last_run_version_key"];
        return YES;
    } else if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"last_run_version_key"] isEqualToString:currentVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"last_run_version_key"];
        return YES;
    }
    return NO;
}

-(void)buttonPressed {
    HomeViewController *controller = [[HomeViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - scrollview
//完成滚动：scrollViewDidScroll；
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    _launchView.pageController.currentPage = index;
    
}

//将要开始拖动：scrollViewWillBeginDragging；

//结束拖动：scrollViewDidEndDragging；

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if(_launchView.pageController.currentPage == (_launchView.pageController.numberOfPages -1) && scrollView.contentOffset.x == _launchView.pageController.currentPage * _launchView.scrollView.frame.size.width) {
        HomeViewController *controller = [[HomeViewController alloc] init];
        [self presentViewController:controller animated:YES completion:nil];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView {
    NSLog(@"结束拖动");
}

//滚动将要开始减速：scrollViewWillBeginDecelerating；

//滚动减速到停止：scrollViewDidEndDecelerating。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_launchView.pageController.currentPage == (_launchView.pageController.numberOfPages -1)) {
        _launchView.button.hidden = NO;
        [_launchView.button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    } else {
        _launchView.button.hidden = YES;
    }
}

//是否滚动到顶部：scrollViewShouldScrollToTop；

//7、滚动到顶部：scrollViewDidScrollToTop。

@end
