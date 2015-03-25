//
//  GifViewController.m
//  GIFdemo
//
//  Created by 赵小嘎 on 15/3/21.
//  Copyright (c) 2015年 赵小嘎. All rights reserved.
//

#import "GifViewController.h"

@interface GifViewController ()

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.text = @"返回";
    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(50, 280, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    
    // 设定位置和大小
    CGRect frame = CGRectMake(50,50,200,200);
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: self.path];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
