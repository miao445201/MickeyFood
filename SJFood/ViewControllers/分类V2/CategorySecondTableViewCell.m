//
//  CategorySecondTableViewCell.m
//  SJFood
//
//  Created by 缪宇青 on 15/6/6.
//  Copyright (c) 2015年 Ye Fan. All rights reserved.
//

#import "CategorySecondTableViewCell.h"

@implementation CategorySecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
        // Configure the view for the selected state
    if (self.selected) {
        self.titleLabel.textColor = kMainProjColor;
        self.rightLine.hidden = YES;
    }
    else {
        self.titleLabel.textColor = kMainBlackColor;
        self.rightLine.hidden = NO;
    }
    
}

@end
