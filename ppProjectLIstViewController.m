//
//  ppProjectLIstViewController.m
//  cxzyz
//
//  Created by kingtrust on 14-9-29.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import "ppProjectLIstViewController.h"
#import "ppSigninViewController.h"
#import "ppMenuViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"
#import "ppProjectDetailViewController.h"


@interface ppProjectLIstViewController()
@property NSMutableArray* listData;
@end

@implementation ppProjectLIstViewController

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
    [self.navigationController setNavigationBarHidden:NO];

    NSDictionary* info = [[NSUserDefaults standardUserDefaults]  objectForKey:@"info"];
    NSLog(@"%@",info);
    
    NSDictionary* parameters=@{@"ROWS":@100,@"PAGE":@1,@"ID":info[@"ID"]};
    NSString* urlstring =[NSString stringWithFormat:@"%@%@",baseurl,url_query_project_recorder];
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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.table.backgroundColor = [UIColor clearColor];
//    self.table.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
//    self.table.backgroundView.frame = self.table.frame;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];
    
    UILabel* lbProjectName = [[UILabel alloc]  initWithFrame:CGRectMake(10, 10, 300, 20)];
    lbProjectName.text =self.listData[indexPath.row][@"zyzPiProjectName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel* lbTime1 = [[UILabel alloc]  initWithFrame:CGRectMake(10, 80, 300, 20)];
    lbTime1.text =self.listData[indexPath.row][@"zyzApplyStart"];
    [cell.contentView addSubview:lbTime1];
    lbTime1.font  = [UIFont systemFontOfSize:12];
    lbTime1.textColor = [UIColor grayColor];
    
    UILabel* lbTime2 = [[UILabel alloc]  initWithFrame:CGRectMake(160, 80, 300, 20)];
    lbTime2.text =self.listData[indexPath.row][@"zyzApplyEnd"];
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
//    
//    ppProjectDetailViewController *vc=[[ppProjectDetailViewController alloc] initWithNibName:@"ppProjectDetailViewController" bundle:nil];
//    vc.detaildata = self.listData[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//
//    
    
}

@end
