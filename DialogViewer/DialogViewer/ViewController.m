//
//  ViewController.m
//  DialogViewer
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "ViewController.h"
#import "BIDHeaderCell.h"
#import "BIDContentCell.h"

@interface ViewController ()

@property (copy, nonatomic) NSArray *sections;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sections =
    @[
      @{ @"header" : @"First Witch",
         @"content" : @"Hey, when will the three of us meet up later?" },
      @{ @"header" : @"Second Witch",
         @"content" : @"When everything's straightened out." },
      @{ @"header" : @"Third Witch",
         @"content" : @"That'll be just before sunset." },
      @{ @"header" : @"First Witch",
         @"content" : @"Where?" },
      @{ @"header" : @"Second Witch",
         @"content" : @"The dirt patch." },
      @{ @"header" : @"Third Witch",
         @"content" : @"I guess we'll see Mac there." },
      ];
    [self.collectionView registerClass:[BIDContentCell class] forCellWithReuseIdentifier:@"CONTENT"];
    //顶端下移
    self.collectionView.backgroundColor = [UIColor whiteColor];
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.top = 20;
    [self.collectionView setContentInset:contentInset];
    //调整布局
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)layout;
    flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);
    //分区标题视图
    [self.collectionView registerClass:[BIDHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    flow.headerReferenceSize = CGSizeMake(100, 25);
    
}


/**
 分词

 @param section <#section description#>
 @return <#return value description#>
 */
-(NSArray *)wordsInSection:(NSInteger)section {
    NSString *content = [self.sections[section] valueForKey:@"content"];
    NSCharacterSet *space = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [content componentsSeparatedByCharactersInSet:space];
    return words;
}


/**
 集合视图有多少个分区要显示

 @param collectionView <#collectionView description#>
 @return <#return value description#>
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sections count];
}


/**
 每个分区有多少条目

 @param collectionView <#collectionView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *words = [self wordsInSection:section];
    return [words count];
}


/**
 cell

 @param collectionView <#collectionView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self wordsInSection:indexPath.section];
    
    BIDContentCell *cell = [self.collectionView
                            dequeueReusableCellWithReuseIdentifier:@"CONTENT"
                            forIndexPath:indexPath];
    cell.text = words[indexPath.row];
    return cell;
}



/**
 重新布局计算单元尺寸

 @param collectionView <#collectionView description#>
 @param collectionViewLayout <#collectionViewLayout description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self wordsInSection:indexPath.section];
    CGSize size = [BIDContentCell sizeForContentString:words[indexPath.row]];
    return size;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        BIDHeaderCell *cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                      withReuseIdentifier:@"HEADER"
                                                                             forIndexPath:indexPath];
        cell.text = [self.sections[indexPath.section] valueForKey:@"header"];
        return cell;
    }
    return nil;
}

@end
