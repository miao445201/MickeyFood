//
//  CategoryRightTableView.m
//  SJFood
//
//  Created by 缪宇青 on 15/6/6.
//  Copyright (c) 2015年 Ye Fan. All rights reserved.
//

#import "CategoryRightTableView.h"
#import "FoodCategory.h"
#import "CategoryRightTableViewCell.h"

@interface CategoryRightTableView ()
@property (nonatomic, strong) NSMutableArray *categoryTableArray;
@property (nonatomic, strong) FoodCategory *foodCategory;
@end

@implementation CategoryRightTableView
@synthesize rightTableView;

#pragma mark - Public Methods
- (void)reloadWithCategory:(NSMutableArray *)category
{
    
}

#pragma mark - UIView Methods
- (void)awakeFromNib
{
    [super awakeFromNib];

}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"CategoryRightTableViewCell";
    CategoryRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (nil == cell)
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CategoryRightTableViewCell" owner:self options:nil];
        cell = [nibs lastObject];
    }
    //self.foodCategory = [self.categoryTableArray objectAtIndex:indexPath.row];
    [cell zeroSeparatorInset];
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryTableViewSelectedNotificaition object:[NSNumber numberWithInteger:indexPath.row]];
}

@end
