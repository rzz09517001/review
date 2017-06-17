//
//  BIDNameAndColorCell.m
//  Cells
//
//  Created by macOs on 2017/6/17.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "BIDNameAndColorCell.h"

@interface BIDNameAndColorCell()


//@property(strong, nonatomic) UILabel *nameLabel;
//@property(strong, nonatomic) UILabel *colorLabel;
//从nib文件加载cell
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation BIDNameAndColorCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 代码加载cell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
        UILabel *nameMaker = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameMaker.textAlignment = NSTextAlignmentRight;
        nameMaker.text = @"Name:";
        nameMaker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:nameMaker];
        
        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
        UILabel *colorMaker = [[UILabel alloc] initWithFrame:colorLabelRect];
        colorMaker.textAlignment = NSTextAlignmentRight;
        colorMaker.text = @"Color:";
        colorMaker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:colorMaker];
        
        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
        _nameLabel = [[UILabel alloc] initWithFrame:nameValueRect];
        [self.contentView addSubview:_nameLabel];
        
        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
        _colorLabel = [[UILabel alloc] initWithFrame:colorValueRect];
        [self.contentView addSubview:_colorLabel];
    }
    return self;
}
**/

-(void)setName:(NSString *)n
{
    if (![n isEqualToString:_name]) {
        _name = [n copy];
    }
    self.nameLabel.text = _name;
}

-(void)setColor:(NSString *)c {
    if (![c isEqualToString:_color]) {
        _color = [c copy];
    }
    self.colorLabel.text = _color;
}
    

@end
