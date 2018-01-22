//
//  Snow001.h
//  tableSecond
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>

// 声明一个协议
@protocol Page2Delegate
// 协议中的方法
- (void)passValue:(NSString *)value;

@end

@interface Snow001 : UIViewController

@property (copy,nonatomic) NSString *imagePath;
@property (strong,nonatomic) UIImageView *imageView;
@property (weak, nonatomic) NSString *string1;
@property (strong,nonatomic) UIImage *image;
// 采用上面协议的物件
@property (weak) id <Page2Delegate>delegate1;

@end
