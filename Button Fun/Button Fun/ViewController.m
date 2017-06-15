//
//  ViewController.m
//  Button Fun
//
//  Created by macOs on 2017/6/15.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *plaintext = [NSString stringWithFormat:@"%@ button pressed", [sender titleForState:UIControlStateNormal]];
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plaintext];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:_statusLabel.font.pointSize]
                                 };
    NSRange nameRange = [plaintext rangeOfString:[sender titleForState:UIControlStateNormal]];
    [styledText setAttributes:attributes range:nameRange];
    _statusLabel.attributedText = styledText;
    
}
@end
