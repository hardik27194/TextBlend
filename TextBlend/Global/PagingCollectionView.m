//
//  PagingCollectionView.m
//  ScrollCollectionView
//
//  Created by Wayne Rooney on 9/8/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//

#import "PagingCollectionView.h"

@implementation PagingCollectionView
@synthesize pagingCollectionDelegate;
@synthesize selectedPageNumber,pageLocked,pageSize,remaining_records;;

#pragma matk Scrolling Delegate
-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
  if (self=[super initWithFrame:frame collectionViewLayout:layout]) {
    self.delegate=self;
    
  }
  return self;
  
}

-(void)setUpCollectionInitParms{
    self.selectedPageNumber = 1;
    
    self.pageSize = 20;

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  
  if([self.pagingCollectionDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
    [self.pagingCollectionDelegate scrollViewDidEndDragging:self willDecelerate:decelerate];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  //NSIndexPath *indexPath=[self indexPathForSelectedRow];
  if([self.pagingCollectionDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
    [self.pagingCollectionDelegate scrollViewDidScroll:self];
  NSArray *paths = [self indexPathsForVisibleItems];
  for (NSIndexPath *path in paths) {
    ////NSLog(@"%d",path.row);
    //if(path.row==[self.dataSource tableView:self numberOfRowsInSection:indexPath.section] &&!pageLocked){
    
    ////NSLog(@"%d",path.row);
    NSLog(@"%ld",[self.dataSource collectionView:self numberOfItemsInSection:path.section]);
    NSLog(@"%ld",path.row);
    //if(path.row== [self.dataSource tableView:self numberOfRowsInSection:path.section]-1 &&!pageLocked){
    if(path.row== [self.dataSource collectionView:self numberOfItemsInSection:path.section]-1  && path.section == [self.dataSource numberOfSectionsInCollectionView:self]-1){
      
      //NSLog(@"REACHED END");
      //if(self.selectedPageNumber<self.total_pages) {
      //   if(self.remaining_records>0) {
      
            if([self.pagingCollectionDelegate respondsToSelector:@selector(collectionView:didReachEndOfPage:)])
        [self.pagingCollectionDelegate collectionView:self didReachEndOfPage:1];
      
      // [self.pagingDelegate tableView:self didReachEndOfPage:self.selectedPageNumber];
      //  }
      break;
    }
  }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return [self.pagingCollectionDelegate collectionView:self layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
  
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
  return [self.pagingCollectionDelegate collectionView:self layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
  
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
  return [self.pagingCollectionDelegate collectionView:self layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
  
}


@end
