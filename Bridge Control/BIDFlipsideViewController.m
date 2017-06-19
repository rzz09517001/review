//
//  BIDFlipsideViewController.m
//  Bridge Control
//
//  Created by macOs on 2017/6/19.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "BIDFlipsideViewController.h"
#import "ViewController.h"

@interface BIDFlipsideViewController ()

@end

@implementation BIDFlipsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshFields];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshFields {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.engineSwitch.on = [userDefaults boolForKey:kWarpDriveKey];
    self.warpFactorSlider.value = [userDefaults floatForKey:kWarpFactorKey];
}

-(IBAction)engineSwitchTapped {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.engineSwitch.on forKey:kWarpDriveKey];
    [defaults synchronize];
}

-(IBAction)WarpSliderTouched {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.warpFactorSlider.value forKey:kWarpFactorKey];
    [defaults synchronize];
}

-(void)applicationWillEntterForeground:(NSNotification *)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEntterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
