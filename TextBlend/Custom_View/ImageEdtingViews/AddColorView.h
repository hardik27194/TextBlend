//
//  AddColorView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTColorPickerImageView.h"
@class AddColorView;
@class AddColorSelectionView;
@protocol AddColorViewDelegate <NSObject>

@optional
//-(void)select_font:(PagingCollectionView *)collectionView forCell:(SelectFontCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
//-(void)setFont:(UIFont*)font onSelectedView:(ZDStickerView *)selected_view;
//-(void)select_font_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectFontsView *)selected_view;
-(void)updateViewWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor withPercenatgeValue:(CGFloat)percentage onSelectedView:(AddColorView *)selected_view withCurrentDirection:(CGFloat)directionValue;
-(void)add_color_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(AddColorView *)selected_view;

@end


@interface AddColorView : UIView<DTColorPickerImageViewDelegate>
{
    
}
@property(nonatomic,strong)UILabel *gradent_label;
@property(nonatomic,strong)UIView *gradent_view;
@property(nonatomic,strong)UIView *color_view;
@property(nonatomic,strong)UISlider *direction_slider;

@property(nonatomic,strong)UIColor *selected_color;
@property(nonatomic,strong)UILabel *selected_label;
@property(nonatomic,strong)id <AddColorViewDelegate> add_color_view_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)DTColorPickerImageView *colorPreviewView;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;
@property(nonatomic,strong)AddColorSelectionView *color_selection_view;

-(void)updateGradientColors;
-(UIColor *)setGradientCOlor;
-(void)setText;
-(void)initializeWithDefaultValues;

@end
