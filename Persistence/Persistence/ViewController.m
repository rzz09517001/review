//
//  ViewController.m
//  Persistence
//
//  Created by macOs on 2017/6/20.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"
#import "BIDFourLines.h"

static NSString *const kRootKey = @"kRootKey";

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *filePath = [self dataFilePath];
    //文件存在就加载
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        /**
         属性列表
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        for (int i=0; i<4; i++) {
            UITextField *theField = self.lineFields[i];
            theField.text = array[i];
        }
         */
        //归档
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        BIDFourLines *fourLines = [unarchiver decodeObjectForKey:kRootKey];
        [unarchiver finishDecoding];
        for (int i = 0 ; i < 4; i ++) {
            UITextField *theField = self.lineFields[i];
            theField.text = fourLines.lines[i];
        }
    }
    //归档的数据加载
    //订阅通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}


/**
 当应用终止运行或进入后台时保存数据

 @param notification <#notification description#>
 */
- (void)applicationWillResignActive:(NSNotification *)notification {
    NSString *path = [self dataFilePath];
    /**
     属性列表
    NSArray *array = [self.lineFields valueForKey:@"text"];
    [array writeToFile:path atomically:YES];
     */
    //归档
    BIDFourLines *fourLines = [[BIDFourLines alloc] init];
    fourLines.lines = [self.lineFields valueForKey:@"text"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:fourLines forKey:kRootKey];
    [archiver finishEncoding];
    [data writeToFile:path atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 查找Documents目录并在其后附加数据文件的文件名，得到数据文件的完整路径

 @return <#return value description#>
 */
- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //属性列表的路径
    //return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    //归档的路径
    return [documentsDirectory stringByAppendingString:@"data.archive"];
}

@end
