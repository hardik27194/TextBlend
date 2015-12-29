//
//  MessageTextViewController.h
//  TextBlend
//
//  Created by Wayne Rooney on 26/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

//This class is used for inserting text which will be added in the sticker view. This class is a subclass of UIViewController.

#import <UIKit/UIKit.h>
#import "ZDStickerView.h"
#import "CustomizeImageTopHeaderView.h"
#import "DTColorPickerImageView.h"

@interface MessageTextViewController : UIViewController<UITextViewDelegate,CustomizeImageHeaderButtonsDelegate,DTColorPickerImageViewDelegate>
{
    UIColor *selected_color;
}
@property(nonatomic,strong)CustomizeImageTopHeaderView *top_header_view;

@property(nonatomic,strong)UITextView *message_text_view;
@property(nonatomic,strong)UILabel *count_label;
@property(nonatomic,strong)UIImageView *outer_image_view;
@property(nonatomic,strong)ZDStickerView * custom_sticker;
@property(nonatomic,strong)UIView *black_view;
@property(nonatomic,strong)UIButton * done_check_mark_button;
@property(nonatomic,strong)UIButton * select_color_button;
@property(nonatomic,strong)UIButton * left_text_alignment_button;
@property(nonatomic,strong)UIButton * center_text_alignment_button;
@property(nonatomic,strong)UIButton * right_text_alignment_button;
@property(nonatomic,strong)    DTColorPickerImageView *colorPreviewView;

@end

