//
//  CategorySecondTableView.m
//  SJFood
//
//  Created by 缪宇青 on 15/6/6.
//  Copyright (c) 2015年 Ye Fan. All rights reserved.
//

#import "CategorySecondTableView.h"
#import "FoodCategory.h"
#import "CategorySecondTableViewCell.h"

@interface CategorySecondTableView ()
@property (nonatomic, strong) NSMutableArray *categoryTableArray;
@property (nonatomic, strong) FoodCategory *foodCategory;
@end

@implementation CategorySecondTableView

@synthesize categorySecondTableView;
@synthesize categoryTableArray,foodCategory;

#pragma mark - Public Methods
- (void)reloadWithCategory:(NSMutableArray *)category
{
    self.categoryTableArray = category;
    [self.categorySecondTableView zeroSeparatorInset];
    self.categorySecondTableView.tableFooterView = [UIView new];
    [self.categorySecondTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.categorySecondTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
}

#pragma mark - UIView Methods
- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryTableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"CategorySecondTableViewCell";
    CategorySecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (nil == cell)
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CategorySecondTableViewCell" owner:self options:nil];
        cell = [nibs lastObject];
        UIImageView *selectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_select_bg.png"]];
        cell.selectedBackgroundView = selectedView;
    }
    self.foodCategory = [self.categoryTableArray objectAtIndex:indexPath.row];
    [cell zeroSeparatorInset];
    cell.titleLabel.textColor = kMainBlackColor;
    cell.titleLabel.text = self.foodCategory.category;
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryTableViewSelectedNotificaition object:[NSNumber numberWithInteger:indexPath.row]];
}


@end
