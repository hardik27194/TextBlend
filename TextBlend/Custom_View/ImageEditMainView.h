//
//  ImageEditMainView.h
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropView.h"

//Image is displayed on this view after editing. However its core functionality is divided into number of views which are added on the main controller class. This class is a subclass of UIView.

@interface ImageEditMainView : UIView<UIScrollViewDelegate>{
    
}
@property(nonatomic,strong)UIScrollView *image_edit_scroll_view;
@property(nonatomic,strong)UIImageView *main_image_view;
@property(nonatomic,strong)UIImage *selected_image;
@property ( nonatomic ) BOOL hasSelectedImage;

@property (nonatomic, strong) PECropView *cropView;

-(void)initializeView;


@end
