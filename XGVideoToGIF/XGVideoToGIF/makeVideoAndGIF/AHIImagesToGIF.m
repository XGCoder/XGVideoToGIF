//
//  AHIImagesToGIF.m
//  Pods
//
//  Created by Harrison Jackson on 2/9/15.
//
//

#import "AHIImagesToGIF.h"

CGSize const AHIGIFDefaultFrameSize                             = (CGSize){480, 320};

NSInteger const AHIGIFDefaultFrameRate                          = 1;
NSInteger const AHIGIFTransitionFrameCount                      = 50;
NSInteger const AHIGIFFramesToWaitBeforeTransition              = 40;

BOOL const AHIGIFDefaultTransitionShouldAnimate = YES;

@implementation AHIImagesToGIF

+ (void)gifFromImages:(NSArray *)images  /////// C
               toPath:(NSString *)path
             withSize:(CGSize)size
              withFPS:(int)fps
   animateTransitions:(BOOL)animate
    withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF _writeImageAsGIF:images
                                 toPath:path
                                   size:size
                                    fps:fps
                     animateTransitions:animate
                      withCallbackBlock:callbackBlock];
    
}

+ (void)gifFromImages:(NSArray *)images
               toPath:(NSString *)path
              withFPS:(int)fps
   animateTransitions:(BOOL)animate
    withCallbackBlock:(SuccessBlock)callbackBlock {
    

    [AHIImagesToGIF gifFromImages:images
                           toPath:path
                         withSize:AHIGIFDefaultFrameSize
                          withFPS:fps
               animateTransitions:animate
                withCallbackBlock:callbackBlock];
}

+ (void)gifFromImages:(NSArray *)images
               toPath:(NSString *)path
             withSize:(CGSize)size
   animateTransitions:(BOOL)animate
    withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF gifFromImages:images
                           toPath:path
                         withSize:size
                          withFPS:AHIGIFDefaultFrameRate
               animateTransitions:animate
                withCallbackBlock:callbackBlock];
    
}

+ (void)gifFromImages:(NSArray *)images
               toPath:(NSString *)path
   animateTransitions:(BOOL)animate
    withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF gifFromImages:images
                           toPath:path
                         withSize:AHIGIFDefaultFrameSize
                          withFPS:AHIGIFDefaultFrameRate
               animateTransitions:animate
                withCallbackBlock:callbackBlock];
    
}

+ (void)gifFromImages:(NSArray *)images
               toPath:(NSString *)path
    withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF gifFromImages:images
                           toPath:path
                         withSize:AHIGIFDefaultFrameSize
                          withFPS:AHIGIFDefaultFrameRate
               animateTransitions:AHIGIFDefaultTransitionShouldAnimate
                withCallbackBlock:callbackBlock];
    
}

+ (void)saveGIFToPhotosWithImages:(NSArray *)images  /////// B
                         withSize:(CGSize)size
                          withFPS:(int)fps
               animateTransitions:(BOOL)animate
                withCallbackBlock:(SuccessBlock)callbackBlock {
    
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"temp.gif"]];
    
    [AHIImagesToGIF gifFromImages:images toPath:tempPath withSize:size withFPS:fps animateTransitions:animate withCallbackBlock:^(BOOL success ,id Path) {
        if (success) {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            
            NSData *data = [NSData dataWithContentsOfFile:tempPath];
            
            [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    NSLog(@"Error Saving GIF to Photo Album: %@", error);
                    if (callbackBlock) {
                        callbackBlock(FALSE ,nil);
                    }

                } else {
                    // TODO: success handling
                    
                    
                    if (callbackBlock) {
                        callbackBlock(TRUE ,tempPath);
                    }

                }
            }];
            
        } else {
            if (callbackBlock) {
                callbackBlock(success ,tempPath);
            }

        }
        
    }];
    
    
}

+ (void)saveGIFToPhotosWithImages:(NSArray *)images
                         withSize:(CGSize)size
               animateTransitions:(BOOL)animate
                withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF saveGIFToPhotosWithImages:images
                                     withSize:size
                                      withFPS:AHIGIFDefaultFrameRate
                           animateTransitions:animate
                            withCallbackBlock:callbackBlock];

    
}

+ (void)saveGIFToPhotosWithImages:(NSArray *)images ////// A
                          withFPS:(int)fps
               animateTransitions:(BOOL)animate
                withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF saveGIFToPhotosWithImages:images
                                     withSize:AHIGIFDefaultFrameSize
                                      withFPS:fps
                           animateTransitions:animate
                            withCallbackBlock:callbackBlock];

    
}

+ (void)saveGIFToPhotosWithImages:(NSArray *)images
               animateTransitions:(BOOL)animate
                withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF saveGIFToPhotosWithImages:images
                                     withSize:AHIGIFDefaultFrameSize
                                      withFPS:AHIGIFDefaultFrameRate
                           animateTransitions:animate
                            withCallbackBlock:callbackBlock];

    
}

+ (void)saveGIFToPhotosWithImages:(NSArray *)images
                withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [AHIImagesToGIF saveGIFToPhotosWithImages:images
                                     withSize:AHIGIFDefaultFrameSize
                                      withFPS:AHIGIFDefaultFrameRate
                           animateTransitions:AHIGIFDefaultTransitionShouldAnimate
                            withCallbackBlock:callbackBlock];
    
}

+ (void)_writeImageAsGIF:(NSArray *)images ///// D
                    toPath:(NSString*)path
                      size:(CGSize)size
                       fps:(int)fps
        animateTransitions:(BOOL)shouldAnimateTransitions
         withCallbackBlock:(SuccessBlock)callbackBlock {
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    
    CGFloat secondsPerFrameFloat = 1 / fps;
    NSNumber * secondsPerFrame = [NSNumber numberWithFloat:secondsPerFrameFloat];
    
    NSDictionary * gifDict = [NSDictionary dictionaryWithObject:secondsPerFrame
                                                         forKey:( NSString *)kCGImagePropertyGIFDelayTime] ;
    
    NSDictionary *prep = [NSDictionary dictionaryWithObject:gifDict
                                                     forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    NSDictionary *fileProperties = @{
                        (__bridge id)kCGImagePropertyGIFDictionary: @{
                            (__bridge id)kCGImagePropertyGIFLoopCount: @0, // 0 means loop forever
                        }
                    };
    
    CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    
    CGImageDestinationRef dst = CGImageDestinationCreateWithURL(url, kUTTypeGIF, [images count], nil);
    CGImageDestinationSetProperties(dst, (__bridge CFDictionaryRef)fileProperties);
    
    for (int i=0;i<[images count];i++)
    {
        
        UIImage * anImage = [images objectAtIndex:i];
        
        
        CGImageDestinationAddImage(dst, anImage.CGImage,(__bridge CFDictionaryRef)(prep));
        
        /* //! implement animation stuff here
        if (shouldAnimateTransitions && i + 1 < [images count]) {
            UIImage * temp;
            
            NSInteger framesToFadeCount = AHIGIFTransitionFrameCount - AHIGIFFramesToWaitBeforeTransition;
            
            //Apply fade frames
            for (double j = 1; j < framesToFadeCount; j++) {
                UIImage * temp = [UIImage crossFadeImage:[array[i] CGImage]
                                                  toImage:[array[i + 1] CGImage]
                                                   atSize:size
                                                withAlpha:j/framesToFadeCount];
                
                CGImageDestinationAddImage(dst, temp.CGImage,(__bridge CFDictionaryRef)(prep));
            }

            
        }
         */
        
    }
    
    bool fileSave = CGImageDestinationFinalize(dst);
    CFRelease(dst);
    if(fileSave) {
        NSLog(@"animated GIF file created at %@", path);
        NSFileManager* manager = [NSFileManager defaultManager];
        //                        if ([manager fileExistsAtPath:urlString]){
        CGFloat gif = [[manager attributesOfItemAtPath:path error:nil] fileSize];
        
        NSLog(@" hehe%lf",gif);
        //                        }
    }else{
        NSLog(@"error: no animated GIF file created at %@", path);
    }
    callbackBlock(fileSave ,path);
    
}




@end
