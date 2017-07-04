//
//  ViewController.m
//  MotionMonitor
//
//  Created by macOs on 2017/7/4.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *accelerometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyroscopeLabel;

@property (strong, nonatomic) CMMotionManager *motionManager;
//@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSTimer *updateTimer;

@end

@implementation ViewController


/**
 覆盖supportedInterfaceOrientations方法，以免在使用动作传感器属性时屏幕发生旋转

 @return <#return value description#>
 */
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //主动动作访问
    self.motionManager = [[CMMotionManager alloc] init];
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = 1.0 / 10.0;
    } else {
        self.accelerometerLabel.text = @"This device has no accelerometer.";
    }
    if (self.motionManager.gyroAvailable) {
        self.motionManager.gyroUpdateInterval = 1.0 / 10.0;
    } else {
        self.gyroscopeLabel.text = @"This device has no gytoscope";
    }
    /**
    self.motionManager = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    //检测是否有加速器
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = 1.0/ 10.0;//设置更新时间间隔
        [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            NSString *labelText;
            if (error) {
                [self.motionManager stopAccelerometerUpdates];
                labelText = [NSString stringWithFormat:@"Accelerometer encountered error: %@", error];
                             } else {
                                 labelText = [NSString stringWithFormat:@"Accelerometer\n--\n"
                                              "x: %+.2f\ny: %+.2f\nz: %+.2f",
                                              accelerometerData.acceleration.x,
                                              accelerometerData.acceleration.y,
                                              accelerometerData.acceleration.z];
                             };
            dispatch_async(dispatch_get_main_queue(), ^{
                self.accelerometerLabel.text = labelText;
            });
        }];
    } else {
        self.accelerometerLabel.text = @"This device has no accelerometer.";
    }
    if (self.motionManager.gyroAvailable) {
        self.motionManager.gyroUpdateInterval = 1.0 / 10.0;
        [self.motionManager startGyroUpdatesToQueue:self.queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NSString *labelTetx;
            if (error) {
                [self.motionManager stopGyroUpdates];
                labelTetx = [NSString stringWithFormat:@"Gyroscope encountered error: %@",error];
            } else {
                labelTetx = [NSString stringWithFormat:@"Gyroscope\n---\n"
                             @"x: %+.2f\ny: %+.2f\nz: %+.2f",
                             gyroData.rotationRate.x,
                             gyroData.rotationRate.y,
                             gyroData.rotationRate.z];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.gyroscopeLabel.text = labelTetx;
            });
        }];
    } else {
        self.gyroscopeLabel.text = @"This device has no gytoscope";
    }
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.motionManager startAccelerometerUpdates];
    [self.motionManager startGyroUpdates];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 19.0 target:self selector:@selector(updateDisplay) userInfo:nil repeats:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.motionManager stopAccelerometerUpdates];
    [self.motionManager stopGyroUpdates];
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

- (void)updateDisplay {
    if (self.motionManager.accelerometerAvailable) {
        CMAccelerometerData *accelerometerData = self.motionManager.accelerometerData;
        self.accelerometerLabel.text = [NSString stringWithFormat:@"Accelerometer\n--\n"
                                        "x: %+.2f\ny: %+.2f\nz: %+.2f",
                                        accelerometerData.acceleration.x,
                                        accelerometerData.acceleration.y,
                                        accelerometerData.acceleration.z];
    }
    if (self.motionManager.gyroAvailable) {
        CMGyroData *gyroData = self.motionManager.gyroData;
        self.gyroscopeLabel.text = [NSString stringWithFormat:@"Gyroscope\n---\n"
                                    @"x: %+.2f\ny: %+.2f\nz: %+.2f",
                                    gyroData.rotationRate.x,
                                    gyroData.rotationRate.y,
                                    gyroData.rotationRate.z];
    }
}





























@end
