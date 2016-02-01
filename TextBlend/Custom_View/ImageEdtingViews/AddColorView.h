//
//  AddColorView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTColorPickerImageView.h"
@interface AddColorView : UIView<DTColorPickerImageViewDelegate>
{
    
}
@property(nonatomic,strong)UILabel *gradent_label;
@property(nonatomic,strong)UIView *gradent_view;
@property(nonatomic,strong)UIView *color_view;
@property(nonatomic,strong)UISlider *direction_slider;

@property(nonatomic,strong)UIColor *selected_color;
@property(nonatomic,strong)UILabel *selected_label;

-(void)updateGradientColors;
-(UIColor *)setGradientCOlor;
-(void)setText;

@end
