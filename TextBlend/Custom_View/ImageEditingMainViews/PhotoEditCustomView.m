//
//  PhotoEditCustomView.m
//  TextBlend
//
//  Created by Wayne Rooney on 27/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "PhotoEditCustomView.h"

@implementation PhotoEditCustomView
@synthesize image_edit_scroll_view,crop_image_button,tone_curve_button,blur_button,exposure_button,brightness_button,saturation_button,contrast_button,photo_edit_tool_options_delegate;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}



-(void)initializeView{
    
    self.image_edit_scroll_view =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    self.image_edit_scroll_view.delegate=self;
    self.image_edit_scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    self.image_edit_scroll_view.contentOffset=CGPointZero;
    [self addSubview:self.image_edit_scroll_view];
    
    int width_buttons = 0;
    //int height_origin_button = 0;

    self.crop_image_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.crop_image_button.frame=CGRectMake(width_buttons,0, SCREEN_WIDTH/4, self.frame.size.height/2);
    [self.crop_image_button setImage:[UIImage imageNamed:@"photo_edit_tool_crop.png"] forState:UIControlStateNormal];
    
    [self.crop_image_button addTarget:self action:@selector(crop_image_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.crop_image_button];
    
    
    
    self.brightness_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.brightness_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/4, self.frame.size.height/2);
    [self.brightness_button setImage:[UIImage imageNamed:@"photo_edit_tool_brightness.png"] forState:UIControlStateNormal];
    [self.brightness_button addTarget:self action:@selector(brightness_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.brightness_button];

    width_buttons +=SCREEN_WIDTH/4;

    self.tone_curve_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.tone_curve_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/4, self.frame.size.height/2);
    [self.tone_curve_button setImage:[UIImage imageNamed:@"photo_edit_tool_tone_curve.png"] forState:UIControlStateNormal];
    [self.tone_curve_button addTarget:self action:@selector(tone_curve_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.tone_curve_button];
    
    
    self.saturation_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.saturation_button.frame=CGRectMake(width_buttons,  self.frame.size.height/2, SCREEN_WIDTH/4, self.frame.size.height/2);
    [self.saturation_button setImage:[UIImage imageNamed:@"photo_edit_tool_saturation.png"] forState:UIControlStateNormal];
    [self.saturation_button addTarget:self action:@selector(saturation_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.saturation_button];
    
    
    width_buttons +=SCREEN_WIDTH/4;

    self.blur_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.blur_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/4, self.frame.size.height/2);
    [self.blur_button setImage:[UIImage imageNamed:@"photo_edit_tool_blur.png"] forState:UIControlStateNormal];
    [self.blur_button addTarget:self action:@selector(blur_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.blur_button];
    
    
    self.contrast_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.contrast_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/4, self.frame.size.height/2);
    [self.contrast_button setImage:[UIImage imageNamed:@"photo_edit_tool_contrast.png"] forState:UIControlStateNormal];
    [self.contrast_button addTarget:self action:@selector(contrast_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.contrast_button];
    
    width_buttons +=SCREEN_WIDTH/4;
    
    
    
   
    
    
    self.exposure_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.exposure_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/4, self.frame.size.height/2);
    [self.exposure_button setImage:[UIImage imageNamed:@"photo_edit_tool_exposure.png"] forState:UIControlStateNormal];
    [self.exposure_button addTarget:self action:@selector(exposure_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.exposure_button];
    
       
}

#pragma mark - Button Pressed Methods -

-(IBAction)crop_image_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(crop_image_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate crop_image_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)saturation_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(saturation_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate saturation_button_pressed:sender onSelectedView:self];
    }
}



-(IBAction)tone_curve_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(tone_curve_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate tone_curve_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)contrast_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(contrast_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate contrast_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)blur_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(blur_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate blur_button_pressed:sender onSelectedView:self];
    }
}



-(IBAction)exposure_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(exposure_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate exposure_button_pressed:sender onSelectedView:self];
    }
}


-(IBAction)brightness_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(brightness_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate brightness_button_pressed:sender onSelectedView:self];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
