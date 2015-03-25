//
//  MBProgressHUD+XG.h
//  禅境校园
//
//  Created by 赵小嘎 on 14-12-5.
//  Copyright (c) 2014年 赵小嘎. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XG)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
//+ (void)hideHUD;
@end
