//
//  BIDContentCell.h
//  DialogViewer
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDContentCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;
@property (copy, nonatomic) NSString *text;

+(CGSize)sizeForContentString:(NSString *)s;

@end
