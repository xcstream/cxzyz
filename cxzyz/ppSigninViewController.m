//
//  ppSigninViewController.m
//  cxzyz
//
//  Created by kingtrust on 14-9-29.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import "ppSigninViewController.h"
#import "ppMenuViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"
#import "ppRegisterViewController.h"
#import "QBFlatButton.h"

@interface ppSigninViewController (){
    BOOL isLogging;
}


@end
@implementation ppSigninViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isLogging = false;
    }
    return self;
}
- (IBAction)register:(id)sender {
    
    ppRegisterViewController* vc = [[ppRegisterViewController alloc] initWithNibName:@"ppRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)login:(id)sender {
 //   NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *session = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    if (isLogging) {
        return;
    }
    isLogging = true;
    
    
    NSDictionary* parameters=@{@"PASSWORD":self.tfPassword.text,@"USERID":self.tfUsername.text};
    NSString* urlstring =[NSString stringWithFormat:@"%@%@",baseurl,url_login];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];
    [manager POST:urlstring parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"operation: %@", operation);
        NSLog(@"JSON: %@", responseObject);
        [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"info"];
        isLogging = false;

        if ([responseObject[@"result"]  isEqualToString:@"1"]) {
            [[NSUserDefaults standardUserDefaults] setObject: self.tfUsername.text
                                                      forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject: self.tfPassword.text
                                                      forKey:@"password"];
            
            ppMenuViewController* vc = [[ppMenuViewController alloc] initWithNibName:@"ppMenuViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或者密码错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [al show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isLogging = false;
        NSLog(@"Error: %@", error);
        UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"无法连接服务器" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [al show];
    }];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView* back = [[UIImageView alloc] initWithFrame:self.view.frame];
    back.image = [UIImage imageNamed:@"loginback"];
    [self.view addSubview:back];
    [self.view sendSubviewToBack:back];
    
    
    
    [[QBFlatButton appearance] setFaceColor:[UIColor colorWithWhite:0.75 alpha:1.0] forState:UIControlStateDisabled];
    [[QBFlatButton appearance] setSideColor:[UIColor colorWithWhite:0.55 alpha:1.0] forState:UIControlStateDisabled];
    
    
    QBFlatButton *btn = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(180, 255, 120, 40);
    btn.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    btn.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    btn.radius = 8.0;
    btn.margin = 4.0;
    btn.depth = 3.0;
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"登陆" forState:UIControlStateNormal];;
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    QBFlatButton *btn2 = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 255, 120, 40);
    btn2.faceColor = [UIColor colorWithRed:243.0/255.0 green:152.0/255.0 blue:0 alpha:1.0];
    btn2.sideColor = [UIColor colorWithRed:170.0/255.0 green:105.0/255.0 blue:0 alpha:1.0];
    btn2.radius = 6.0;
    btn2.margin = 7.0;
    btn2.depth = 6.0;
    
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"注册" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(register:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn2];
    
    



}


-(void)viewDidAppear:(BOOL)animated{
    self.tfUsername.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    self.tfPassword.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
