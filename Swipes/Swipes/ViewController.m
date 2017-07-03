//
//  ViewController.m
//  Swipes
//
//  Created by macOs on 2017/7/3.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) CGPoint gestureStartPoint;

@end

//static CGFloat const kMinimumGestureLength = 25;
//static CGFloat const kMaximumVariance      = 5;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVertivalSwipe:)];
    //vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    //[self.view addGestureRecognizer:vertical];
    
    //UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
    //horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    //[self.view addGestureRecognizer:horizontal];
    //for循环处理多个手指的情况
    for (NSUInteger i =1; i <= 5; i ++) {
        UISwipeGestureRecognizer *vertical;
        vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVertivalSwipe:)];
        vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
        vertical.numberOfTouchesRequired = i;
        [self.view addGestureRecognizer:vertical];
        
        UISwipeGestureRecognizer *horizontal;
        horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
        horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        horizontal.numberOfTouchesRequired = i;
        [self.view addGestureRecognizer:horizontal];
    }
}

- (void)eraseText {
    self.label.text = @"";
}


- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recognizer {
    //self.label.text = @"Horizontal swipe detected";
    self.label.text = [NSString stringWithFormat:@"%@ Horizontal swipe detected",[self descriptionForTouchCount:[recognizer numberOfTouches]]];
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
}

- (void)reportVertivalSwipe:(UIGestureRecognizer *)recognizer {
    //self.label.text = @"Vertical swipe detected";
    self.label.text = [NSString stringWithFormat:@"%@ Vertical swipe detected",[self descriptionForTouchCount:[recognizer numberOfTouches]]];
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
}

- (NSString *)descriptionForTouchCount:(NSInteger)touchCount {
    switch (touchCount) {
        case 1:
            return @"Single";
            
        case 2:
            return @"Double";
        
        case 3:
            return @"Triple";
            
        case 4:
            return @"Quadruple";
            
        case 5:
            return @"quintuple";
            
        default:
            return @"";
    }
}
#pragma mark - Touch Handling

/**
 Description

 @param touches <#touches description#>
 @param event <#event description#>

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.gestureStartPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    
    CGFloat deltaX = fabsf(self.gestureStartPoint.x - currentPosition.x);
    CGFloat deltaY = fabsf(self.gestureStartPoint.y - currentPosition.y);
    
    if (deltaX >= kMinimumGestureLength && deltaY <= kMaximumVariance) {
        self.label.text = @"Horizontal swipe detected";
        [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
    } else if (deltaY >= kMinimumGestureLength && deltaX <= kMaximumVariance) {
        self.label.text = @"Vertical swipe detected";
        [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
    }
}
 */
@end
