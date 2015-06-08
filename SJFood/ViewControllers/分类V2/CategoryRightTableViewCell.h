//
//  CategoryRightTableViewCell.h
//  SJFood
//
//  Created by 缪宇青 on 15/6/6.
//  Copyright (c) 2015年 Ye Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryRightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet YFAsynImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountBuyer;

@end
