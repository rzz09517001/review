//
//  ViewController.m
//  WhereAmI
//
//  Created by macOs on 2017/7/4.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"
#import "Place.h"

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *previousPoint;
@property (assign, nonatomic) CLLocationDistance totalMovementDistance;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;//纬度
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;//经度
@property (weak, nonatomic) IBOutlet UILabel *horizontalAccuracyLabel;//水平精度
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;//海拔高度
@property (weak, nonatomic) IBOutlet UILabel *verticalAccuracyLabel;//垂直精度
@property (weak, nonatomic) IBOutlet UILabel *distanceTraveledLabel;//距离
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;//设置委托
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设置精度
    [self.locationManager startUpdatingLocation];//启动
    self.mapView.showsUserLocation = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = [locations lastObject];
    NSString *latitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.latitude];
    self.latitudeLabel.text = latitudeString;
    NSString *longitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.longitude];
    self.longitudeLabel.text = longitudeString;
    NSString *horizontalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.horizontalAccuracy];
    self.horizontalAccuracyLabel.text = horizontalAccuracyString;
    NSString *altitudeString = [NSString stringWithFormat:@"%gm", newLocation.altitude];
    self.altitudeLabel.text = altitudeString;
    NSString *verticalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.verticalAccuracy];
    self.verticalAccuracyLabel.text = verticalAccuracyString;
    if (newLocation.verticalAccuracy < 0 | newLocation.horizontalAccuracy < 0) {
        return;//无效的精度
    }
    
    if (newLocation.horizontalAccuracy > 100 | newLocation.verticalAccuracy > 50) {
        return;//这里不使用过大的精度值
    }
    
    if (self.previousPoint == nil) {
        self.totalMovementDistance = 0;
        Place *start = [[Place alloc] init];
        start.coordinate = newLocation.coordinate;
        start.title = @"Start Point";
        start.subtitle = @"This is where we started!";
        
        [self.mapView addAnnotation:start];
        MKCoordinateRegion region;
        region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100);
        [self.mapView setRegion:region animated:YES];
    } else {
        self.totalMovementDistance += [newLocation distanceFromLocation:self.previousPoint];
    }
    self.previousPoint = newLocation;
    
    NSString *distanceTraveledString = [NSString stringWithFormat:@"%gm",self.totalMovementDistance];
    self.distanceTraveledLabel.text = distanceTraveledString;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *erroraType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"UNknow error";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error getting Location" message:erroraType preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
