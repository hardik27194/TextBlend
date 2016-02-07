//
//  TextToolsView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

//This class is used for changing text properties added on the selected image. This includes character spacing, line spacing, curve text and opacity. This class is a subclass of UIView


#import <UIKit/UIKit.h>

@class TextToolsView;
//Delegate Functions used for handling button actions in the TextToolsView.

@protocol TextToolsDelegate <NSObject>

@optional

-(void)opacity_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view;
-(void)curve_slider_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view;
-(void)character_spacing_slider_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view;
-(void)line_spacing_slider_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view;
-(void)text_tools_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(TextToolsView *)selected_view;

@end


@interface TextToolsView : UIView{
    
}
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong) UILabel *opacity_label;
@property(nonatomic,strong) UILabel *curve_label;
@property(nonatomic,strong) UILabel *character_spacing_label;
@property(nonatomic,strong) UILabel *line_spacing_label;
@property(nonatomic,strong)UISlider *opacity_slider;
@property(nonatomic,strong)UISlider *curve_slider;
@property(nonatomic,strong)UISlider *character_spacing_slider;
@property(nonatomic,strong)UISlider *line_spacing_slider;
@property(nonatomic,strong)id <TextToolsDelegate> text_tools_delegate;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;


-(void)initializeWithDefaultValues;


@end
