//
//  Rotate3DView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Rotate3DView;
@protocol Rotate3DDelegate <NSObject>

@optional
-(void)rotate_3d_intensity_slider_value_changed:(UISlider *)slider onSelectedView:(Rotate3DView *)selected_view;
-(void)rotate_3d_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(Rotate3DView *)selected_view;
-(void)reset_3d_rotate_button_pressed:(UIButton *)sender onSelectedView:(Rotate3DView *)selected_view;

@end
@interface Rotate3DView : UIView{
    
}
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong) UIImageView *info_text_image_view;
@property(nonatomic,strong)UISlider *intensity_slider;
@property(nonatomic,strong)UIButton *reset_3d_rotate_button;
@property(nonatomic,strong)id <Rotate3DDelegate> rotate_3d_delegate;
@end
