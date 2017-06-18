//
//  BIDRootViewController.m
//  Fonts
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "BIDRootViewController.h"
#import "BIDFavoritesList.h"
#import "BIDFontListViewController.h"

@interface BIDRootViewController ()

@property (copy, nonatomic) NSArray *familyNames;
@property (assign, nonatomic) CGFloat cellPointsize;
@property (strong, nonatomic) BIDFavoritesList *favoritesList;

@end

@implementation BIDRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)];//从uifont获取所有已知的字体名称并排序
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];//获取在标题处的字体
    self.cellPointsize = preferredTableViewFont.pointSize;
    self.favoritesList = [BIDFavoritesList sharedFavoritesList];
}


/**
 重新加载表示图

 @param animated <#animated description#>
 */
-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}


/**
 工具方法，计算出表单元需要显示哪种方法

 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(UIFont *)fontForDisplyAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *familyName = self.familyNames[indexPath.row];
        NSString *fontName = [[UIFont fontNamesForFamilyName:familyName] firstObject];
        return [UIFont fontWithName:fontName size:self.cellPointsize];
    } else {
        return nil;
    }
}

#pragma mark - Table view data source

/**
 根据收藏列表来判断是否要显示第二个分区

 @param tableView <#tableView description#>
 @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.favoritesList.favorites count] > 0) {
        return 2;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.familyNames count];
    } else {
        return 1;
    }
}

/**
 每个分区的标题

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"All Font Families";
    } else {
        return @"My Favorite Fonts";
    }
}


/**
 调整每行的高度

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UIFont *font = [self fontForDisplyAtIndexPath:indexPath];
        return 25 + font.ascender - font.descender;
    } else {
        return tableView.rowHeight;
    }
}

/**
 配置表单元

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FamilyNameCell = @"FamilyName";
    static NSString *FavoritesCell = @"Favorites";
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:FamilyNameCell forIndexPath:indexPath];
        cell.textLabel.font = [self fontForDisplyAtIndexPath:indexPath];
        cell.textLabel.text = self.familyNames[indexPath.row];
        cell.detailTextLabel.text = self.familyNames[indexPath.row];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:FavoritesCell forIndexPath:indexPath];
    }
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    BIDFontListViewController *listVC = segue.destinationViewController;
    
    if (indexPath.section == 0) {
        NSString *familyName = self.familyNames[indexPath.row];
        listVC.fontNames = [[UIFont fontNamesForFamilyName:familyName] sortedArrayUsingSelector:@selector(compare:)];
        listVC.navigationItem.title = familyName;
        listVC.showsFavorites = NO;
    } else {
        listVC.fontNames = self.favoritesList.favorites;
        listVC.navigationItem.title = @"Favorites";
        listVC.showsFavorites = YES;
    }
}

@end
