//
//  Snow001.m
//  tableSecond
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "Snow001.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
@interface Snow001 ()

@end

@implementation Snow001

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    [_imageView setImage:_image];
    [self.view addSubview:_imageView];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"upload" style:UIBarButtonItemStyleDone target:self action:@selector(upload)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.imagePath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)upload
{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *URL = [NSURL URLWithString:@"http://10.120.250.204:8080/dynamitecar/SysImageInfoController/uploadHosEnclosure.json"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
////    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:self.imagePath ofType:nil];
//    NSURL *filePath = [NSURL URLWithString:self.imagePath];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Success: %@ %@", response, responseObject);
//        }
//    }];
//    [uploadTask resume];
    
    
    
    // 创建管理者对象
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    // 请求参数
    NSString *urlStr = @"https://10.120.250.204:8080/dynamitecar/SysImageInfoController/uploadHosEnclosure.json";
    
    NSDictionary *dic = @{@" " : @" ",@" " : @" "};
    
    // 发送 post 请求，上传一张图片
    [sessionManager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"a.jpg" ofType:nil];
        NSData *imgData = [NSData dataWithContentsOfFile:self.imagePath];
        
        // 将图片数据拼接，进行上传
        [formData appendPartWithFileData:imgData name:@"pic" fileName:@"filename" mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        // 获取上传的进度
        NSLog(@"%.2f",uploadProgress.fractionCompleted);
        NSLog(@"%@",[NSThread currentThread]); //子线程
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功
        NSLog(@"请求成功：%@",responseObject);
        NSLog(@"%@",[NSThread currentThread]); //主线程
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 请求失败
        NSLog(@"请求失败：%@",error);
    }];
    
//    作者：n以梦为马
//    链接：https://www.jianshu.com/p/5b944ffc6f00
//    來源：简书
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

}


//-(void)upload
//{
//    //1.创建会话管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    //2.发送请求上传文件
//    /*
//     第一个参数:请求路径(NSString)
//     第二个参数:非文件参数
//     第三个参数:constructingBodyWithBlock 拼接数据(告诉AFN要上传的数据是哪些)
//     第四个参数:progress 进度回调
//     第五个参数:success 成功回调
//     responseObject:响应体
//     第六个参数:failure 失败的回调
//     */
//    //http://10.120.250.204:8080/skproject/SysImageInfoController/uploadHosEnclosure.json
//    [manager POST:@"http://www.baidu.com" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.imagePath ofType:nil];
//        NSLog(@"%@",filePath);
//        NSData *data = [NSData dataWithContentsOfFile:filePath];
//        //拼接数据
//        /*
//         第一个参数:文件参数 (二进制数据)
//         第二个参数:参数名~file
//         第三个参数:该文件上传到服务器以什么名称来保存
//         第四个参数:
//         */
//        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/jpeg"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success--%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"failure -- %@",error);
//    }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
