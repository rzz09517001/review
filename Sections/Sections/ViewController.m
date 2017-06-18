//
//  ViewController.m
//  Sections
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"

static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";

@interface ViewController ()

@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;

@end

@implementation ViewController
{
    NSMutableArray *filteredNames;
    UISearchDisplayController *searchContoller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *tableView = (id)[self.view viewWithTag:1];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionsTableIdentifier];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    filteredNames = [NSMutableArray array];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    tableView.tableHeaderView = searchBar;
    searchContoller = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchContoller.delegate = self;
    searchContoller.searchResultsDataSource = self;
    
    tableView.sectionIndexBackgroundColor = [UIColor blackColor];//设置索引背景色
    tableView.sectionIndexTrackingBackgroundColor = [UIColor darkGrayColor];//滚动背景色
    tableView.sectionIndexColor = [UIColor whiteColor];//设置索引项文字颜色
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma Data Source Methods

/**
 分区

 @param tableView <#tableView description#>
 @return <#return value description#>
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1) {
        return [self.keys count];
    } else {
        return 1;
    }
}

/**
 每个分区的行数

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        NSString *key = self.keys[section];
        NSArray *nameSection = self.names[key];
        return [nameSection count];
    } else {
        return [filteredNames count];
    }
}

/**
 指定每个分区的标题

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return self.keys[section];
    } else {
        return nil;
    }
}


#pragma Delegate Methods

/**
 创建cell

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier forIndexPath:indexPath];
    if (tableView.tag == 1) {
        NSString *key = self.keys[indexPath.section];
        NSArray *nameSction = self.names[key];
        cell.textLabel.text = nameSction[indexPath.row];
    } else {
        cell.textLabel.text = filteredNames[indexPath.row];
    }
    return cell;
}


/**
 右侧添加索引

 @param tableView <#tableView description#>
 @return <#return value description#>
 */
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        return self.keys;
    } else {
        return nil;
    }
}

#pragma mark - 
#pragma UISearchDisplayDelegate methods
-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionsTableIdentifier];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [filteredNames removeAllObjects];//清空之前的搜索结果
    if (searchString.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *name, NSDictionary *b){
            NSRange range = [name rangeOfString:searchString options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];//定义一个谓词，用于判断名字和搜索字符串是否匹配
        
        for (NSString *key in self.keys ) {
            NSArray *matches = [self.names[key] filteredArrayUsingPredicate:predicate];
            [filteredNames addObjectsFromArray:matches];
        }//对每一个键都用谓词进行迭代
    }
    return YES;
}

@end
