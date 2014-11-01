//
//  ppCardReaderViewController.h
//  cxzyz
//
//  Created by kingtrust on 14-10-13.
//  Copyright (c) 2014年 xxstream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ppProjectDetailViewController.h"

@interface ppCardReaderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfcardno;
@property ppProjectDetailViewController* father;

@end
