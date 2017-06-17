//
//  ViewController.m
//  Cells
//
//  Created by macOs on 2017/6/17.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"
#import "BIDNameAndColorCell.h"

static NSString *CellTableIdentifier = @"CellTableIdentifier";

@interface ViewController ()

@property (copy, nonatomic) NSArray *computers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.computers = @[@{@"Name" : @"MacBook Air", @"Color" : @"Silver"},
                       @{@"Name" : @"MacBook Pro", @"Color" : @"Silver"},
                       @{@"Name" : @"iMac", @"Color" : @"Silver"},
                       @{@"Name" : @"Mac Mini", @"Color" : @"Silver"},
                       @{@"Name" : @"Mac Pro", @"Color" : @"Black"}];
    UITableView *tableView = (id)[self.view viewWithTag:1];
    //[tableView registerClass:[BIDNameAndColorCell class] forCellReuseIdentifier:CellTableIdentifier];//代码创建
    tableView.rowHeight = 65;
    UINib *nib = [UINib nibWithNibName:@"BIDNameAndColorCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];//从nib加载cell
    UIEdgeInsets contentInsets = tableView.contentInset;
    contentInsets.top = 20;
    [tableView setContentInset:contentInsets];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.computers count];
}


/**
 返回cell

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BIDNameAndColorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    NSDictionary *rowData = self.computers[indexPath.row];
    cell.name = rowData[@"Name"];
    cell.color = rowData[@"Color"];
    return cell;
}

@end
