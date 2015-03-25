//
//  XGOperation.m
//  XGVideoToGIF
//
//  Created by 赵小嘎 on 15/3/21.
//  Copyright (c) 2015年 赵小嘎. All rights reserved.
//

#import "XGOperation.h"
#import "AHIImagesToGIF.h"


@interface NSDictionary (JSSorting)

- (NSArray *) sortedKeys;

@end

@implementation NSDictionary (JSSorting)

- (NSArray *) sortedKeys
{
    return [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        double first = [obj1 doubleValue];
        double second = [obj2 doubleValue];
        
        if (first > second) {
            return NSOrderedDescending;
        }
        
        if (first < second) {
            return NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
}

@end

@interface XGOperation()

@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) AVAssetImageGenerator *generator;//取出视频中的每一帧每一帧的类

@property (nonatomic, assign) CGRect frame;
@property (strong, nonatomic) NSArray *offsets;

@property (strong, nonatomic) NSString *stringPath;


@end

@implementation XGOperation

#pragma mark - Memory mgmt

- (id) initWithAsset:(AVAsset *)asset
{
    self = [super init];
    
    if (self) {
        self.asset = asset;
        
        
        self.offsets = [NSArray array];
        
        self.generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
        
        self.generator.appliesPreferredTrackTransform = YES;
    }
    
    return self;
}
#pragma mark - NSOperation overrides

- (void) main
{
    
    NSError *error = nil;
    
    
    if (self.isCancelled) {
        return;
    }
    
    if (error) {
        NSLog(@"Error extracting reference image from asset: %@", [error localizedDescription]);
        return;
    }
    
    size_t height = (size_t)288;
    size_t width = (size_t)288;
    
    self.generator.maximumSize = CGSizeMake(width, height);
    
    
    
    if (self.isCancelled) {
        return;
    }
    
    NSDictionary *images = nil;
    images = [self extractFromAssetAt:[self generateOffsets:self.asset] error:&error];
    if (self.isCancelled) {
        return;
    };
    NSMutableArray *  strip =[NSMutableArray array];
    if (images) {
        NSArray *times = [self generateOffsets:self.asset];
        
        
        for (int idx = 0; idx < [times count]; idx++) {
            
            NSNumber *time = [times objectAtIndex:idx];
            CGImageRef image = (__bridge CGImageRef)([images objectForKey:time]);
            
            [strip addObject:[UIImage imageWithCGImage:image]];
            
            NSLog(@"%d",idx);
        }
        
        [AHIImagesToGIF saveGIFToPhotosWithImages:strip
                                          withFPS:30
                               animateTransitions:YES
                                withCallbackBlock:^(BOOL success ,id Path) {
                                    if (success) {
                                        _stringPath=Path;
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            self.renderCompletionBlock(_stringPath, error);
                                        });
                                        
                                        
                                        NSLog(@"Success %@",Path);
                                        
                                        
                                    } else {
                                        NSLog(@"Failed");
                                    }
                                    
                                }];
        
        
    }else
    {
        _stringPath =@"获取视频失败";
        dispatch_async(dispatch_get_main_queue(), ^{
            self.renderCompletionBlock(_stringPath, error);
        });
    }
    
}

#pragma mark - Support

- (NSArray *) generateOffsets:(AVAsset *) asset
{
    
    
    double duration = CMTimeGetSeconds(asset.duration);
    
    
    NSMutableArray *indexes = [NSMutableArray array];
    
    double time = 0.0f;
    
    while (time < duration) {
        [indexes addObject:[NSNumber numberWithDouble:time]];
        time +=0.1;
    }
    
    return indexes;
}

- (NSDictionary *) extractFromAssetAt:(NSArray *)indexes error:(NSError **)error
{
    NSMutableDictionary *images = [NSMutableDictionary dictionaryWithCapacity:[indexes count]];
    NSLog(@"%li",(unsigned long)[indexes count]);
    CMTime actualTime;
    
    for (NSNumber *number in indexes) {
        
        if (self.isCancelled) {
            return nil;
        }
        
        double offset = [number doubleValue];
        NSLog(@"%f",offset);
        if (offset < 0 || offset > CMTimeGetSeconds(self.asset.duration)) {
            continue;
        }
        
        self.generator.requestedTimeToleranceBefore = kCMTimeZero;
        self.generator.requestedTimeToleranceAfter = kCMTimeZero;
        CMTime t = CMTimeMakeWithSeconds(offset, [indexes count]);
        CGImageRef source = [self.generator copyCGImageAtTime:t actualTime:nil error:error];
        
        if (!source) {
            NSLog(@"Error copying image at index %f: %@", CMTimeGetSeconds(actualTime), [*error localizedDescription]);
            return nil;
        }
        
        [images setObject:CFBridgingRelease(source) forKey:number];
    }
    
    return images;
}

@end
