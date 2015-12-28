//
//  PhotoEditCustomView.h
//  TextBlend
//
//  Created by Wayne Rooney on 27/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoEditCustomView;

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








@end
@interface PhotoEditCustomView : UIView<UIScrollViewDelegate>
{
    
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

@property(nonatomic,strong)id <PhotoEditToolOptionsDelegate> photo_edit_tool_options_delegate;


@end


