//
//  ColorPaletteGradientView.h
//  TextBlend
//
//  Created by Itesh Dutt on 02/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectColorPaletteView.h"
@class ColorPaletteGradientView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol ColorPaletteGradientColorViewDelegate <NSObject>

@optional
-(void)setSelectedColorFromGradientView:(UIColor*)color onSelectedView:(ColorPaletteGradientView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view;
-(void)color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(ColorPaletteGradientView *)selected_view;

@end
@interface ColorPaletteGradientView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,DTColorPickerImageViewDelegate,UIGestureRecognizerDelegate,SelectColorPaletteViewDelegate>{
    
}
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)id <ColorPaletteGradientColorViewDelegate> color_palette_view_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)NSMutableArray *color_palette_array;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;
@property(nonatomic,strong)UIImageView *colorPreviewView;
@property(nonatomic,strong)SelectColorPaletteView *select_color_palette_view;
-(void)initializeArray;


@end


