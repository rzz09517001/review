//
//  BIDContentCell.m
//  DialogViewer
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "BIDContentCell.h"

@implementation BIDContentCell

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.opaque = NO;
        self.label.backgroundColor = [UIColor colorWithRed:0.8
                                                     green:0.9
                                                      blue:1.0
                                                     alpha:1.0];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [[self class] defaultFont];
        [self.contentView addSubview:self.label];
    }
    return self;
}

+(UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+(CGSize)sizeForContentString:(NSString *)string {
    CGSize maxSize = CGSizeMake(300, 1000);//声明最大尺寸
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];//多余会自动移到下一行
    NSDictionary *attributes = @{ NSFontAttributeName : [self defaultFont], NSParagraphStyleAttributeName:style};
    CGRect rect = [string boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    return rect.size;
}

-(NSString *)text {
    return self.label.text;
}

-(void)setText:(NSString *)text {
    self.label.text = text;
    CGRect newLabelFrame = self.label.frame;
    CGRect newContentFrame = self.contentView.frame;
    CGSize textSize = [[self class] sizeForContentString:text];
    newLabelFrame.size = textSize;
    newContentFrame.size = textSize;
    self.label.frame = newLabelFrame;
    self.contentView.frame = newContentFrame;
}
@end
