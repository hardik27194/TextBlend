//
//  ChooseShapeViewController.h
//  TextBlend
//
//  Created by Itesh Dutt on 26/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface ChooseShapeViewController : UIViewController<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,GADBannerViewDelegate>
{
    
}

@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)UIView *top_header_view;
@property(nonatomic,strong)UIButton *back_button;
@property(nonatomic,strong)UILabel *title_label;
@property(nonatomic,strong)UIButton *locked_button;
@property(nonatomic,strong)GADBannerView *adBannerView;
@property(nonatomic,strong)NSMutableArray *posts_array;

@end
