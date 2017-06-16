//
//  ViewController.m
//  Restructure
//
//  Created by macOs on 2017/6/16.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton1;
@property (weak, nonatomic) IBOutlet UIButton *actionButton2;
@property (weak, nonatomic) IBOutlet UIButton *actionButton3;
@property (weak, nonatomic) IBOutlet UIButton *actionButton4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIApplication *app =  [UIApplication sharedApplication];
    UIInterfaceOrientation currentOrientation = app.statusBarOrientation;
    [self doLayoutForOrientation:currentOrientation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self doLayoutForOrientation:toInterfaceOrientation];
}

-(void)doLayoutForOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self layoutPortrait];
    } else {
        [self layoutLandscape];
    }
}

static const CGFloat buttonHeight =40;
static const CGFloat buttonWidth =120;
static const CGFloat space =20;

-(void)layoutPortrait {
    CGRect b = self.view.bounds;
    CGFloat contentWidth = CGRectGetWidth(b) - (2 *space);
    CGFloat contentHeight = CGRectGetHeight(b) - (4 *space) - (2 * buttonHeight);
    self.contentView.frame = CGRectMake(space, space, contentWidth, contentHeight);
    
    CGFloat buttonRow1y = contentHeight + (2 * space);
    CGFloat buttonRow2y = buttonRow1y + buttonHeight + space;
    
    CGFloat buttonCol1x = space;
    CGFloat buttonCol2x = CGRectGetWidth(b) - buttonWidth - space;
    
    self.actionButton1.frame = CGRectMake(buttonCol1x, buttonRow1y, buttonWidth, buttonHeight);
    self.actionButton2.frame = CGRectMake(buttonCol2x, buttonRow1y, buttonWidth, buttonHeight);
    self.actionButton3.frame = CGRectMake(buttonCol1x, buttonRow2y, buttonWidth, buttonHeight);
    self.actionButton4.frame = CGRectMake(buttonCol2x, buttonRow2y, buttonWidth, buttonHeight);
}

-(void)layoutLandscape {
    CGRect b = self.view.bounds;
    CGFloat contentWidth = CGRectGetWidth(b) -buttonWidth -  (3 *space);
    CGFloat contentHeight = CGRectGetHeight(b) - (2 *space);
    self.contentView.frame = CGRectMake(space, space, contentWidth, contentHeight);
    
    CGFloat x = (contentHeight - 4 * buttonHeight)/3;
    CGFloat buttonRow1y = space;
    CGFloat buttonRow2y = buttonRow1y + buttonHeight + x;
    CGFloat buttonRow3y = buttonRow2y + buttonHeight + x;
    CGFloat buttonRow4y = buttonRow3y + buttonHeight + x;
    
    CGFloat buttonColx = CGRectGetWidth(b) - buttonWidth - space;
    
    self.actionButton1.frame = CGRectMake(buttonColx, buttonRow1y, buttonWidth, buttonHeight);
    self.actionButton2.frame = CGRectMake(buttonColx, buttonRow2y, buttonWidth, buttonHeight);
    self.actionButton3.frame = CGRectMake(buttonColx, buttonRow3y, buttonWidth, buttonHeight);
    self.actionButton4.frame = CGRectMake(buttonColx, buttonRow4y, buttonWidth, buttonHeight);
}
@end
