//
//  ImageEditMainView.m
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ImageEditMainView.h"
#import "PECropView.h"

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
        self.image_edit_scroll_view =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.image_edit_scroll_view.delegate=self;
        self.image_edit_scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH, self.frame.size.height);
        self.image_edit_scroll_view.contentOffset=CGPointZero;
        [self addSubview:self.image_edit_scroll_view];
        
        self.main_image_view =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.main_image_view.image=self.selected_image;
        [self.main_image_view setContentMode:UIViewContentModeScaleAspectFit];
        
        self.image_edit_scroll_view.minimumZoomScale = 0.5;
        self.image_edit_scroll_view.maximumZoomScale = 6.0;
        self.image_edit_scroll_view.contentSize = self.main_image_view.frame.size;
        self.image_edit_scroll_view.delegate = self;
        
        
        [self.image_edit_scroll_view addSubview:self.main_image_view];
    }
    else
    {
        self.cropView = [[PECropView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.cropView.image = self.selected_image;
        self.cropView.keepingCropAspectRatio = NO;
        [self addSubview:self.cropView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.main_image_view;
}

@end
