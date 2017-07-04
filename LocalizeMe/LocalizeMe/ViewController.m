//
//  ViewController.m
//  LocalizeMe
//
//  Created by macOs on 2017/7/4.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *localeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLocale *locale = [NSLocale currentLocale];//获取用户当前区域设置的实例
    NSString *currentLangID = [[NSLocale preferredLanguages] objectAtIndex:0];//包含用户的语言和地区的首选项
    NSString *displayLang = [locale displayNameForKey:NSLocaleLanguageCode value:currentLangID];//返回所选语言的实际名称
    NSString *capitalized = [displayLang capitalizedStringWithLocale:locale];//首字母转换为大写
    self.localeLabel.text = capitalized;
    [self.labels[0] setText:NSLocalizedString(@"LABEL_ONE", @"the number 1")];
    [self.labels[1] setText:NSLocalizedString(@"LABEL_TWO", @"the number 2")];
    [self.labels[2] setText:NSLocalizedString(@"LABEL_THREE", @"the number 3")];
    [self.labels[3] setText:NSLocalizedString(@"LABEL_FOUR", @"the number 4")];
    [self.labels[4] setText:NSLocalizedString(@"LABEL_FIVE", @"the number 5")];
    
    NSString *flagFile = NSLocalizedString(@"FLAG_FILE", @"Name of the flag");
    self.flagImageView.image = [UIImage imageNamed:flagFile];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
