//
//  FilterEffectCustomView.h
//  TextBlend
//
//  Created by Itesh Dutt on 12/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectColorPaletteView.h"
@class FilterEffectCustomView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol FilterEffectDelegate <NSObject>

@optional
-(void)filter_effect_set_image:(UIImage *)image onSelectedView:(FilterEffectCustomView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view;
-(void)filter_effect_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(FilterEffectCustomView *)selected_view;

@end

@interface FilterEffectCustomView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>{
    
}
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)NSMutableArray *custom_array;

@property(nonatomic,strong)id <FilterEffectDelegate> filter_effect_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;
@property(nonatomic,strong)UIImage *original_image;
@end


