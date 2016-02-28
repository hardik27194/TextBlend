//
//  ShadowCustomView.h
//  TextBlend
//
//  Created by Itesh Dutt on 18/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShadowCustomView;
//Delegate Functions used for handling button actions in the ShadowCustomView.

@protocol ShadowToolsDelegate <NSObject>

@optional

-(void)opacity_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view;
-(void)blur_radius_slider_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view;
-(void)x_position_slider_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view;
-(void)y_position_slider_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view;
-(void)shadow_tools_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(ShadowCustomView *)selected_view;
-(void)shadow_tools_color_selection:(UIColor *)selected_color onSelectedView:(ShadowCustomView *)selected_view;


@end

@interface ShadowCustomView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    
}
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong) UILabel *opacity_label;
@property(nonatomic,strong) UILabel *blur_radius_label;
@property(nonatomic,strong) UILabel *x_position_label;
@property(nonatomic,strong) UILabel *y_position_label;
@property(nonatomic,strong)UISlider *opacity_slider;
@property(nonatomic,strong)UISlider *blur_radius_slider;
@property(nonatomic,strong)UISlider *x_position_slider;
@property(nonatomic,strong)UISlider *y_position_slider;
@property(nonatomic,strong)id <ShadowToolsDelegate> shadow_tools_delegate;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;

@property(nonatomic,strong)NSMutableArray *color_palette_array;
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;

-(void)initializeWithDefaultValues;

@end
