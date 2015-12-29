//
//  PagingCollectionView.h
//  TextBlend
//
//  Created by Wayne Rooney on 9/8/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//
/*
 
 Class for implementing the custom collection view for pagination.It is a sub class of UICollectionView.
 */

#import <UIKit/UIKit.h>
@protocol PagingCollectionDelegate<UICollectionViewDelegateFlowLayout>

@optional

-(void)collectionView :(UICollectionView *)collection_view didReachEndOfPage:(int)page;

@end
@interface PagingCollectionView : UICollectionView<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>{
  
}
@property(unsafe_unretained) id pagingCollectionDelegate;
@property(nonatomic,assign)int selectedPageNumber;
@property(nonatomic,assign)BOOL pageLocked;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)long remaining_records;

-(void)setUpCollectionInitParms;


@end
