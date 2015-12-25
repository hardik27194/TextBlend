//
//  InsertMessageTextView.h
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsertMessageTextView : UIView<UITextViewDelegate>
{
    
}
@property(nonatomic,strong)UITextView *message_text_view;
@property(nonatomic,strong)UILabel *count_label;
@property(nonatomic,strong)UIImageView *outer_image_view;
@end
