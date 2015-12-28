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
@synthesize black_view,done_check_mark_button;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}



-(void)addBlackView{
    self.black_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    self.black_view.backgroundColor=[UIColor blackColor];
    [self addSubview:self.black_view];
    
    self.done_check_mark_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.done_check_mark_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    self.done_check_mark_button.showsTouchWhenHighlighted=YES;
    
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.done_check_mark_button];
    
    
}
-(void)initializeView{
    
    [self addBlackView];
    self.image_edit_scroll_view =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, self.frame.size.height-25)];
    self.image_edit_scroll_view.delegate=self;
    self.image_edit_scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH, self.frame.size.height-25);
    self.image_edit_scroll_view.contentOffset=CGPointZero;
    [self addSubview:self.image_edit_scroll_view];
    
    int width_buttons = 0;
    //int height_origin_button = 0;

    self.crop_image_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.crop_image_button.frame=CGRectMake(width_buttons,0, SCREEN_WIDTH/4, self.image_edit_scroll_view.frame.size.height/2);
    [self.crop_image_button setImage:[UIImage imageNamed:@"photo_edit_tool_crop.png"] forState:UIControlStateNormal];
    
    [self.crop_image_button addTarget:self action:@selector(crop_image_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.crop_image_button];
    
    
    
    self.brightness_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.brightness_button.frame=CGRectMake(width_buttons, self.image_edit_scroll_view.frame.size.height/2, SCREEN_WIDTH/4, self.image_edit_scroll_view.frame.size.height/2);
    [self.brightness_button setImage:[UIImage imageNamed:@"photo_edit_tool_brightness.png"] forState:UIControlStateNormal];
    [self.brightness_button addTarget:self action:@selector(brightness_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.brightness_button];

    width_buttons +=SCREEN_WIDTH/4;

    self.tone_curve_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.tone_curve_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/4, self.image_edit_scroll_view.frame.size.height/2);
    [self.tone_curve_button setImage:[UIImage imageNamed:@"photo_edit_tool_tone_curve.png"] forState:UIControlStateNormal];
    [self.tone_curve_button addTarget:self action:@selector(tone_curve_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.tone_curve_button];
    
    
    self.saturation_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.saturation_button.frame=CGRectMake(width_buttons,  self.image_edit_scroll_view.frame.size.height/2, SCREEN_WIDTH/4, self.image_edit_scroll_view.frame.size.height/2);
    [self.saturation_button setImage:[UIImage imageNamed:@"photo_edit_tool_saturation.png"] forState:UIControlStateNormal];
    [self.saturation_button addTarget:self action:@selector(saturation_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.saturation_button];
    
    
    width_buttons +=SCREEN_WIDTH/4;

    self.blur_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.blur_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/4, self.image_edit_scroll_view.frame.size.height/2);
    [self.blur_button setImage:[UIImage imageNamed:@"photo_edit_tool_blur.png"] forState:UIControlStateNormal];
    [self.blur_button addTarget:self action:@selector(blur_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.blur_button];
    
    
    self.contrast_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.contrast_button.frame=CGRectMake(width_buttons, self.image_edit_scroll_view.frame.size.height/2, SCREEN_WIDTH/4, self.image_edit_scroll_view.frame.size.height/2);
    [self.contrast_button setImage:[UIImage imageNamed:@"photo_edit_tool_contrast.png"] forState:UIControlStateNormal];
    [self.contrast_button addTarget:self action:@selector(contrast_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.contrast_button];
    
    width_buttons +=SCREEN_WIDTH/4;
    
    
    
    
    self.exposure_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.exposure_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/4, self.image_edit_scroll_view.frame.size.height/2);
    [self.exposure_button setImage:[UIImage imageNamed:@"photo_edit_tool_exposure.png"] forState:UIControlStateNormal];
    [self.exposure_button addTarget:self action:@selector(exposure_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.exposure_button];
    
    
    if(!self.SliderBackView)
    {
        self.SliderBackView = [[UIView alloc]initWithFrame:self.bounds];
        [self.SliderBackView setBackgroundColor:[UIColor lightGrayColor]];
        [self.SliderBackView setHidden:YES];
        
        self.selected_button_label = [[UILabel alloc]initWithFrame:CGRectMake(16, 25, 90, self.SliderBackView.frame.size.height-25)];
        self.selected_button_label.text=@"";
        self.selected_button_label.textAlignment=NSTextAlignmentLeft;
        self.selected_button_label.textColor=[UIColor darkGrayColor];
        [self.SliderBackView addSubview:self.selected_button_label];
      
        CGFloat orginForSlider = self.selected_button_label.frame.size.width+self.selected_button_label.frame.origin.x+20;

        
        
        self.commonSlider = [[UISlider alloc]init];
        [self.commonSlider setFrame:CGRectMake(orginForSlider, 25, SCREEN_WIDTH-20-orginForSlider, self.SliderBackView.frame.size.height-25)];

        
//        [self.commonSlider setFrame:CGRectMake(SCREEN_WIDTH/2-100 , self.bounds.size.height/2, 200, 10)];
        [self.commonSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self.SliderBackView addSubview:self.commonSlider];
        [self addSubview:self.SliderBackView];
        [self addInnerBlackView:self.SliderBackView];
    }
}

-(void)addInnerBlackView:(UIView *)superView{
    UIView *black_sub_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    black_sub_view.backgroundColor=[UIColor blackColor];
    [superView addSubview:black_sub_view];
    
    UIButton *done_check_mark_button_subview = [UIButton buttonWithType:UIButtonTypeCustom];
    done_check_mark_button_subview.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    done_check_mark_button_subview.showsTouchWhenHighlighted=YES;
    
    [done_check_mark_button_subview setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [done_check_mark_button_subview addTarget:self action:@selector(done_check_mark_button_subview_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [black_sub_view addSubview:done_check_mark_button_subview];

}

#pragma mark - Button Pressed Methods -

-(IBAction)crop_image_button_pressed:(UIButton *)sender{
    self.selected_button_label.text=@"Crop";

    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(crop_image_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate crop_image_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)saturation_button_pressed:(UIButton *)sender{
    self.selected_button_label.text=@"Saturation";

    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(saturation_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate saturation_button_pressed:sender onSelectedView:self];
        [self.SliderBackView setHidden:NO];
        [self.commonSlider setTag:4];
    }
}



-(IBAction)tone_curve_button_pressed:(UIButton *)sender{
    self.selected_button_label.text=@"Tone Curve";
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(tone_curve_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate tone_curve_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)contrast_button_pressed:(UIButton *)sender{
    self.selected_button_label.text=@"Contrast";

    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(contrast_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate contrast_button_pressed:sender onSelectedView:self];
        [self.SliderBackView setHidden:NO];
        [self.commonSlider setTag:5];

    }
}

-(IBAction)blur_button_pressed:(UIButton *)sender{
    self.selected_button_label.text=@"Blur";

    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(blur_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate blur_button_pressed:sender onSelectedView:self];
        [self.SliderBackView setHidden:NO];
        [self.commonSlider setTag:1];

    }
}



-(IBAction)exposure_button_pressed:(UIButton *)sender{
    self.selected_button_label.text=@"Exposure";

    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(exposure_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate exposure_button_pressed:sender onSelectedView:self];
        [self.SliderBackView setHidden:NO];
        [self.commonSlider setTag:2];
    }
}


-(IBAction)brightness_button_pressed:(UIButton *)sender{
    self.selected_button_label.text=@"Brightness";

    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(brightness_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate brightness_button_pressed:sender onSelectedView:self];
        [self.SliderBackView setHidden:NO];
        [self.commonSlider setTag:3];

    }
}

-(void)sliderValueChanged:(UISlider *)slider
{
    switch (slider.tag)
    {
        case 1:
        {
            [self.photo_edit_tool_options_delegate blur_sliderValueChanged:slider onSelectedView:self];
        }
            break;
        case 2:
        {
            [self.photo_edit_tool_options_delegate exposure_sliderValueChanged:slider onSelectedView:self];
        }
            break;
        case 3:
        {
            [self.photo_edit_tool_options_delegate brightness_sliderValueChanged:slider onSelectedView:self];
        }
            break;
        case 4:
        {
            [self.photo_edit_tool_options_delegate saturation_sliderValueChanged:slider onSelectedView:self];
        }
            break;
        case 5:
        {
            [self.photo_edit_tool_options_delegate contrast_sliderValueChanged:slider onSelectedView:self];
        }
            break;

            
        default:
            break;
    }
}

-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.photo_edit_tool_options_delegate respondsToSelector:@selector(photo_edit_tool_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.photo_edit_tool_options_delegate photo_edit_tool_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}

-(IBAction)done_check_mark_button_subview_pressed:(UIButton *)sender{
    self.SliderBackView.hidden=YES;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
