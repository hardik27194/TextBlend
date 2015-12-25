//
//  SelectImageBackgroundViewController.h
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectBackgroundCollectionViewCell.h"
#import "CustomizeImageViewController.h"
#import "ImageCropperViewController.h"
@interface SelectImageBackgroundViewController : UIViewController<PagingCollectionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImage *selected_image;
    
}
@property(nonatomic,strong)UIView *main_view;
@property(nonatomic,strong)UIView *top_header_view;
@property(nonatomic,strong)UIButton *cancel_button;
@property(nonatomic,strong)UIButton *camera_roll_button;
@property(nonatomic,strong)UIImageView *background_logo_image_view;
@property(nonatomic,strong)UIButton *choose_from_camera_roll_button;
@property(nonatomic,strong)UIView *bottom_view;

@property(nonatomic,strong)PagingCollectionView *custom_collection_view;
@property(nonatomic,strong)NSMutableArray *posts_array;


@end
