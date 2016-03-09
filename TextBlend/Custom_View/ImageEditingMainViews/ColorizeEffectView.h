//
//  ColorizeEffectView.h
//  TextBlend
//
//  Created by Itesh Dutt on 09/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectColorPaletteView.h"
@class ColorizeEffectView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol ColorizeEffectDelegate <NSObject>

@optional
-(void)colorize_effect_set_image:(UIImage *)image onSelectedView:(ColorizeEffectView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view;
-(void)colorize_effect_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(ColorizeEffectView *)selected_view;

@end

@interface ColorizeEffectView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>{
    
}
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)id <ColorizeEffectDelegate> colorize_effect_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;
@property(nonatomic,strong)UIImage *original_image;
@end
