//
//  FXEffectView.h
//  TextBlend
//
//  Created by Itesh Dutt on 14/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectColorPaletteView.h"
#import "FXEffectSubSelectedView.h"
@class FXEffectView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol FXEffectDelegate <NSObject>

@optional
-(void)fx_effect_set_image:(UIImage *)image onSelectedView:(FXEffectView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view;
-(void)fx_effect_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(FXEffectView *)selected_view;

@end
@interface FXEffectView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,FXEffectSubSelectedDelegate>{
    
}
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)NSMutableArray *custom_array;

@property(nonatomic,strong)id <FXEffectDelegate> fx_effect_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;
@property(nonatomic,strong)UIImage *original_image;
@end



