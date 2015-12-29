//
//  RecentListingCollectionViewCell.h
//  TextBlend
//
//  Created by Wayne Rooney on 19/12/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//

//This view will used for displaying background image and list the name. This class is a subclass of UICollectionViewCell

#import <UIKit/UIKit.h>

@interface RecentListingCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *listingImageView;
@property (strong, nonatomic) IBOutlet UILabel *listingCollectionName;


@end
