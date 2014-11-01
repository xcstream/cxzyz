//
//  ppProjectDetailViewController.h
//  cxzyz
//
//  Created by kingtrust on 14-9-29.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ppProjectDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (weak, nonatomic) IBOutlet UITextView *tvDetail;
@property NSDictionary *detaildata;
@property NSString* projectid,*cardid;
-(void)remotecheckin:(NSString*)cardNumber;
@end
