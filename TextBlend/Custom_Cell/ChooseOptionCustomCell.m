//
//  ChooseOptionCustomCell.m
//  TextBlend
//
//  Created by Wayne Rooney on 27/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ChooseOptionCustomCell.h"

@implementation ChooseOptionCustomCell
@synthesize icon_image_view,name_text_label,locked_image_view;
@synthesize liner_image_view;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
