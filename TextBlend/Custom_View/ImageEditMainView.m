//
//  ImageEditMainView.m
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ImageEditMainView.h"
#import "PECropView.h"
#import "UIImage+PECrop.h"

@implementation ImageEditMainView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}


-(void)initializeView
{
    if(self.hasSelectedImage)
    {
        
        self.main_image_view =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.main_image_view.image=self.selected_image;
        [self.main_image_view setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.main_image_view];
    }
    else
    {
        //Create image scroll.
        self.image_edit_scroll_view =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.image_edit_scroll_view.minimumZoomScale = 1.0;
        self.image_edit_scroll_view.maximumZoomScale = 3.0;
        self.image_edit_scroll_view.contentSize = self.main_image_view.frame.size;
        self.image_edit_scroll_view.delegate = self;
//        [self addSubview:self.image_edit_scroll_view];

        self.main_image_view  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.selected_image.size.width, self.selected_image.size.height)];
        [self.main_image_view setImage:self.selected_image];
        self.image_edit_scroll_view.contentSize= self.main_image_view.frame.size;
        [self.image_edit_scroll_view setClipsToBounds:NO];
//        [self.image_edit_scroll_view addSubview:self.main_image_view];
        [self addSubview:self.main_image_view];
        
        self.topOverlayView = [[UIView alloc] init];
        self.topOverlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        [self addSubview:self.topOverlayView];
        
        
        
        self.leftOverlayView = [[UIView alloc] init];
        self.leftOverlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        [self addSubview:self.leftOverlayView];
        
        
        
        self.rightOverlayView = [[UIView alloc] init];
        self.rightOverlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        [self addSubview:self.rightOverlayView];
        
        
        
        
        self.bottomOverlayView = [[UIView alloc] init];
        self.bottomOverlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        [self addSubview:self.bottomOverlayView];
        
        
        
        if(self.main_image_view.frame.size.height > self.main_image_view.frame.size.width)
        {
            // Height > Width
            if(self.frame.size.height > self.main_image_view.frame.size.height)
            {
                CGRect rect;
                rect.size.height = self.main_image_view.frame.size.height;
                rect.size.width = rect.size.height * self.main_image_view.frame.size.width/self.main_image_view.frame.size.height;
                rect.origin.x = (self.frame.size.width - rect.size.width)/2;
                rect.origin.y = (self.frame.size.height - rect.size.height)/2;
                [self.main_image_view setFrame:rect];
                [self layoutOverlayViewsWithCropRect:rect];
                
            }
            else
            {
                CGRect rect;
                rect.size.height = self.frame.size.height;
                rect.size.width = rect.size.height * self.main_image_view.frame.size.width/self.main_image_view.frame.size.height;
                rect.origin.x = (self.frame.size.width - rect.size.width)/2;
                rect.origin.y = (self.frame.size.height - rect.size.height)/2;
                [self.main_image_view setFrame:rect];
                [self layoutOverlayViewsWithCropRect:rect];
                
            }
        }
        else
        {
            // Image Width >Image Height
            if(self.frame.size.width > self.main_image_view.frame.size.width)
            {
                CGRect rect;
                rect.size.width = self.main_image_view.frame.size.width;
                rect.size.height = rect.size.width * self.main_image_view.frame.size.height/self.main_image_view.frame.size.width;
                rect.origin.x = (self.frame.size.width - rect.size.width)/2;
                rect.origin.y = (self.frame.size.height - rect.size.height)/2;
                [self.main_image_view setFrame:rect];
                [self layoutOverlayViewsWithCropRect:rect];
                
            }
            else
            {
                CGRect rect;
                rect.size.width = self.frame.size.width;
                rect.size.height = rect.size.width * self.main_image_view.frame.size.height/self.main_image_view.frame.size.width;
                rect.origin.x = (self.frame.size.width - rect.size.width)/2;
                rect.origin.y = (self.frame.size.height - rect.size.height)/2;
                [self.main_image_view setFrame:rect];
                [self.main_image_view setBackgroundColor:[UIColor whiteColor]];
                [self layoutOverlayViewsWithCropRect:rect];
            }
        }
    }
}

- (void)layoutOverlayViewsWithCropRect:(CGRect)cropRect
{
    self.cropRectView = cropRect;
    [self.image_edit_scroll_view setFrame:cropRect];
    [self.image_edit_scroll_view setContentSize:self.main_image_view.frame.size];
    [self.image_edit_scroll_view scrollRectToVisible:CGRectMake(self.image_edit_scroll_view.center.x-self.image_edit_scroll_view.frame.size.width/2, self.image_edit_scroll_view.center.y-self.image_edit_scroll_view.frame.size.height/2, self.image_edit_scroll_view.frame.size.width, self.image_edit_scroll_view.frame.size.height) animated:NO];
    
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.topOverlayView.frame = CGRectMake(0.0f,
                                               0.0f,
                                               CGRectGetWidth(self.bounds),
                                               CGRectGetMinY(cropRect));
        self.leftOverlayView.frame = CGRectMake(0.0f,
                                                CGRectGetMinY(cropRect),
                                                CGRectGetMinX(cropRect),
                                                CGRectGetHeight(cropRect));
        self.rightOverlayView.frame = CGRectMake(CGRectGetMaxX(cropRect),
                                                 CGRectGetMinY(cropRect),
                                                 CGRectGetWidth(self.bounds) - CGRectGetMaxX(cropRect),
                                                 CGRectGetHeight(cropRect));
        self.bottomOverlayView.frame = CGRectMake(0.0f,
                                                  CGRectGetMaxY(cropRect),
                                                  CGRectGetWidth(self.bounds),
                                                  CGRectGetHeight(self.bounds) - CGRectGetMaxY(cropRect));
    } completion:NULL];
    
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.main_image_view;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGSize imgViewSize = self.main_image_view.frame.size;
    CGSize imageSize = self.main_image_view.image.size;
    
    CGSize realImgSize;
    if(imageSize.width / imageSize.height > imgViewSize.width / imgViewSize.height) {
        realImgSize = CGSizeMake(imgViewSize.width, imgViewSize.width / imageSize.width * imageSize.height);
    }
    else {
        realImgSize = CGSizeMake(imgViewSize.height / imageSize.height * imageSize.width, imgViewSize.height);
    }
    
    CGRect fr = CGRectMake(0, 0, 0, 0);
    fr.size = realImgSize;
    self.main_image_view.frame = fr;
    
    CGSize scrSize = scrollView.frame.size;
    //    float offx = (scrSize.width > realImgSize.width ? (scrSize.width - realImgSize.width) / 2 : 0);
    
    
    
    float offx;
    float offy;
    
    if(scrSize.width > realImgSize.width)
    {
        offx = (scrSize.width - realImgSize.width) / 2;
    }
    else
    {
        offx = (realImgSize.width - scrSize.width) / 2;
    }
    
    if(scrSize.height > realImgSize.height)
    {
        offy = (scrSize.height - realImgSize.height) / 2;
    }
    else
    {
        offy = (realImgSize.height - scrSize.height) / 2;
    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
//    scrollView.contentInset = UIEdgeInsetsMake(offy, offx, offy, offx);
    [scrollView setContentSize:imgViewSize];
    
    [UIView commitAnimations];
}

@end
