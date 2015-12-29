//
//  ChooseOptionCustomCell.h
//  TextBlend
//
//  Created by Wayne Rooney on 27/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//


//This view will used for selecting given set of options. This class is a subclass of UITableViewCell


#import <UIKit/UIKit.h>

@interface ChooseOptionCustomCell : UITableViewCell
{
    
}
@property(nonatomic,strong)UIImageView *icon_image_view;
@property(nonatomic,strong)UILabel *name_text_label;
@property(nonatomic,strong)UIImageView *locked_image_view;
@property(nonatomic,strong)UIImageView *liner_image_view;

@end
