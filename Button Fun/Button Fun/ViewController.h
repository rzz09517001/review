//
//  ViewController.h
//  Button Fun
//
//  Created by macOs on 2017/6/15.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)buttonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@end

