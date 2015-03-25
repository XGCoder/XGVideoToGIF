//
//  AHIImagesToGIF.h
//  Pods
//
//  Created by Harrison Jackson on 2/9/15.
//
//
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  Determines defaults for transitions
 */
FOUNDATION_EXPORT BOOL const AHIGIFDefaultTransitionShouldAnimate;

/**
 *  Determines default frame size for videos
 */
FOUNDATION_EXPORT CGSize const AHIGIFDefaultFrameSize;

/**
 *  Determines default FPS of video - 10 Images at 10FPS results in a 1 second video clip.
 */
FOUNDATION_EXPORT NSInteger const AHIGIFDefaultFrameRate;

/**
 *  Number of frames to use in transition
 */
FOUNDATION_EXPORT NSInteger const AHIGIFTransitionFrameCount;

/**
 *  Number of frames to hold each image before beginning alpha fade into the next
 */
FOUNDATION_EXPORT NSInteger const AHIGIFFramesToWaitBeforeTransition;


typedef void(^SuccessBlock)(BOOL success , id Path);

@interface AHIImagesToGIF : NSObject

+ (void)gifFromImages:(NSArray *)images /////// C 
                 toPath:(NSString *)path
               withSize:(CGSize)size
                withFPS:(int)fps
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)gifFromImages:(NSArray *)images
                 toPath:(NSString *)path
                withFPS:(int)fps
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)gifFromImages:(NSArray *)images
                 toPath:(NSString *)path
               withSize:(CGSize)size
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)gifFromImages:(NSArray *)images
                 toPath:(NSString *)path
     animateTransitions:(BOOL)animate
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)gifFromImages:(NSArray *)images
                 toPath:(NSString *)path
      withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveGIFToPhotosWithImages:(NSArray *)images///////B
                           withSize:(CGSize)size
                            withFPS:(int)fps
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveGIFToPhotosWithImages:(NSArray *)images
                           withSize:(CGSize)size
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveGIFToPhotosWithImages:(NSArray *)images //////////  A
                            withFPS:(int)fps
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveGIFToPhotosWithImages:(NSArray *)images
                 animateTransitions:(BOOL)animate
                  withCallbackBlock:(SuccessBlock)callbackBlock;

+ (void)saveGIFToPhotosWithImages:(NSArray *)images
                  withCallbackBlock:(SuccessBlock)callbackBlock;



@end
