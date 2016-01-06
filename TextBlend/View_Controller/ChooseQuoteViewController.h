//
//  ChooseQuoteViewController.h
//  TextBlend
//
//  Created by Itesh Dutt on 06/01/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

#import "ChooseOptionCustomView.h"


@interface ChooseQuoteViewController : UIViewController<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,GADBannerViewDelegate,UIGestureRecognizerDelegate,ChooseOptionDelegate>{
    ChooseOptionCustomView *choose_option_view;

}
@property(nonatomic,strong)UIScrollView *main_scroll_view;

@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)UIView *top_header_view;
@property(nonatomic,strong)UIButton *back_button;
@property(nonatomic,strong)UILabel *title_label;
@property(nonatomic,strong)UIButton *locked_button;
@property(nonatomic,strong)GADBannerView *adBannerView;
@property(nonatomic,strong)NSMutableArray *posts_array;
@end
