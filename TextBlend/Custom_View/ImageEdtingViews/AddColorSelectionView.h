//
//  AddColorSelectionView.h
//  GradientColor
//
//  Created by Itesh Dutt on 24/01/16.
//  Copyright © 2016 Itesh Dutt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTColorPickerImageView.h"
#import "AddColorView.h"

@class AddColorSelectionView;

@protocol AddColorSelectionViewDelegate <NSObject>

@optional
-(void)add_color_selection_subview_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(AddColorSelectionView *)selected_view;

@end


@interface AddColorSelectionView : UIView<UIGestureRecognizerDelegate,DTColorPickerImageViewDelegate>
{
    
}

@property(nonatomic,strong)UILabel *start_color_label;
@property(nonatomic,strong)UILabel *end_color_label;
@property(nonatomic,strong)UIImageView *center_pan_color_image_view;
@property(nonatomic,strong)AddColorView *add_color_gradient_view;
@property(nonatomic,strong)id <AddColorSelectionViewDelegate> add_color_selection_view_delegate;


@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton *done_check_mark_button;
-(void)updateBufferImageViewColors;

@end
