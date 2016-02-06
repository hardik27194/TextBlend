//
//  SelectColorPaletteView.h
//  TextBlend
//
//  Created by Itesh Dutt on 06/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColorPaletteView;

@class SelectColorPaletteView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol SelectColorPaletteViewDelegate <NSObject>

@optional
-(void)setSelectedColorFromSelectColorPaletteView:(UIColor*)color onSelectedView:(SelectColorPaletteView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view;
-(void)select_color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectColorPaletteView *)selected_view;

@end

@interface SelectColorPaletteView : UIView<DTColorPickerImageViewDelegate>{
    
}
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)DTColorPickerImageView *colorPreviewView;
@property(nonatomic,strong)id <SelectColorPaletteViewDelegate> select_color_palette_delegate;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;

//
@end
