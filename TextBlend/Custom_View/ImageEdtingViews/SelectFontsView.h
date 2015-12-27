//
//  SelectFontsView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectFontCollectionViewCell.h"
#import "ZDStickerView.h"
@class SelectFontsView;

@protocol SelectFontsViewDelegate <NSObject>

@optional
-(void)select_font:(PagingCollectionView *)collectionView forCell:(SelectFontCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
-(void)setFont:(UIFont*)font onSelectedView:(ZDStickerView *)selected_view;
@end
@interface SelectFontsView : UIView<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    
}
@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)NSMutableArray *fonts_array;
//@property(nonatomic,strong)CGFloat font_size;

@property(nonatomic,strong)id <SelectFontsViewDelegate> select_font_view_delegate;

//select_font_view_delegate
@end
