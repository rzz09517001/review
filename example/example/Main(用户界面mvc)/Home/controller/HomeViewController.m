//
//  homeViewController.m
//  example
//
//  Created by macOs on 2017/7/23.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "HomeView.h"
#import "BannerModel.h"

@interface HomeViewController ()

@property (strong, nonatomic) HomeView *homeView;
@property (strong, nonatomic) HomeModel *homeModel;
@property (copy, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) BannerModel *bannerModel;
 @property (nonatomic, strong) NSTimer *timer;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 150)];
    [_homeView initBannerView];
    [self.view addSubview:_homeView];
    _homeView.bannerView.delegate = self;
    _homeModel = [[HomeModel alloc] init];
    _array = [NSMutableArray array];
    _array = [_homeModel bannerResource];
    for (BannerModel *banner in _array) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(banner.id*_homeView.bannerView.frame.size.width, 0, _homeView.bannerView.frame.size.width, _homeView.bannerView.frame.size.height)];
        [image setImage:[UIImage imageNamed:banner.img]];
        [image setTag:banner.id];
        UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgPressed:)];
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:tapGesturRecognizer];
        [_homeView.bannerView addSubview:image];
        if (banner.id == 1) {
            UIImageView *lastImg = [[UIImageView alloc] initWithFrame:CGRectMake(([_array count] + 1)*_homeView.bannerView.frame.size.width, 0, _homeView.bannerView.frame.size.width, _homeView.bannerView.frame.size.height)];
            [lastImg setImage:[UIImage imageNamed:banner.img]];
            [lastImg setTag:banner.id];
            lastImg.userInteractionEnabled = YES;
            [lastImg addGestureRecognizer:tapGesturRecognizer];
            [_homeView.bannerView addSubview:lastImg];
        } else if (banner.id == [_array count]) {
            UIImageView *firstImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _homeView.bannerView.frame.size.width, _homeView.bannerView.frame.size.height)];
            [firstImg setImage:[UIImage imageNamed:banner.img]];
            [firstImg setTag:banner.id];
            firstImg.userInteractionEnabled = YES;
            [firstImg addGestureRecognizer:tapGesturRecognizer];
            [_homeView.bannerView addSubview:firstImg];
        }
    }
    //禁止scrollview下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    _homeView.bannerView.bounces = NO;//设置是否有橡皮筋效果属性
    _homeView.bannerView.pagingEnabled = YES;//设置是否使用分页属性；默认no
    //设置是否允许滚动属性：scrollEnabled；
    _homeView.bannerView.scrollEnabled = YES;
    //设置是否显示水平滚动条属性：showsHorizontalScrollIndicator；
    _homeView.bannerView.showsHorizontalScrollIndicator = NO;
    //设置是否显示竖直滚动条属性：showsVerticalScrollIndicator；
    _homeView.bannerView.showsVerticalScrollIndicator = NO;
    //设置内容范围属性：contentSize。
    _homeView.bannerView.contentSize = CGSizeMake(([_array count]+2)*_homeView.bannerView.frame.size.width,  _homeView.bannerView.frame.size.height);
    _homeView.bannerView.contentOffset = CGPointMake(_homeView.bannerView.frame.size.width, 0);
    //设置总页数
     _homeView.pageControl.numberOfPages = [_array count];
    //设置当前页
     _homeView.pageControl.currentPage = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //开启定时器
    [super viewWillAppear:animated];
    [self addTimer];
}

-(void)viewDidDisappear:(BOOL)animated
{
    //关闭定时器
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
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
 响应图片点击事件

 @param gesture 手势
 */
-(void)imgPressed:(UITapGestureRecognizer *)gesture {
    UIView *view = [gesture view];
    NSInteger id = view.tag;
    for (BannerModel *banner in _array) {
        if (id == banner.id) {
            NSLog(@"%ld",id);
        }
    }
}


/**
 开启定时器
 */
-(void)addTimer {
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImg) userInfo:nil repeats:YES];
}


-(void)nextImg {
    NSInteger page = _homeView.pageControl.currentPage;
    [_homeView.bannerView setContentOffset:CGPointMake((page+2)*_homeView.bannerView.frame.size.width, 0) animated:YES];
}
#pragma mark - UIScrollViewDelegate
//完成滚动：scrollViewDidScroll；只要滚动就触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    if (index < 1) {
        _homeView.pageControl.currentPage = [_array count] -1;
        _homeView.bannerView.contentOffset = CGPointMake([_array count]*_homeView.bannerView.frame.size.width, 0);
    } else if (index > [_array count]) {
        _homeView.pageControl.currentPage = 0;
        _homeView.bannerView.contentOffset = CGPointMake(_homeView.bannerView.frame.size.width, 0);
    } else {
        _homeView.pageControl.currentPage = index - 1;
    }
}


/**
 滚动减速到停止时触发

 @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{

}


/**
 开始拖拽的时候关闭定时器

 @param scrollView <#scrollView description#>
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate distantFuture]];
}


/**
 结束拖拽的时候开启定时器

 @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}

@end
