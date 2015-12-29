//
//  SelectFontsView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

//This class is used for selecting different fonts used in the application .This class is a subclass of UIView


#import <UIKit/UIKit.h>
#import "SelectFontCollectionViewCell.h"
#import "ZDStickerView.h"


@class SelectFontsView;
//Delegate Functions used for handling button actions in the SelectFontsView.

@protocol SelectFontsViewDelegate <NSObject>

@optional
-(void)select_font:(PagingCollectionView *)collectionView forCell:(SelectFontCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
-(void)setFont:(UIFont*)font onSelectedView:(ZDStickerView *)selected_view;
-(void)select_font_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectFontsView *)selected_view;

@end


@interface SelectFontsView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    
}
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)NSMutableArray *fonts_array;
@property(nonatomic,strong)id <SelectFontsViewDelegate> select_font_view_delegate;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;

@end
