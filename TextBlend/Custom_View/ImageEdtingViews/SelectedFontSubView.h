//
//  SelectedFontSubView.h
//  TextBlend
//
//  Created by Itesh Dutt on 11/01/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectFontCollectionViewCell.h"
#import "ZDStickerView.h"

@class SelectedFontSubView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol SelectSubFontsViewDelegate <NSObject>

@optional
-(void)select_sub_font:(PagingCollectionView *)collectionView forCell:(SelectFontCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
-(void)setSelectedFont:(UIFont*)font onSelectedView:(SelectedFontSubView  *)selected_view;
-(void)select_sub_font_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectedFontSubView *)selected_view;

@end

@interface SelectedFontSubView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    
}
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)id <SelectSubFontsViewDelegate> select_sub_font_view_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)NSMutableDictionary *selected_dict;

@property(nonatomic,strong)NSMutableArray *selected_sub_font_array;
@property(nonatomic,strong)ZDStickerView *selected_sticker_view;


@property(nonatomic,strong)UIButton *done_check_mark_button;
-(void)initializeArray;

@end
