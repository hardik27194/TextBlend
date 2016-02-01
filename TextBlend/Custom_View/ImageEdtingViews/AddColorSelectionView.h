//
//  AddColorSelectionView.h
//  GradientColor
//
//  Created by Itesh Dutt on 24/01/16.
//  Copyright © 2016 Itesh Dutt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTColorPickerImageView.h"
#import "AddColorGradientView.h"
@interface AddColorSelectionView : UIView<UIGestureRecognizerDelegate,DTColorPickerImageViewDelegate>
{
    
}

@property(nonatomic,strong)UILabel *start_color_label;
@property(nonatomic,strong)UILabel *end_color_label;
@property(nonatomic,strong)UIImageView *center_pan_color_image_view;
@property(nonatomic,strong)AddColorGradientView *add_color_gradient_view;

@property(nonatomic,strong)DTColorPickerImageView *colorPreviewView;
@end
