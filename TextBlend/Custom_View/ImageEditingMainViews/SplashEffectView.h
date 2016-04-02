//
//  SplashEffectView.h
//  TextBlend
//
//  Created by Itesh Dutt on 17/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectColorPaletteView.h"
#import "UIImage+Utility.h"
@class SplashEffectView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol SplashEffectDelegate <NSObject>

@optional
-(void)splash_effect_set_image:(UIImage *)image onSelectedView:(SplashEffectView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view;
-(void)splash_effect_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SplashEffectView *)selected_view;

@end@interface SplashEffectView : UIView{
    
}

@property(nonatomic,strong)id <SplashEffectDelegate> splash_effect_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;
@property(nonatomic,strong)UIImage *original_image;
@property(nonatomic,strong)UISlider *radiusSlider;
@property(nonatomic,strong)UISlider *widthSlider;

-(void)setUp;

@end
