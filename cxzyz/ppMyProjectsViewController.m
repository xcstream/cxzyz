//
//  ppMyProjectsViewController.m
//  cxzyz
//
//  Created by kingtrust on 14-10-13.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import "ppMyProjectsViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"
#import "ppProjectDetailViewController.h"

@interface ppMyProjectsViewController ()
@property NSMutableArray* listData;
@property UITableView* table;
@end

@implementation ppMyProjectsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.listData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的项目";
    UITableView* table = [[UITableView alloc] initWithFrame:self.view.frame];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.table = table;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.table.backgroundColor = [UIColor clearColor];

    
    
    [self.navigationController setNavigationBarHidden:NO];
    
    NSDictionary* info = [[NSUserDefaults standardUserDefaults]  objectForKey:@"info"];
    NSLog(@"%@",info);
    
    NSDictionary* parameters=@{@"ROWS":@100,@"PAGE":@1,@"ID":info[@"ID"]};
    NSString* urlstring =[NSString stringWithFormat:@"%@%@",baseurl,url_query_myprojects];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.table.backgroundColor = [UIColor clearColor];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];
    [manager POST:urlstring parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"operation: %@", operation);
        NSLog(@"JSON: %@", responseObject);
        self.listData = responseObject[@"rows"];
        
        
        NSLog(@"JSON : %@", responseObject[@"rows"]);

        [self.table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"无法连接服务器" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [al show];
        
    }];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];

    UILabel* lbProjectName = [[UILabel alloc]  initWithFrame:CGRectMake(10, 10, 300, 40)];
    lbProjectName.text =self.listData[indexPath.row][@"projectName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    lbProjectName.numberOfLines = 3;
    
    UILabel* lbTime1 = [[UILabel alloc]  initWithFrame:CGRectMake(10, 80, 300, 20)];
    lbTime1.text =self.listData[indexPath.row][@"start"];
    [cell.contentView addSubview:lbTime1];
    lbTime1.font  = [UIFont systemFontOfSize:12];
    lbTime1.textColor = [UIColor grayColor];
    
    UILabel* lbTime2 = [[UILabel alloc]  initWithFrame:CGRectMake(160, 80, 300, 20)];
    lbTime2.text =self.listData[indexPath.row][@"serveEnd"];
    [cell.contentView addSubview:lbTime2];
    lbTime2.font  = [UIFont systemFontOfSize:12];
    lbTime2.textColor = [UIColor grayColor];
    
    [cell.contentView addSubview:lbProjectName];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ppProjectDetailViewController *vc=[[ppProjectDetailViewController alloc] initWithNibName:@"ppProjectDetailViewController" bundle:nil];
    vc.detaildata = self.listData[indexPath.row];
    vc.projectid =self.listData[indexPath.row][@"projectId"];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
