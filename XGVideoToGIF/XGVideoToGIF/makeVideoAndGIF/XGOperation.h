//
//  XGOperation.h
//  XGVideoToGIF
//
//  Created by 赵小嘎 on 15/3/21.
//  Copyright (c) 2015年 赵小嘎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


typedef void (^XGOperationCompletionBlock)(NSString *stringPath, NSError *error);


@interface XGOperation : NSOperation

@property (nonatomic, copy) XGOperationCompletionBlock renderCompletionBlock;

- (id) initWithAsset:(AVAsset *)asset;

@end
