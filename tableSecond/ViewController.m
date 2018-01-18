//
//  ViewController.m
//  tableSecond
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 snow. All rights reserved.
//
#import "MJRefresh.h"
#import "NSCell.h"
#import "MJTestViewController.h"
#import "MJRefreshHeader.h"
#import "ViewController.h"
#import "UIAlertController+Blocks.h"
#import "Snow001.h"
@interface ViewController ()

@property (strong, nonatomic) UIAlertControllerCompletionBlock tapBlock;
@property (assign, nonatomic) int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datalist = [NSMutableArray array];
    NSCell *object = [[NSCell alloc]init];
    object.name = @"<人间失格>";
    object.cover = @"zxxyKDoVf30.jpg";
    for (int i = 0; i<10; i++) {
//        NSLog(@"%@",object);
//        NSLog(@"%d",i);
        [self.datalist addObject:object];
    }
    
//    NSLog(@"%@",_datalist);
    self.count = 0;
    
    __unsafe_unretained typeof(self) weakSelf = self;
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.count += 12;
            [tableView reloadData];
            [tableView.mj_header endRefreshing];
        });
    }];
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.count += 5;
            [tableView reloadData];
            [tableView.mj_footer endRefreshing];
        });
    }];
    footer.hidden = YES;
    tableView.mj_footer = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datalist count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifierString = @"snow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
    }
    NSInteger rowIndex = [indexPath row];
//    NSDictionary *cellDictionary = [self.datalist objectAtIndex:rowIndex];
    cell.textLabel.text = [[self.datalist objectAtIndex:rowIndex] name];
    cell.imageView.image = [UIImage imageNamed:[[self.datalist objectAtIndex:rowIndex] cover]];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row == 0) {
//        NSLog(@"进来方法了");
        NSCell *object = [[NSCell alloc]init];
        object.name = @"<白夜行>";
        object.cover = @"PKAW8MQYlU8.jpg";
        for (int i = 0; i<10; i++) {
//            NSLog(@"进来循环了");
            [self.datalist addObject:object];
        }
        [tableView reloadData];
    }
}

//点击每一条数据进入此方法
//参数：indexPath：第几行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _myview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSInteger row = indexPath.row;
    if (row == 0 || row ==11) {
        [self performSegueWithIdentifier:@"snow001" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"11111");
    if ([[segue identifier] isEqualToString:@"snow001"]) {// string值为在Segue属性Identifier处设置的值
        // 相应处理
        // 将page2变量设为segue所跳转的界面控制器
        id page2 = segue.destinationViewController;
        // 对page2中的变量设置值
        [page2 setValue:@"123" forKey:@"string1"];
        [page2 setValue:self forKey:@"delegate1"];
        
    }else if ([[segue identifier] isEqualToString:@"btn2Segue"]){
              NSLog(@"11111");
    }
}
//设置rowHeight
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row % 2 == 0) {
//        return 250;
//    } else {
//        return 150;
//    }
//}

- (IBAction)btnClicked:(id)sender{
    [self.myview removeFromSuperview];
//    NSLog(@"哈哈哈哈哈哈哈😄");
}

- (void)passValue:(NSString *)value {
    // 设定编辑框内容为协议传过来的值
//    UIAlertController *
    NSLog(@"value:%@",value);
}

- (IBAction)showActionSheet:(UIBarButtonItem *)sender
{
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"Choose"
                                               message:@"选择你的上传图片方式"
                                     cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"本地图片", @"拍摄照片"]
#if TARGET_OS_IOS
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController *popover){
                        
                        popover.sourceView = self.view;
//                        popover.sourceRect = sender.frame;
                    }
#endif
                                              tapBlock:self.tapBlock];
}

/**
 
 *  调用照相机
 
 */

- (void)openCamera{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES; //可编辑
    
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        NSLog(@"没有摄像头");
        
    }
    
}

/**
 
 *  打开相册
 
 */

-(void)openPhotoLibrary{
    
    // Supported orientations has no common orientation with the application, and [PUUIAlbumListViewController shouldAutorotate] is returning YES
    
    // 进入相册
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.allowsEditing = YES;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
    } else {
        NSLog(@"不能打开相册");
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [[UIImage alloc]init];
    //获取到了选择的图片
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //此方法负责退出此页面（图片选取页面）如果不退出没办法进入新的页面
    [picker dismissViewControllerAnimated:YES completion:nil];
    Snow001 *snow = [[Snow001 alloc]init];
    snow.image = image;
    [self.navigationController pushViewController:snow animated:YES];
}

/**
 *在这里判断用户点击了哪个按钮
 *
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    __weak typeof(self) weakSelf = self;
    if (self) {
        self.tapBlock = ^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
            if (buttonIndex == controller.destructiveButtonIndex) {
                NSLog(@"Delete");
            } else if (buttonIndex == controller.cancelButtonIndex) {
                NSLog(@"Cancel");
            } else if (buttonIndex >= controller.firstOtherButtonIndex) {
               
                if ((long)buttonIndex - controller.firstOtherButtonIndex + 1 == 1) {
                    [weakSelf openPhotoLibrary];
                } else if ((long)buttonIndex - controller.firstOtherButtonIndex + 1 == 2){
                    [weakSelf openCamera];
                } else {
                    NSLog(@"闹鬼啦！！！！！！！");
                }
//                NSLog(@"Other %ld", (long)buttonIndex - controller.firstOtherButtonIndex + 1);
//                NSLog(@"buttonindex:%ld",(long)buttonIndex);
//                NSLog(@"controller.firstOtherButtonIndex:%ld", controller.firstOtherButtonIndex);
            }
        };
    }
    return self;
}

@end
