//
//  ImageCropperViewController.h
//  TextBlend
//
//  Created by Wayne on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//
/*
 This class is used for displaying all the differnt sizes in which the image can be cropped. This class is a subclass of ImageCropperViewController.
*/
#import <UIKit/UIKit.h>
#import "ImageCropperView.h"
#import "ImageEditingOptionsView.h"
#import "CustomizeImageTopHeaderView.h"
#import "ImageEditMainView.h"
#import "CustomizeImageViewController.h"
@import GoogleMobileAds;



@interface ImageCropperViewController : UIViewController<GADBannerViewDelegate,UIScrollViewDelegate,CustomizeImageHeaderButtonsDelegate,ImageCropperDelegate>

{
    
}
@property(nonatomic,strong)UIScrollView *scroll_view;
@property(nonatomic,strong)ImageCropperView *image_cropper_view;
@property(nonatomic,strong)UIImage *selected_image;
@property(nonatomic,strong)CustomizeImageTopHeaderView *top_header_view;
@property(nonatomic,strong)GADBannerView *adBannerView;
@property(nonatomic,strong)ImageEditMainView *image_edit_main_view;

-(void)initializeView;
//-(void)initializeMainImageView;
//-(void)initializeChooseCropperView;
-(void)initializeAdbannerView;

@end
