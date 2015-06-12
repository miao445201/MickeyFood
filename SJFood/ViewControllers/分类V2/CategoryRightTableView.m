//
//  CategoryRightTableView.m
//  SJFood
//
//  Created by 缪宇青 on 15/6/6.
//  Copyright (c) 2015年 Ye Fan. All rights reserved.
//

#import "CategoryRightTableView.h"
#import "CategoryRightTableViewCell.h"
#import "FoodSelect.h"
#import "FoodDetail.h"

#define kCellReuseIdentify      @"CategoryRightTableViewCell"


@interface CategoryRightTableView ()
@property (nonatomic, strong) NSMutableArray *foodArray;
@property (nonatomic, strong) FoodSelect *foodSelect;
@end

@implementation CategoryRightTableView
@synthesize rightTableView;
@synthesize foodArray,foodSelect;

#pragma mark - Public Methods
- (void)reloadWithCategory:(NSMutableArray *)category
{
    //self.foodArray = category;
    //[self.rightTableView reloadData];
}

#pragma mark - UIView Methods
- (void)awakeFromNib
{
    [super awakeFromNib];

}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foodArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentify];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.foodSelect = [self.foodArray objectAtIndex:indexPath.row];
//    cell.nameLabel.text = self.foodSelect.name;
//    cell.priceLabel.text = self.foodSelect.price;
//    cell.amountBuyer.text = self.foodSelect.saleNumber;
//    cell.iconImage.cacheDir = kFoodIconCacheDir;
//    [cell.iconImage aysnLoadImageWithUrl:self.foodSelect.imgUrl placeHolder:@"loading_square.png"];

    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FoodDetail *fcd = [self.foodArray objectAtIndex:indexPath.row];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryDetailTableViewSelectedNotificaition object:fcd.foodId];
}

@end
