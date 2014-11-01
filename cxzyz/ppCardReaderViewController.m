//
//  ppCardReaderViewController.m
//  cxzyz
//
//  Created by kingtrust on 14-10-13.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import "ppCardReaderViewController.h"
#import "QBFlatButton.h"
@interface ppCardReaderViewController ()

@end

@implementation ppCardReaderViewController

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
    [self.navigationController setNavigationBarHidden:NO];
    [[QBFlatButton appearance] setFaceColor:[UIColor colorWithWhite:0.75 alpha:1.0] forState:UIControlStateDisabled];
    [[QBFlatButton appearance] setSideColor:[UIColor colorWithWhite:0.55 alpha:1.0] forState:UIControlStateDisabled];
    
    
    QBFlatButton *btn = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(180, 200, 120, 40);
    btn.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    btn.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    btn.radius = 8.0;
    btn.margin = 4.0;
    btn.depth = 3.0;
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"读卡" forState:UIControlStateNormal];;
    [btn addTarget:self action:@selector(readcard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)readcard{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if( [self.tfcardno.text  length] == 0){
            self.tfcardno.text = @"513021199101150899";

        }
        [self.father remotecheckin:self.tfcardno.text];
        [self.navigationController popViewControllerAnimated:YES];
        
    });
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
