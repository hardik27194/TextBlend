//
//  EraserView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EraserView;

@protocol EraserDelegate <NSObject>

@optional
-(void)eraser_size_slider_value_changed:(UISlider *)slider onSelectedView:(EraserView *)selected_view;
-(void)eraser_intensity_slider_value_changed:(UISlider *)slider onSelectedView:(EraserView *)selected_view;
-(void)eraser_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(EraserView *)selected_view;
-(void)undo_last_erase_button_pressed:(UIButton *)sender onSelectedView:(EraserView *)selected_view;

@end
@interface EraserView : UIView{
    
}
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong) UILabel *eraser_label;
@property(nonatomic,strong) UILabel *intensity_label;

@property(nonatomic,strong)UISlider *opacity_slider;
@property(nonatomic,strong)UISlider *curve_slider;
@property(nonatomic,strong)UISlider *eraser_size_slider;
@property(nonatomic,strong)UISlider *intensity_slider;
@property(nonatomic,strong)UIButton *undo_last_erase_button;

@property(nonatomic,strong)id <EraserDelegate> eraser_delegate;

@end
