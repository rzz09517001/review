//
//  BIDFontListViewController.m
//  Fonts
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "BIDFontListViewController.h"
#import "BIDFavoritesList.h"
#import "BIDFontSizesViewController.h"
#import "BIDFontInfoViewController.h"

@interface BIDFontListViewController ()

@property (assign, nonatomic) CGFloat cellPointSize;

@end

@implementation BIDFontListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
    if (self.showsFavorites) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}

-(UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fontName = self.fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:self.cellPointSize];
}

-(void)viewWillAppear:(BOOL)animated {
    if (self.showsFavorites) {
        self.fontNames = [BIDFavoritesList sharedFavoritesList].favorites;
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fontNames count];
}


/**
 每行需要显示的内容

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FontName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //配置单元
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.fontNames[indexPath.row];
    cell.detailTextLabel.text = self.fontNames[indexPath.row];
    return  cell;
}

/**
 调整每行的高度
 
 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    return 25 + font.ascender - font.descender;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.showsFavorites;
}




/**
 实现删除某行的功能

 @param tableView <#tableView description#>
 @param editingStyle <#editingStyle description#>
 @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.showsFavorites) {
        return;
    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSString *favorite = self.fontNames[indexPath.row];
        [[BIDFavoritesList sharedFavoritesList] removeFavorite:favorite];
        self.fontNames = [BIDFavoritesList sharedFavoritesList].favorites;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  
}



// Override to support rearranging the table view.
/**
 编辑列表

 @param tableView <#tableView description#>
 @param fromIndexPath <#fromIndexPath description#>
 @param toIndexPath <#toIndexPath description#>
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[BIDFavoritesList sharedFavoritesList] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
    self.fontNames = [BIDFavoritesList sharedFavoritesList].favorites;
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    [segue.destinationViewController navigationItem].title = font.fontName;
    if ([segue.identifier isEqualToString:@"ShowFontSizes"]) {
        BIDFontSizesViewController *sizesVC= segue.destinationViewController;
        sizesVC.font = font;
    } else if ([segue.identifier isEqualToString:@"ShowFontInfo"]) {
        BIDFontInfoViewController *infoVC = segue.destinationViewController;
        infoVC.font = font;
        infoVC.favorite = [[BIDFavoritesList sharedFavoritesList].favorites containsObject:font.fontName];
    }
}


@end
