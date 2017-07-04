//
//  ViewController.m
//  CheckPlease
//
//  Created by macOs on 2017/7/4.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"
#import "CheckMarkRecognizer.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CheckMarkRecognizer *check = [[CheckMarkRecognizer alloc] initWithTarget:self action:@selector(doCheck:)];
    [self.view addGestureRecognizer:check];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)doCheck:(CheckMarkRecognizer *)check {
    self.label.text = @"Checkmark";
    [self performSelector:@selector(eraseLabel) withObject:nil afterDelay:1.6];
}

- (void)eraseLabel {
    self.label.text = @"";
}

@end
