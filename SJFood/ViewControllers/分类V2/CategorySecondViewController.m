//
//  CategorySecondViewController.m
//  SJFood
//
//  Created by 缪宇青 on 15/6/6.
//  Copyright (c) 2015年 Ye Fan. All rights reserved.
//

#import "CategorySecondViewController.h"
#import "FoodCategory.h"
#import "CategoryRightTableView.h"
#import "CategoryHeadView.h"
#import "CategorySecondTableView.h"
#import "CategorySecondSubView.h"
#import "CategoryBottomView.h"

#define kGetFoodCategoryDownloaderKey       @"GetFoodCategoryDownloaderKey"

@interface CategorySecondViewController ()
@property (nonatomic, strong) NSMutableArray *categoryTableArray;
@property (nonatomic, assign) CGFloat originX;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CategorySecondViewController
@synthesize categoryTableArray;

#pragma mark - Private Methods
- (void)loadSubViews
{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[CategorySecondSubView class]]) {
            [subView removeFromSuperview];
        }
    }
    //加载headView
    CategoryHeadView *ctc = [[[NSBundle mainBundle]loadNibNamed:@"CategoryHeadView" owner:self options:nil]lastObject];
    CGRect rect = ctc.frame;
    rect.origin.y = 64.0f;
    rect.origin.x = 0.0f;
    rect.size.height = 40.f;
    rect.size.width = ScreenWidth;
    ctc.frame = rect;
    [self.contentView addSubview:ctc];
    
    //加载UITableView
    CategorySecondTableView *ctv = [[[NSBundle mainBundle] loadNibNamed:@"CategorySecondTableView" owner:self options:nil] lastObject];
    rect = ctv.frame;
    rect.origin.y = 104.f;
    rect.origin.x = 0.0f;
    rect.size.height = ScreenHeight - 104.f;
    [ctv reloadWithCategory:self.categoryTableArray];
    ctv.frame = rect;
    self.originX = ctv.frame.size.width;
    [self.contentView addSubview:ctv];
    
    //加载UITableView
    //FoodCategory *fd = [self.categoryTableArray objectAtIndex:0];
    CategoryRightTableView *ccv = [[[NSBundle mainBundle] loadNibNamed:@"CategoryRightTableView" owner:self options:nil] lastObject];
    rect = ccv.frame;
    rect.origin.y = 104.f;
    rect.origin.x = self.originX;
    rect.size.height = ScreenHeight - 104.f;
    rect.size.width = ScreenWidth - ctv.frame.size.width;
    NSLog(@"%f",rect.size.width);
    ccv.frame = rect;
    [self.contentView addSubview:ccv];
    
    //加载BottomView
    CategoryBottomView *ccc = [[[NSBundle mainBundle] loadNibNamed:@"CategoryBottomView" owner:self options:nil]lastObject];
    rect = ccc.frame;
    rect.origin.x = 0.0f;
    rect.origin.y = ScreenHeight - 50;
    rect.size.height = 50;
    rect.size.width = ScreenWidth;
    ccc.frame = rect;
    [self.contentView addSubview:ccc];
    
    UIImageView *amountImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_buy.png"]];
    amountImage.frame = CGRectMake((ctv.frame.size.width - 56)/2, ScreenHeight - 68, 56, 56);
    [self.contentView addSubview:amountImage];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self requestForGetFoodCategory];
    [self setNaviTitle:@"云便利店"];
    UINavigationBar *bar = self.navigationController.navigationBar;
    [self setLeftNaviItemWithTitle:nil imageName:@"button_back.png"];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIColor *NavColor = [UIColor colorWithRed:254/255.0 green:120/255.0 blue:114/255.0 alpha:1];
    [bar setBarTintColor:NavColor];
    [self setRightNaviItemWithTitle:@"搜索" imageName:@"search.png"];
    self.categoryTableArray = [NSMutableArray arrayWithCapacity:0];
    if ([[CacheManager sharedManager] category]) {
        for (NSDictionary *valueDict in [[CacheManager sharedManager] category]) {
            FoodCategory *fc = [[FoodCategory alloc]initWithDict:valueDict];
            [self.categoryTableArray addObject:fc];
        }
        [self loadSubViews];
    } else {
        [[YFProgressHUD sharedProgressHUD] showActivityViewWithMessage:@"加载中..."];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
