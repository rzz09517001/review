//
//  BIDFlipsideViewController.h
//  Bridge Control
//
//  Created by macOs on 2017/6/19.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BIDFlipsideViewController;

@protocol BIDFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(BIDFlipsideViewController *)controller;
@end

@interface BIDFlipsideViewController : UIViewController

@property (weak, nonatomic) id <BIDFlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISwitch *engineSwitch;
@property (weak, nonatomic) IBOutlet UISlider *warpFactorSlider;

-(void)refreshFields;
-(IBAction)engineSwitchTapped;
-(IBAction)WarpSliderTouched;
- (IBAction)done:(id)sender;

@end
