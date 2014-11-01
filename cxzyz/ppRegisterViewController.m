//
//  ppRegisterViewController.m
//  cxzyz
//
//  Created by kingtrust on 14-10-13.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import "ppRegisterViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"

@interface ppRegisterViewController (){
    BOOL isLogging;
    NSMutableArray *cells,*textFeilds;
}

@end

@implementation ppRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isLogging = false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = @"注册";
    
    UITableView* table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:table];
    
    [self initCells];
    table.delegate = self;
    table.dataSource = self;

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:@"提交"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    // Do any additional setup after loading the view from its nib.
//    [self.navigationController];

}


-(void)submit{
    
    [self doregister];
    
}

-(void) initCells{
    cells = [[NSMutableArray alloc] init];
    textFeilds = [[NSMutableArray alloc] init];

    UITableViewCell* cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell1.textLabel.text = @"用户ID";
    [cells addObject:cell1];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITextField *tfuserid = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tfuserid.placeholder = @"登录名";
    [cell1.contentView addSubview:tfuserid];
    tfuserid.delegate = self;
    [textFeilds addObject:tfuserid];

    UITableViewCell* cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell2.textLabel.text = @"密码";
    [cells addObject:cell2];
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;

    UITextField *tfpassword = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tfpassword.secureTextEntry = true;
    [cell2.contentView addSubview:tfpassword];
    tfpassword.placeholder = @"密码至少6位";
    tfpassword.delegate = self;
    [textFeilds addObject:tfpassword];

    UITableViewCell* cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell3.textLabel.text = @"姓名";
    [cells addObject:cell3];
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITextField *tfname = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tfname.placeholder = @"姓名";
    [cell3.contentView addSubview:tfname];
    tfname.delegate = self;
    [textFeilds addObject:tfname];

    UITableViewCell* cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell4.textLabel.text = @"生日";
    [cells addObject:cell4];
    cell4.selectionStyle = UITableViewCellSelectionStyleNone;

    UITextField *tfbirth = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tfbirth.placeholder = @"格式yyyy-MM-dd";
    [cell4.contentView addSubview:tfbirth];
    tfbirth.delegate = self;
    [textFeilds addObject:tfbirth];

    
    UITableViewCell* cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell5.textLabel.text = @"住址";
    [cells addObject:cell5];
    cell5.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITextField *tfaddress = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tfaddress.placeholder = @"住址";
    [cell5.contentView addSubview:tfaddress];
    tfaddress.delegate = self;
    [textFeilds addObject:tfaddress];


    UITableViewCell* cell6 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell6.textLabel.text = @"身份证";
    [cells addObject:cell6];
    cell6.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITextField *tfcardid = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tfcardid.placeholder = @"身份证号码";
    [cell6.contentView addSubview:tfcardid];
    tfcardid.delegate = self;
    [textFeilds addObject:tfcardid];
 
    UITableViewCell* cell7 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell7.textLabel.text = @"性别";
    [cells addObject:cell7];
    cell7.selectionStyle = UITableViewCellSelectionStyleNone;

    UITextField *tfsex = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tfsex.placeholder = @"填写男或女";
    [cell7.contentView addSubview:tfsex];
    tfsex.delegate = self;
    [textFeilds addObject:tfsex];

    UITableViewCell* cell8 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    cell8.textLabel.text = @"手机";
    [cells addObject:cell8];
    cell8.selectionStyle = UITableViewCellSelectionStyleNone;

    UITextField *tftelephone = [[UITextField alloc] initWithFrame:CGRectMake(100, 13, 200, 20)];
    tftelephone.placeholder = @"手机号码";
    [cell8.contentView addSubview:tftelephone];
    tftelephone.delegate = self;
    [textFeilds addObject:tftelephone];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)doregister{
    
    NSDictionary* parameters=@{@"USERID":[textFeilds[0] text] ,@"PASSWORD":[textFeilds[1] text],@"NAME":[textFeilds[2] text],@"BIRTHDAY":[textFeilds[3] text],@"ADDRESS":[textFeilds[4]  text],@"IDCARD":[textFeilds[5] text],@"GENDER":[textFeilds[6] text],@"TELLPHONE":[textFeilds[7]  text]};
    
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
//            ppMenuViewController* vc = [[ppMenuViewController alloc] initWithNibName:@"ppMenuViewController" bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];
            UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [al show];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else{
            UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"注册信息错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [al show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isLogging = false;
        
        NSLog(@"Error: %@", error);
        UIAlertView* al =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"无法连接服务器" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [al show];
    }];
    
//
//    USERID：账号
//    PASSWORD：密码
//    NAME：姓名
//BIRTHDAY:生日  格式为：yyyy-MM-dd
//ADDRESS:居住地址
//    IDCARD：身份证号码
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row<8) {
        return cells[indexPath.row];

    }else{
        return [[UITableViewCell alloc] init];
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 100;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}




@end
