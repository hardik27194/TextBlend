//
//  MyView.m
//  LabelDemo
//
//  Created by Hemang on 09/11/13.
//  Copyright (c) 2013 Space-O. All rights reserved.
//

#import "MyView.h"



@implementation MyView

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        checkBack = NO;
//        self.imgBack = [[UIImageView alloc] init];
//        self.imgBack.image = [UIImage imageNamed:@"image1.jpg"];
//        self.imgBack.frame = self.frame;
//        [self addSubview:self.imgBack];
    }
    return self;
}

+ (UIImage *) setImage:(UIImage *)image withAlpha:(CGFloat)alpha{
    
    // Create a pixel buffer in an easy to use format
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UInt8 * m_PixelBuf = malloc(sizeof(UInt8) * height * width * 4);
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(m_PixelBuf, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    //alter the alpha
    NSInteger length = height * width * 4;
    for (int i=0; i<length; i+=4)
    {
        m_PixelBuf[i+3] =  255*alpha;
    }
    
    
    //create a new image
    CGContextRef ctx = CGBitmapContextCreate(m_PixelBuf, width, height,
                                             bitsPerComponent, bytesPerRow, colorSpace,
                                             kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGImageRef newImgRef = CGBitmapContextCreateImage(ctx);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(ctx);
    free(m_PixelBuf);
    
    UIImage *finalImage = [UIImage imageWithCGImage:newImgRef];
    CGImageRelease(newImgRef);
    
    return finalImage;
}

- (void)drawRect:(CGRect)rect {
    
    if(SharedObj.isFromBackPicture){
            UIImage *img = SharedObj.imageBackground;
    //        UIImage *new = [img imageWithAlpha:kAppDelegate.colorAlpha];
        
        CGContextSaveGState(UIGraphicsGetCurrentContext());
            CGContextSetFillColorWithColor( UIGraphicsGetCurrentContext(), [UIColor colorWithPatternImage:img].CGColor);
        CGContextSetAlpha(UIGraphicsGetCurrentContext(), kAppDelegate.colorAlpha);
            CGContextFillRect(UIGraphicsGetCurrentContext(), rect );
        
        
         //   CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, img.CGImage);
        img = nil;
       // [new drawInRect:rect];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
        
    
    }else{
        CGContextSetFillColorWithColor( UIGraphicsGetCurrentContext(), [UIColor colorWithRed:kAppDelegate.R_background green:kAppDelegate.G_background blue:kAppDelegate.B_background alpha:kAppDelegate.colorAlpha].CGColor);
        CGContextFillRect( UIGraphicsGetCurrentContext(), rect );
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 1.0);
    /*
    for (UIView * v in [self subviews]) {
        if([v isKindOfClass:[OHAttributedLabel class]]){
            OHAttributedLabel *lbl = (OHAttributedLabel*)v;
            
            CGContextSaveGState(context);
            
            
            CGFloat halfWidth = CGRectGetWidth(lbl.frame) / 2.0;
            CGFloat halfHeight = CGRectGetHeight(lbl.frame)  / 2.0;
            CGPoint center = CGPointMake(CGRectGetMinX(lbl.frame) + halfWidth, CGRectGetMinY(lbl.frame)  + halfHeight);
            
            CGFloat radians = atan2f(lbl.transform.b, lbl.transform.a);
            
            // Move to the center of the rectangle:
            CGContextSetBlendMode(context, kCGBlendModeCopy);
            CGContextTranslateCTM(context, center.x, center.y);
            // Rotate:
            CGContextRotateCTM(context, radians);
            CGContextScaleCTM(context, 1.0, -1.0);
            // Draw the rectangle centered about the center:
            CGRect arect ;
            arect = CGRectMake(-CGRectGetWidth(lbl.bounds) / 2.0, -CGRectGetHeight(lbl.bounds)  / 2.0, CGRectGetWidth(lbl.bounds) , CGRectGetHeight(lbl.bounds));
            
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            CGPathAddRect(path, NULL,arect);
            
          
            
           // CGContextAddRect(context, arect);
           // CGContextStrokePath(context);
            
            // Draw the text
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)lbl.attributedText);
            CTFrameRef theFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, lbl.attributedText.length), path, NULL);
            CTFrameDraw(theFrame, context);
            
            CGContextRestoreGState(context);
            // Clean up
            CFRelease(framesetter);
            CFRelease(path);
            CFRelease(theFrame);
        }
        
        
    }*/
    for (UIView * v in [self subviews]) {
        if([v isKindOfClass:[ZDStickerView class]]){
            
            ZDStickerView *zz = (ZDStickerView*)v;
           // for(UIView *v in zz.subviews){
            //    if([v isKindOfClass:[OHAttributedLabel class]]){
                    OHAttributedLabel *lbl = (OHAttributedLabel*)zz.contentView1;
            
                CGContextSaveGState(context);
                
                
                CGFloat halfWidth = CGRectGetWidth(zz.frame) / 2.0;
                CGFloat halfHeight = CGRectGetHeight(zz.frame)  / 2.0;
                CGPoint center = CGPointMake(CGRectGetMinX(zz.frame) + halfWidth, CGRectGetMinY(zz.frame)  + halfHeight);
                
                CGFloat radians = atan2f(zz.transform.b, zz.transform.a);
                
                
                
                
                // Move to the center of the rectangle:
                CGContextSetBlendMode(context, kCGBlendModeCopy);
                CGContextTranslateCTM(context, center.x, center.y);
                // Rotate:
                CGContextRotateCTM(context, radians);
                
                CATransform3D flipVertical = lbl.layer.transform;
                CGAffineTransform transform = CGAffineTransformMake(flipVertical.m11, flipVertical.m12, flipVertical.m21, flipVertical.m22, flipVertical.m41, flipVertical.m42);
                CGContextConcatCTM(context,transform);
                
                CGContextScaleCTM(context, 1.0, -1.0);
                
                
                
                // Draw the rectangle centered about the center:
                CGRect arect ;
                arect = CGRectMake(-CGRectGetWidth(zz.bounds) / 2.0, -CGRectGetHeight(zz.bounds)  / 2.0, CGRectGetWidth(zz.bounds) , CGRectGetHeight(zz.bounds));
                
                CGMutablePathRef path = CGPathCreateMutable();
                
                
                
                CGPathAddRect(path, NULL,arect);
                
                // Draw the text
                CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)lbl.attributedText);
                CTFrameRef theFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, lbl.attributedText.length), path, NULL);
                if(!lbl.isIn3DMode){
                    CTFrameDraw(theFrame, context);
                }
            
            
                CGContextRestoreGState(context);
                
                // Clean up
            
            if (framesetter) {
                CFRelease(framesetter);

            }
            if (path) {
                CFRelease(path);
 
            }
            if (theFrame) {
                CFRelease(theFrame);

            }
            
            
            
          //      }
        //    }
            
        }
    }

   
}



@end
