//
//  UIImage+ANExt.h
//  AskNow
//
//  Created by Little Box on 23/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ANExt)

+ (UIImage *)imageWithView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)resizableImage;

- (UIImage *)resizeImageToSize:(CGSize)size;

- (UIImage *)resizeImageToSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale;

- (UIImage *)createWithImageInRect:(CGRect)rect;

- (UIImage *)getGrayImage;

- (UIImage *)darkenImage;

- (UIImage *)partialImageWithPercentage:(float)percentage vertical:(BOOL)vertical grayscaleRest:(BOOL)grayscaleRest;

- (CGSize)pixelSize;

- (NSInteger)imageFileSize;

@end
