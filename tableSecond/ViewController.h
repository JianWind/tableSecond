//
//  ViewController.h
//  tableSecond
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) NSMutableArray *datalist;
@property (strong,nonatomic) UIView *myview;
//@property (strong,nonatomic) IBOutlet UITableView *table;

@end

