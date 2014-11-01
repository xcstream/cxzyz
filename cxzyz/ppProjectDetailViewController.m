//
//  ppProjectDetailViewController.m
//  cxzyz
//
//  Created by kingtrust on 14-9-29.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import "ppProjectDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"
#import "ppCardReaderViewController.h"
@interface ppProjectDetailViewController ()
@property NSMutableArray* listData;
@property UITableView* table;

@end

@implementation ppProjectDetailViewController
- (IBAction)btnCheckin:(id)sender {
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars =NO;
    self.modalPresentationCapturesStatusBarAppearance =NO;
    self.navigationController.navigationBar.translucent =NO;
    
    
    self.title=@"签到记录";
    [self.navigationController setNavigationBarHidden:NO];
    UITableView* table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource =self;
    self.table = table;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:@"签到"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(checkin)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [self reload];
    
    
}



-(void)checkin{
    ppCardReaderViewController * vc = [[ppCardReaderViewController alloc] initWithNibName:@"ppCardReaderViewController" bundle:nil];
    vc.father = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)remotecheckin:(NSString*)cardNumber{
    if (cardNumber && [cardNumber length]>0) {
        self.cardid = cardNumber;
        NSString* str = [NSString stringWithFormat:@"使用卡号%@进行签到",cardNumber];
        UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"签到确认" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [al show];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];
    UILabel* lbProjectName = [[UILabel alloc]  initWithFrame:CGRectMake(10, 10, 300, 20)];
    lbProjectName.text =self.listData[indexPath.row][@"projectName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UILabel* lbname = [[UILabel alloc]  initWithFrame:CGRectMake(10, 60, 300, 20)];
    lbname.textAlignment = NSTextAlignmentRight;
    lbname.text = [NSString stringWithFormat:@"志愿者: %@  ",self.listData[indexPath.row][@"volunteerName"]];
    lbname.font = [ UIFont systemFontOfSize:13];
    
    UILabel* lbTime1 = [[UILabel alloc]  initWithFrame:CGRectMake(10, 80, 300, 20)];
    lbTime1.text =self.listData[indexPath.row][@"recordTime"];
    [cell.contentView addSubview:lbTime1];
    lbTime1.font  = [UIFont systemFontOfSize:12];
    lbTime1.textColor = [UIColor grayColor];
    
    UILabel* lbTime2 = [[UILabel alloc]  initWithFrame:CGRectMake(170, 80, 300, 20)];
    lbTime2.text =self.listData[indexPath.row][@"recordTimeOut"];
    [cell.contentView addSubview:lbTime2];
    lbTime2.font  = [UIFont systemFontOfSize:12];
    lbTime2.textColor = [UIColor grayColor];
    
    [cell.contentView addSubview:lbname];
    
    [cell.contentView addSubview:lbProjectName];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    //
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
//        0       本机器未注册
//        1       后台系统异常
//        2       没有可参加的活动
//        3       签到成功
//        4       签退成功
//        5       未报名此活动或报名未通过审核
//        6       志愿者未通过审核
//        7       志愿者未注册

        
        NSDictionary* parameters=@{@"Card_ID":self.cardid,@"Project_ID":self.projectid};
        NSString* urlstring =[NSString stringWithFormat:@"%@%@",baseurl,url_query_checkin];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"text/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];
        [manager POST:urlstring parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"operation: %@", operation);
            NSLog(@"JSON: %@", responseObject);
           
            NSString* result = responseObject[@"result"];
            int i = [result intValue];
            NSArray* errorno =  @[@"本机器未注册",@"后台系统异常",@"没有可参加的活动",@"签到成功",@"签退成功",@"未报名此活动或报名未通过审核",@"志愿者未通过审核",@"志愿者未注册"];
            
            UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:errorno[i] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [al show];
            
            [self reload];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"无法连接服务器" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [al show];
        }];
    }
}


-(void)reload{
    NSDictionary* info = [[NSUserDefaults standardUserDefaults]  objectForKey:@"info"];
    NSLog(@"%@",info);
    
    NSDictionary* parameters=@{@"ROWS":@100,@"PAGE":@1,@"projectid":self.projectid};
    NSString* urlstring =[NSString stringWithFormat:@"%@%@",baseurl,url_query_record];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];
    [manager POST:urlstring parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"operation: %@", operation);
        NSLog(@"JSON: %@", responseObject);
        self.listData = responseObject[@"rows"];
        [self.table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"无法连接服务器" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [al show];
        
    }];
    
    
}
@end
