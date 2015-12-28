//
//  EraserView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "EraserView.h"
#define MAX_COLOR [UIColor grayColor]//[UIColor redColor]
#define MIN_COLOR [UIColor greenColor]
#define BUTTON_TITLE_COLOR [UIColor colorWithRed:0.0313 green:0.2549 blue:0.3490 alpha:1]
#define BUTTON_BACKGROUND_COLOR [UIColor colorWithRed:0.64 green:0.8196 blue:0.7019 alpha:1]
@implementation EraserView
@synthesize black_view,done_check_mark_button,eraser_label,intensity_label,opacity_slider,curve_slider,eraser_size_slider,intensity_slider,undo_last_erase_button,eraser_delegate;



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
    self.done_check_mark_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.done_check_mark_button];
    
    [self addEraserView];
    
}

-(void)addEraserView{
    
    int height=self.black_view.frame.size.height+10;
    
    
    self.eraser_label = [[UILabel alloc]initWithFrame:CGRectMake(16, height, 90, 25)];
    self.eraser_label.text=@"eraser size";
    self.eraser_label.textAlignment=NSTextAlignmentLeft;
    self.eraser_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.eraser_label];
    
    CGFloat orginForSlider = self.eraser_label.frame.size.width+self.eraser_label.frame.origin.x+20;
    
    
    self.eraser_size_slider = [[UISlider alloc]initWithFrame:CGRectMake(orginForSlider, height, SCREEN_WIDTH-20-orginForSlider, 25)];
    self.eraser_size_slider.value=0;
    [self.eraser_size_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.eraser_size_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.eraser_size_slider addTarget:self action:@selector(eraser_size_slider_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.eraser_size_slider];
    
    height+=36;
    
    self.intensity_label = [[UILabel alloc]initWithFrame:CGRectMake(16, height, 90, 25)];
    self.intensity_label.text=@"intensity";
    self.intensity_label.textAlignment=NSTextAlignmentLeft;
    self.intensity_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.intensity_label];
    
    
   
    
    self.intensity_slider = [[UISlider alloc]initWithFrame:CGRectMake(orginForSlider, height, SCREEN_WIDTH-20-orginForSlider, 25)];
    self.intensity_slider.value=0;
    [self.intensity_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.intensity_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.intensity_slider addTarget:self action:@selector(intensity_slider_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.intensity_slider];
    
    height+=36;

    
    self.undo_last_erase_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.undo_last_erase_button.frame=CGRectMake(20, height, SCREEN_WIDTH-40, 30);
    self.undo_last_erase_button.layer.borderWidth=0.8;
    self.undo_last_erase_button.layer.borderColor = [UIColor whiteColor].CGColor;
    self.undo_last_erase_button.layer.cornerRadius=5;
    [self.undo_last_erase_button setTitle:@"UNDO LAST ERASE" forState:UIControlStateNormal];
    self.undo_last_erase_button.titleLabel.font=[UIFont systemFontOfSize:10];
    [self.undo_last_erase_button setTitleColor:BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    self.undo_last_erase_button.backgroundColor=BUTTON_BACKGROUND_COLOR;
    [self.undo_last_erase_button addTarget:self action:@selector(undo_last_erase_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.undo_last_erase_button];
    
    
}

-(void)setDeafultValues{
    
}
-(void)resetValues{
    
}

#pragma mark - Button Pressed Method -

-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.eraser_delegate respondsToSelector:@selector(eraser_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.eraser_delegate eraser_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}
-(IBAction)undo_last_erase_button_pressed:(UIButton *)sender{
    
    if ([self.eraser_delegate respondsToSelector:@selector(undo_last_erase_button_pressed:onSelectedView:)]) {
        [self.eraser_delegate undo_last_erase_button_pressed:sender onSelectedView:self];
        
    }
}
#pragma mark - SLider Value Methods -

-(IBAction)eraser_size_slider_changed:(UISlider *)slider{
    if ([self.eraser_delegate respondsToSelector:@selector(eraser_size_slider_value_changed:onSelectedView:)]) {
        [self.eraser_delegate eraser_size_slider_value_changed:slider onSelectedView:self];
        
    }
}

-(IBAction)intensity_slider_changed:(UISlider *)slider{
    if ([self.eraser_delegate respondsToSelector:@selector(eraser_intensity_slider_value_changed:onSelectedView:)]) {
        [self.eraser_delegate eraser_intensity_slider_value_changed:slider onSelectedView:self];
        
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
