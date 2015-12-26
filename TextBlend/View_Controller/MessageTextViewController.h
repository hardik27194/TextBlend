//
//  MessageTextViewController.h
//  TextBlend
//
//  Created by Itesh Dutt on 26/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStickerView.h"
#import "CustomizeImageTopHeaderView.h"

@interface MessageTextViewController : UIViewController<UITextViewDelegate,CustomizeImageHeaderButtonsDelegate>
{
    
}
@property(nonatomic,strong)CustomizeImageTopHeaderView *top_header_view;

@property(nonatomic,strong)UITextView *message_text_view;
@property(nonatomic,strong)UILabel *count_label;
@property(nonatomic,strong)UIImageView *outer_image_view;
@property(nonatomic,strong)ZDStickerView * custom_sticker;
@end

