//
//  ViewController.m
//  PinchMe
//
//  Created by macOs on 2017/7/4.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController {
    CGFloat scale, previousScale;//当前缩放比例，先前缩放比例
    CGFloat rotation, previousRotation;//当前旋转角度，先前旋转角度
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    previousScale = 1;
    
    UIImage *image = [UIImage imageNamed:@"yosemite-meadows.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.userInteractionEnabled = YES;//启用用户交互
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
   
    //捏合手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doPinch:)];
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
    
    //旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(doRotate:)];
    rotationGesture.delegate = self;
    [self.imageView addGestureRecognizer:rotationGesture];
}

/**
 允许捏合和旋转同时工作

 @param gestureRecognizer <#gestureRecognizer description#>
 @param otherGestureRecognizer <#otherGestureRecognizer description#>
 @return <#return value description#>
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


/**
 对图像处理
 */
- (void)transformImageView {
    CGAffineTransform t = CGAffineTransformMakeScale(scale * previousScale, scale * previousScale);
    t = CGAffineTransformRotate(t, rotation + previousRotation);
    self.imageView.transform = t;
}

- (void)doPinch:(UIPinchGestureRecognizer *)gesture {
    scale = gesture.scale;
    [self transformImageView];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        previousScale = scale * previousScale;
        scale = 1;
    }
}

- (void)doRotate:(UIRotationGestureRecognizer *)gesture {
    rotation = gesture.rotation;
    [self transformImageView];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        previousRotation = rotation + previousRotation;
        rotation = 0;
    }
}

@end
