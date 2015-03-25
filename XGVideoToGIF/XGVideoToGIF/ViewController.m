//
//  ViewController.m
//  XGVideoToGIF
//
//  Created by 赵小嘎 on 15/3/20.
//  Copyright (c) 2015年 赵小嘎. All rights reserved.
//

#import "ViewController.h"
#import "XGMakeVideoController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)btnClick:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender
{
    XGMakeVideoController *takeVideoVC=[[XGMakeVideoController alloc]init];
    [self.navigationController pushViewController:takeVideoVC animated:YES];
    
}







@end
