//
//  ppMenuViewController.m
//  cxzyz
//
//  Created by kingtrust on 14-9-29.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import "ppMenuViewController.h"

#import "ppSigninViewController.h"
#import "ppMenuViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"
#import "ppProjectLIstViewController.h"
#import "ppMoreOptionsViewController.h"
#import "ppMyProjectsViewController.h"
#import "ppMyProfileViewController.h"
@interface ppMenuViewController ()

@end

@implementation ppMenuViewController
- (IBAction)btn2click:(id)sender {
    ppProjectLIstViewController* vc = [[ppProjectLIstViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView* back = [[UIImageView alloc] initWithFrame:self.view.frame ];
    [self.view addSubview:back];
    back.image = [UIImage imageNamed:@"menubackground.jpg"];
    [self.view sendSubviewToBack:back];
    
    
    for (int row = 0;row<3;row++){
        for (int col = 0;col<2;col++){

            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor grayColor];
            [self.view addSubview:btn];
            btn.frame = CGRectMake(7+155*col, 176 + row*110, 152, 106);
            btn.tag = row*10+col;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            btn.alpha = 0.1;
        }
    }
    
    
    NSDictionary* info = [[NSUserDefaults standardUserDefaults] objectForKey:@"info"];
    NSLog(@"%@",info);
    self.title = @"主页";
    
    UILabel* lbname= [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 200, 20)];
    [self.view addSubview:lbname];
    lbname.text = info[@"NAME"];
    
    UILabel* lbsex= [[UILabel alloc] initWithFrame:CGRectMake(278, 55, 200, 20)];
    [self.view addSubview:lbsex];
    lbsex.text = info[@"SEX"];
    lbsex.font = [UIFont systemFontOfSize:14];

    
    UILabel* lbarea= [[UILabel alloc] initWithFrame:CGRectMake(90, 76, 200, 30)];
    [self.view addSubview:lbarea];
    lbarea.text = info[@"AREA"];
    lbarea.font = [UIFont systemFontOfSize:10];
    lbarea.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    lbarea.numberOfLines = 2;
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)click:(id)sender{
    
    int tag =(int)[sender tag];
    if (tag == 1) {
        ppProjectLIstViewController* vc = [[ppProjectLIstViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (tag == 20) {
        ppMyProfileViewController* vc = [[ppMyProfileViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (tag == 21) {
        ppMoreOptionsViewController* vc = [[ppMoreOptionsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if(tag == 11){
        ppMyProjectsViewController* vc = [[ppMyProjectsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
