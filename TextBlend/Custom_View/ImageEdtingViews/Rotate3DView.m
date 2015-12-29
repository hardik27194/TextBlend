//
//  Rotate3DView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "Rotate3DView.h"
#define MAX_COLOR [UIColor grayColor]//[UIColor redColor]
#define MIN_COLOR [UIColor greenColor]
#define BUTTON_TITLE_COLOR [UIColor colorWithRed:0.0313 green:0.2549 blue:0.3490 alpha:1]
#define BUTTON_BACKGROUND_COLOR [UIColor colorWithRed:0.64 green:0.8196 blue:0.7019 alpha:1]


@implementation Rotate3DView
@synthesize black_view,done_check_mark_button,info_text_image_view,intensity_slider,reset_3d_rotate_button,rotate_3d_delegate;



-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}


-(void)initializeView{
    self.black_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    self.black_view.backgroundColor=[UIColor blackColor];
    [self addSubview:self.black_view];
    
    self.done_check_mark_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.done_check_mark_button.showsTouchWhenHighlighted=YES;
    
    self.done_check_mark_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.done_check_mark_button];
    
    [self addEraserView];
    
}

-(void)addEraserView{
    
    int height=self.black_view.frame.size.height+10;
    
    
    self.info_text_image_view = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-287)/2, height, 287, 40)];
    self.info_text_image_view.image=[UIImage imageNamed:@"rotate_3d_info_text_image.PNG"];
    [self addSubview:self.info_text_image_view];
    
    height+=48;
    
    
    self.intensity_slider = [[UISlider alloc]initWithFrame:CGRectMake(20, height, SCREEN_WIDTH-40, 20)];
    self.intensity_slider.value=0;
    [self.intensity_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.intensity_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.intensity_slider addTarget:self action:@selector(intensity_slider_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.intensity_slider];
    
    height+=27;
    
    
    self.reset_3d_rotate_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reset_3d_rotate_button.frame=CGRectMake(20, height, SCREEN_WIDTH-40, 28);
    self.reset_3d_rotate_button.layer.borderWidth=0.8;
    self.reset_3d_rotate_button.layer.borderColor = [UIColor whiteColor].CGColor;
    self.reset_3d_rotate_button.layer.cornerRadius=5;
    [self.reset_3d_rotate_button setTitle:@"RESET 3D ROTATE" forState:UIControlStateNormal];
    self.reset_3d_rotate_button.titleLabel.font=[UIFont systemFontOfSize:9];
    [self.reset_3d_rotate_button setTitleColor:BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    self.reset_3d_rotate_button.backgroundColor=BUTTON_BACKGROUND_COLOR;
    [self.reset_3d_rotate_button addTarget:self action:@selector(reset_3d_rotate_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.reset_3d_rotate_button];
    
    
}

-(void)setDeafultValues{
    
}
-(void)resetValues{
    
}

#pragma mark - Button Pressed Method -

-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.rotate_3d_delegate respondsToSelector:@selector(rotate_3d_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.rotate_3d_delegate rotate_3d_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}
-(IBAction)reset_3d_rotate_button_pressed:(UIButton *)sender{
    
    if ([self.rotate_3d_delegate respondsToSelector:@selector(reset_3d_rotate_button_pressed:onSelectedView:)]) {
        [self.rotate_3d_delegate reset_3d_rotate_button_pressed:sender onSelectedView:self];
        
    }
}
#pragma mark - Slider Value Methods -

-(IBAction)intensity_slider_value_changed:(UISlider *)slider{
    if ([self.rotate_3d_delegate respondsToSelector:@selector(rotate_3d_intensity_slider_value_changed:onSelectedView:)]) {
        [self.rotate_3d_delegate rotate_3d_intensity_slider_value_changed:slider onSelectedView:self];
        
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
