//
//  ImageCropperView.h
//  TextBlend
//
//  Created by Wayne on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

//This class is used for displaying all the differnt sizes in which the image can be cropped. This class is a subclass of UIView.


#import <UIKit/UIKit.h>
@class ImageCropperView;

@protocol ImageCropperDelegate <NSObject>

@optional
-(void)original_image_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)instagram_post_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)facebook_post_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)facebook_cover_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)twitter_post_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)iPhone4_wallpaper_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)	iPhone5_6_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void) ratio3X2_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)ratio4X3_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)ratio5X3_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)ratio16X9_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)ratio1X1_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)ratio3X5_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)ratio3X4_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;
-(void)ratio2X3_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view;

@end


@interface ImageCropperView : UIView<UIScrollViewDelegate>{
    
}
@property(nonatomic,strong)UIImageView *choose_image_size_view;

@property(nonatomic,strong)UIScrollView *scroll_view;
@property(nonatomic,strong)UIButton *original_image_button;
@property(nonatomic,strong)UIButton *instagram_post_button;
@property(nonatomic,strong)UIButton *facebook_post_button;
@property(nonatomic,strong)UIButton *facebook_cover_button;
@property(nonatomic,strong)UIButton *twitter_post_button;
@property(nonatomic,strong)UIButton *iPhone4_wallpaper_button;
@property(nonatomic,strong)UIButton *iPhone5_6_wallpaper_button;
@property(nonatomic,strong)UIButton *ratio_3X2_button;
@property(nonatomic,strong)UIButton *ratio_4X3_button;
@property(nonatomic,strong)UIButton *ratio_5X3_button;
@property(nonatomic,strong)UIButton *ratio_16X9_button;
@property(nonatomic,strong)UIButton *ratio_1X1_button;
@property(nonatomic,strong)UIButton *ratio_3X5_button;
@property(nonatomic,strong)UIButton *ratio_3X4_button;
@property(nonatomic,strong)UIButton *ratio_2X3_button;


@property(nonatomic,strong)id <ImageCropperDelegate> image_cropper_delegate;

@end
