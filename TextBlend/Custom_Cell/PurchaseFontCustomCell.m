//
//  PurchaseFontCustomCell.m
//  TextBlend
//
//  Created by Itesh Dutt on 10/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "PurchaseFontCustomCell.h"

@implementation PurchaseFontCustomCell
@synthesize name_label,fonts_label,font_amount_button,main_image_view;
@synthesize scroll_to_top_button;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
