//
//  PagingCollectionFlowLayout.m
//  ScrollableCollectionViewTable
//
//  Created by Wayne Rooney on 9/7/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//

#import "PagingCollectionFlowLayout.h"

@implementation PagingCollectionFlowLayout

-(id)init{
  
  if (self==[super init]) {
  
    self.minimumInteritemSpacing=12;
    self.minimumLineSpacing=20;
    self.itemSize=CGSizeMake(50 , 50);
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
  }
  return self;
  
}

@end
