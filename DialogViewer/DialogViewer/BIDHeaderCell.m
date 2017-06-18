//
//  BIDHeaderCell.m
//  DialogViewer
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "BIDHeaderCell.h"

@implementation BIDHeaderCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:0.9
                                                     green:0.9
                                                      blue:0.8
                                                     alpha:1.0];
        self.label.textColor = [UIColor blackColor];
    }
    return self;
}

+(UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

@end
