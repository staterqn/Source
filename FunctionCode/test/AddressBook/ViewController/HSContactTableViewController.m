//
//  HSContactTableViewController.m
//  HappySchool
//
//  Created by chuanshuangzhang on 16/2/19.
//  Copyright © 2016年 com.flxcolor.cszhang. All rights reserved.
//

#import "HSContactTableViewController.h"
#import "PinYingHelper.h"
#import "ChineseString.h"
#import "HSContactModel.h"
#import "HSConatctTableViewCell.h"
#import "HSSearchBar.h"

@interface HSContactTableViewController ()<UISearchResultsUpdating>

/*搜索控制器列表*/
@property (nonatomic,strong) UISearchController *searchController;
/*通讯录数据源*/
@property (nonatomic,strong) NSMutableArray *dataSource;
/*未排序的数据源*/
@property (nonatomic,strong) NSMutableArray *unSortedDataSource;
/*搜索通讯录数据源*/
@property (nonatomic,strong) NSMutableArray *searchDataSource;
/*字母排序数组*/
@property (nonatomic,strong) NSMutableArray *filterDataSource;

@end

@implementation HSContactTableViewController

- (NSMutableArray *)dataSource
{
   if(_dataSource == nil)
   {
       _dataSource = [NSMutableArray array];
   }
    return _dataSource;
}

- (NSMutableArray *)searchDataSource
{
   if(_searchDataSource == nil)
   {
       _searchDataSource = [NSMutableArray array];
   }
    return _searchDataSource;
}
- (UISearchController *)searchController
{
   if(_searchController == nil)
   {
       _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
       _searchController.searchBar.frame=CGRectMake(15, 0, self.view.frame.size.width-30,55);
       _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
       self.tableView.tableHeaderView = _searchController.searchBar;
       _searchController.searchResultsUpdater = self;
       _searchController.dimsBackgroundDuringPresentation = NO;
       _searchController.hidesNavigationBarDuringPresentation = NO;
       _searchController.searchBar.placeholder=@"搜索";
   }
    return _searchController;
}

- (NSMutableArray *)filterDataSource
{
    if(_filterDataSource == nil)
    {
        _filterDataSource = [NSMutableArray array];
    }
    return _filterDataSource;
}

- (void)sortContactWithData:(NSMutableArray *)array
{
    for (HSContactModel *model in array) {
        if(![model.contactName isEqualToString:@""])
        {
            NSString *pinYinResult = [NSString string];
            for (int j =0 ; j<model.contactName.length; ++j) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([model.contactName characterAtIndex:j])]uppercaseString];
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            model.pinYinName = pinYinResult;
        }
        else
        {
            model.pinYinName = @"";
        }
    }
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYinName" ascending:YES]];
    [array sortUsingDescriptors:sortDescriptors];
    
    NSString *keyWord = @"";
    for (HSContactModel *model in array) {
        NSString *key = [NSString stringWithFormat:@"%c",[model.pinYinName characterAtIndex:0]];
        if(![keyWord isEqualToString:key])
        {
            [self.filterDataSource addObject:key];
            NSMutableArray *array = [NSMutableArray array];
            [self.dataSource addObject:array];
        }
        keyWord = key;
        NSMutableArray *array = self.dataSource.lastObject;
        [array addObject:model];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchController];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    [self.tableView registerClass:[HSConatctTableViewCell class] forCellReuseIdentifier:@"HSConatctTableViewCell"];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1.0]];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    /*隐藏多余的分割线*/
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    /*解决分割线左边对齐的问题*/
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    NSMutableArray *array= [NSMutableArray array];
    for (NSInteger t = 0; t<=10; ++t) {
        HSContactModel *model = [[HSContactModel alloc]init];
        model.contactName = @"Jack";
        if(t <= 3)
        {
          model.contactName = @"刘德华";
        }else if(t <= 6)
        {
           model.contactName = @"**DF";
        }else {
           model.contactName = @"ZCS";
        }
        [array addObject:model];
    }
    _unSortedDataSource = [NSMutableArray arrayWithArray:array];
    [self sortContactWithData:array];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.searchController.active)
    {
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer.textLabel setTextColor:[UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1.0]];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return [self.dataSource count];
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        NSArray *array = self.dataSource[section];
        return array.count;
    }
    return self.searchDataSource.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(!self.searchController.active){
        return [NSString stringWithFormat:@"   %@",self.filterDataSource[section]];
    }
    return @"";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSConatctTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSConatctTableViewCell" forIndexPath:indexPath];
    
    if (!self.searchController.active) {
        NSArray *array = self.dataSource[indexPath.section];
        
        HSContactModel *mode = array[indexPath.row];
        cell.textLabel.text = mode.contactName;
    }else {
        HSContactModel *mode = self.searchDataSource[indexPath.section];
        cell.textLabel.text = mode.contactName;
    }
    cell.textLabel.textColor = [UIColor colorWithRed:17/255.0 green:62/255.0 blue:161/255.0 alpha:1.0];
    cell.imageView.image = [UIImage imageNamed:@"gongfuxiongmao"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.contactName CONTAINS[c] %@", searchString];
    [self.searchDataSource removeAllObjects];
    //过滤数据
    self.searchDataSource= [NSMutableArray arrayWithArray:[self.unSortedDataSource filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}

@end
