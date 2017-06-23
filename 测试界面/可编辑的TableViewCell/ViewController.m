//
//  ViewController.m
//  可编辑的TableViewCell
//
//  Created by 贺嘉炜 on 2017/6/23.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) UITableView *classTable;
@property (nonatomic,strong) NSMutableArray *classArray;
@property (nonatomic,assign) NSInteger indexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据源
    _classArray = [[NSMutableArray alloc]init];
    [self getClassList];
    _classTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _classTable.delegate = self;
    _classTable.dataSource = self;
    _classTable.scrollEnabled = YES;
    _classTable.userInteractionEnabled = YES;
    //    [_classTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _classTable.tableFooterView = [[UIView alloc]init];
    //tableview 分割线
    if ([_classTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [_classTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([_classTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.classTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    [self.view addSubview:_classTable];
    
}
/**
 *  获取班级列表
 */
- (void)getClassList{
    //设置假数据
    NSArray *schollArr = @[@"北京小学",@"北京第六十六中学",@"北京第六十六中学",@"北京二中",@"朝阳区第一中学",@"通州六中",@"大兴区实验小学",@"石景山希望中学",@"昌平一中"];
    NSArray *classArr = @[@"三班",@"八班",@"特长班",@"实验八班",@"凤姐班",@"芙蓉班",@"逗逼班",@"大神班",@"白富美班"];
    //0-审核中，1-默认班，2-设为默认班
    NSArray *statusArr = @[@"1",@"2",@"2",@"0",@"2",@"2",@"0",@"2",@"0"];
    for (int i = 0; i < schollArr.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:schollArr[i] forKey:@"schoolname"];
        [dic setObject:classArr[i] forKey:@"classname"];
        [dic setObject:statusArr[i] forKey:@"status"];
        [_classArray addObject:dic];
    }
    
    [_classTable reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _classArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *classDic = [_classArray objectAtIndex:indexPath.row];
    static NSString *cellId = @"class";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //判断班级类型（默认，审核中，设为默认）
    NSString *status = [classDic objectForKey:@"status"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        //学校
        UILabel *schoolLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
        schoolLabel.font = [UIFont systemFontOfSize:14];
        schoolLabel.userInteractionEnabled = NO;
        if ([status isEqualToString:@"0"]) {
            [schoolLabel setTextColor:[UIColor lightGrayColor]];
        }
        else
            [schoolLabel setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:schoolLabel];
        schoolLabel.tag = 101;
        //班级
        UILabel *classLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 200, 20)];
        classLabel.font = [UIFont systemFontOfSize:14];
        classLabel.userInteractionEnabled = NO;
        if ([status isEqualToString:@"0"]) {
            [classLabel setTextColor:[UIColor lightGrayColor]];
        }
        else
            classLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:classLabel];
        classLabel.tag = 102;
        //状态
        UIButton *statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statusBtn.frame = CGRectMake(SCREEN_WIDTH -105, 25 - 10, 100, 20);
        statusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        statusBtn.tag = indexPath.row + 1000;
        [statusBtn addTarget:self action:@selector(setMorenClass:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:statusBtn];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //学校
    UILabel *schoolLabel = (UILabel *)[cell.contentView viewWithTag:101];
    schoolLabel.text = classDic[@"schoolname"];
    //班级
    UILabel *classLabel = (UILabel *)[cell.contentView viewWithTag:102];
    classLabel.text = [classDic objectForKey:@"classname"];
    //班级状态
    UIButton *statusBtn = (UIButton *)[cell.contentView viewWithTag:indexPath.row + 1000];
    if ([status isEqualToString:@"0"]) {
        [statusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [statusBtn setTitle:@"[审核中]" forState:UIControlStateNormal];
        statusBtn.layer.masksToBounds = YES;
        statusBtn.layer.borderWidth = 0.0;
        statusBtn.userInteractionEnabled = NO;
        cell.userInteractionEnabled = NO;
    }
    else if([status isEqualToString:@"1"]){
        
        [statusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [statusBtn setTitle:@"默认班" forState:UIControlStateNormal];
        statusBtn.layer.masksToBounds = YES;
        statusBtn.layer.borderWidth = 0.0;
        statusBtn.userInteractionEnabled = NO;
        cell.userInteractionEnabled = YES;
    }
    else{
        [statusBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [statusBtn setTitle:@"设为默认班" forState:UIControlStateNormal];
        statusBtn.layer.masksToBounds = YES;
        statusBtn.layer.borderWidth = 0.5;
        statusBtn.userInteractionEnabled = YES;
        cell.userInteractionEnabled = YES;
    }
    return cell;
    
}
- (void)setMorenClass:(id)sender{
    UIButton *setBtn = (UIButton *)sender;
    _indexPath = setBtn.tag - 1000;
    [self modifyData:_indexPath];
}
//修改数据源-- 假数据
- (void)modifyData:(NSInteger)index{
    for (int i = 0; i<_classArray.count; i++) {
        NSDictionary *dic = [_classArray objectAtIndex:i];
        NSString *status = [dic objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [dic setValue:@"2" forKey:@"status"];
        }
        if (index == i) {
            [dic setValue:@"1" forKey:@"status"];
        }
    }
    [_classTable reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *classDic = [_classArray objectAtIndex:indexPath.row];
    NSString *status = [classDic objectForKey:@"status"];
    switch (status.intValue) {
        case 0:
            return;
            break;
        case 1:
        {
            //进入照片录
            NSLog(@"进入照片录");
        }
            break;
        case 2:
        {
            //进入照片录
            NSLog(@"进入照片录");
        }
            break;
        default:
            break;
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//设置cell可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark -- cell左滑动退出班级
//设cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
    
}
//修改编辑按钮的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"退出";
}

//进入编辑模式，点击出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定退出该班级？" preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //
            [_classArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
