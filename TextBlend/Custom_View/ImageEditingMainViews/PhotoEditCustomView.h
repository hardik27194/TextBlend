//
//  PhotoEditCustomView.h
//  TextBlend
//
//  Created by Wayne Rooney on 27/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoEditCustomView;

//Delegate Functions used for handling button actions in the PhotoEditCustomView.

@protocol PhotoEditToolOptionsDelegate <NSObject>

@optional

-(void)photo_edit_tool_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)crop_image_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)brightness_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)tone_curve_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)saturation_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)blur_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)contrast_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)exposure_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)blur_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view;


-(void)contrast_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)exposure_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)saturation_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)brightness_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view;
-(void)photo_edit_tone_curve_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view;

-(void)photo_edit_crop_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view;


@end


//This class consists of photo editing tools like crop,tone curve,blur effect,exposure,brightness,saturation and contrast.This class is a subclass of UIView


@interface PhotoEditCustomView : UIView<UIScrollViewDelegate>{
    
}
@property(nonatomic,strong)UIScrollView *image_edit_scroll_view;
@property(nonatomic,strong)CustomButton *crop_image_button;
@property(nonatomic,strong)CustomButton *tone_curve_button;
@property(nonatomic,strong)CustomButton *blur_button;
@property(nonatomic,strong)CustomButton *exposure_button;
@property(nonatomic,strong)CustomButton *brightness_button;
@property(nonatomic,strong)CustomButton *saturation_button;
@property(nonatomic,strong)CustomButton *contrast_button;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)UISlider *commonSlider;
@property(nonatomic,strong)UIView *SliderBackView;
@property(nonatomic,strong)UILabel *selected_button_label;
@property(nonatomic,assign)CGFloat photo_edit_crop_slider_value;
@property(nonatomic,assign)CGFloat photo_edit_tone_curve_slider_value;
@property(nonatomic,assign)CGFloat photo_edit_blur_slider_value;
@property(nonatomic,assign)CGFloat photo_edit_exposure_slider_value;
@property(nonatomic,assign)CGFloat photo_edit_brightness_slider_value;
@property(nonatomic,assign)CGFloat photo_edit_saturation_slider_value;
@property(nonatomic,assign)CGFloat photo_edit_contrast_slider_value;

@property(nonatomic,strong)id <PhotoEditToolOptionsDelegate> photo_edit_tool_options_delegate;

-(void)initializeWithDefaultValues;

@end


