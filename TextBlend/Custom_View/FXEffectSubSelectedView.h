//
//  FXEffectSubSelectedView.h
//  TextBlend
//
//  Created by Itesh Dutt on 15/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectColorPaletteView.h"
@class FXEffectSubSelectedView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol FXEffectSubSelectedDelegate <NSObject>

@optional
-(void)fx_effect_sub_view_set_image:(UIImage *)image onSelectedView:(FXEffectSubSelectedView  *)selected_view ;
-(void)fx_effect_sub_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(FXEffectSubSelectedView *)selected_view;

@end

@interface FXEffectSubSelectedView : UIView<UIGestureRecognizerDelegate>{
    }

@property(nonatomic,strong)id <FXEffectSubSelectedDelegate> fx_effect_sub_selected_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)UIImage *original_image;
@property(nonatomic,strong)NSString *selected_fx_filter_string;
@property(nonatomic,strong)UISlider *slider_1;
@property(nonatomic,strong)UISlider *slider_2;

-(void)initializeSelectedView;

@end
