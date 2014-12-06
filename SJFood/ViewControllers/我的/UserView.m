//
//  UserView.m
//  SJFood
//
//  Created by 叶帆 on 14/12/5.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "UserView.h"

@implementation UserView
@synthesize iconImageView;

#pragma mark - UIView methods
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 37.f;
    self.iconImageView.layer.borderWidth =  4.f;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.masksToBounds = YES;
}

@end
