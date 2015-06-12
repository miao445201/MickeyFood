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
#import "FoodSelect.h"
#import "FoodDetailViewController.h"

#define kGetFoodCategoryDownloaderKey       @"GetFoodCategoryDownloaderKey"
#define kFoodSearchDownloaderKey        @"FoodSearchDownloaderKey"
#define kHomeFoodDownloaderKey          @"HomeFoodDownloaderKey"
#define kLastIdInit             @"0"


@interface CategorySecondViewController ()
@property (nonatomic, strong) NSMutableArray *categoryTableArray;
@property (nonatomic, assign) CGFloat originX;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (nonatomic, strong)NSString *foodTag;
@property (nonatomic, strong)NSMutableArray *foodArray;
@property (nonatomic, strong)FoodSelect *food;
@property (nonatomic, strong)NSString *lastestId;
@property (nonatomic, strong)NSString *sort;


@end

@implementation CategorySecondViewController
@synthesize categoryTableArray,searchBar,food,foodTag,foodArray;
@synthesize sort,lastestId,contentView,originX;

#pragma mark - loadView Methods
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
    FoodCategory *fd = [self.categoryTableArray objectAtIndex:0];
    self.foodArray  = [NSMutableArray arrayWithArray:fd.child];
    CategoryRightTableView *ccv = [[[NSBundle mainBundle] loadNibNamed:@"CategoryRightTableView" owner:self options:nil] lastObject];
    rect = ccv.frame;
    rect.origin.y = 104.f;
    rect.origin.x = self.originX;
    rect.size.height = ScreenHeight - 104.f;
    rect.size.width = ScreenWidth - ctv.frame.size.width;
    NSLog(@"%f",rect.size.width);
    [ccv reloadWithCategory:foodArray];
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

- (void)loadSearchBar
{
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.searchBar.frame = CGRectMake(508, 60, 112, 23);
    [self.searchBar setBackgroundImage:[UIImage imageNamed: @"search.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.searchBar setPlaceholder:@"搜索"];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField = [self.searchBar valueForKey:@"_searchField"];
    // Change search bar text color
    UIColor *NavColor = [UIColor colorWithRed:254/255.0 green:120/255.0 blue:114/255.0 alpha:1];
    searchField.textColor = NavColor;
    // Change the search bar placeholder text color
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    // Change the search icon
    UIImage *image = [UIImage imageNamed: @"logo_search.png"];
    UIImageView *iView = [[UIImageView alloc] initWithImage:image];
    iView.frame = CGRectMake(0, 0, 16, 16);
    searchField.leftView  = iView;
    UIBarButtonItem *navRight = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    [[self navigationItem] setRightBarButtonItem:navRight];
}

- (void) setNavMethods
{
    [self setNaviTitle:@"云便利店"];
    UINavigationBar *bar = self.navigationController.navigationBar;
    [self setLeftNaviItemWithTitle:nil imageName:@"button_back.png"];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIColor *NavColor = [UIColor colorWithRed:254/255.0 green:120/255.0 blue:114/255.0 alpha:1];
    [bar setBarTintColor:NavColor];

}

#pragma mark - UIViewController Methods
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[YFProgressHUD sharedProgressHUD] stoppedNetWorkActivity];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavMethods];
    [self requestForGetFoodCategory];
    self.categoryTableArray = [NSMutableArray arrayWithCapacity:0];
    if ([[CacheManager sharedManager] category]) {
        for (NSDictionary *valueDict in [[CacheManager sharedManager] category]) {
            FoodCategory *fc = [[FoodCategory alloc]initWithDict:valueDict];
            [self.categoryTableArray addObject:fc];
        }
        [self loadSubViews];
        [self loadSearchBar];
    } else {
        [[YFProgressHUD sharedProgressHUD] showActivityViewWithMessage:@"加载中..."];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryTableViewSelected:) name:kCategoryTableViewSelectedNotificaition object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryDetailTableViewSelected:) name:kCategoryDetailTableViewSelectedNotificaition object:nil];

}

- (void)dealloc
{
    [[YFDownloaderManager sharedManager] cancelDownloaderWithDelegate:self purpose:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Notification Methods
- (void)categoryTableViewSelected:(NSNotification *)notification
{
    NSNumber *number = [notification object];
    NSInteger index = [number integerValue];
    FoodCategory *fd = [self.categoryTableArray objectAtIndex:index];
    self.foodArray = [NSMutableArray arrayWithArray:fd.child];
    // load collection view
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[CategoryRightTableView class]]) {
            [subView removeFromSuperview];
        }
    }
    //加载UITableView
    CategoryRightTableView *ccv = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCollectionView" owner:self options:nil] lastObject];
    CGRect rect = ccv.frame;
    rect.origin.y = 64.f;
    rect.origin.x = self.originX;
    rect.size.height = ScreenHeight;
    rect.size.width = ScreenWidth - 80.f;
    [ccv reloadWithCategory:self.foodArray];
    ccv.frame = rect;
    [self.view addSubview:ccv];
}

- (void)categoryDetailTableViewSelected:(NSNotification *)notification
{
    FoodDetailViewController *foodDetailViewController = [[FoodDetailViewController alloc] initWithNibName:@"FoodDetailViewController" bundle:nil];
    foodDetailViewController.foodId = notification.object;
    [self.navigationController pushViewController:foodDetailViewController animated:YES];
}
#pragma request methods
- (void)requestForFoodSearchWithCategoryId:(NSString *)category foodTag:(NSString *)tag sortId:(NSString *)sortId page:(NSString *)page
{
    if (category == nil)
        category = @"";
    if (tag == nil)
        tag = @"";
    if (sortId == nil)
        sortId = @"0";
    if (page == nil)
        page = @"0";
    self.lastestId = page;
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,kFoodSearchUrl];
    NSMutableDictionary *dict = kCommonParamsDict;
    [dict setObject:category forKey:@"categoryId"];
    [dict setObject:tag forKey:@"foodTag"];
    [dict setObject:sortId forKey:@"sortId"];
    [dict setObject:page forKey:@"page"];
    [[YFDownloaderManager sharedManager] requestDataByPostWithURLString:url
                                                             postParams:dict
                                                            contentType:@"application/x-www-form-urlencoded"
                                                               delegate:self
                                                                purpose:kFoodSearchDownloaderKey];
}

- (void)requestForGetFoodCategory
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,kGetFoodCategoryUrl];
    [[YFDownloaderManager sharedManager] requestDataByGetWithURLString:url
                                                              delegate:self
                                                               purpose:kGetFoodCategoryDownloaderKey];
}

#pragma mark - YFDownloaderDelegate Methods
- (void)downloader:(YFDownloader *)downloader completeWithNSData:(NSData *)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict = [str JSONValue];
    if ([downloader.purpose isEqualToString:kGetFoodCategoryDownloaderKey])
    {
        if([[dict objectForKey:kCodeKey] isEqualToString:kSuccessCode])
        {
            [[YFProgressHUD sharedProgressHUD] stoppedNetWorkActivity];
            self.categoryTableArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *valueArray = [dict objectForKey:@"foodFirstCategory"];
            for (NSDictionary *valueDict in valueArray) {
                FoodCategory *fc = [[FoodCategory alloc]initWithDict:valueDict];
                [self.categoryTableArray addObject:fc];
            }
            [[CacheManager sharedManager] cacheCategoryWithArray:self.categoryTableArray];
            [self loadSubViews];
        }
        else
        {
            NSString *message = [dict objectForKey:kMessageKey];
            if ([message isKindOfClass:[NSNull class]])
            {
                message = @"";
            }
            if(message.length == 0)
                message = @"获取挑食信息失败";
            [[YFProgressHUD sharedProgressHUD] showFailureViewWithMessage:message hideDelay:2.f];
        }
    }
}

- (void)downloader:(YFDownloader *)downloader didFinishWithError:(NSString *)message
{
    NSLog(@"%@",message);
    [[YFProgressHUD sharedProgressHUD] showFailureViewWithMessage:kNetWorkErrorString hideDelay:2.f];
}

@end
