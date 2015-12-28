//
//  TextToolsView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "TextToolsView.h"
#define MAX_COLOR [UIColor grayColor]//[UIColor redColor]
#define MIN_COLOR [UIColor greenColor]
@implementation TextToolsView
@synthesize black_view,done_check_mark_button,opacity_label,curve_label,character_spacing_label,line_spacing_label,opacity_slider,curve_slider,character_spacing_slider,line_spacing_slider,text_tools_delegate;


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
    
    [self addToolsView];
    
}

-(void)addToolsView{

    int height=self.black_view.frame.size.height+5;
    
    
    self.opacity_label = [[UILabel alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH/2, 20)];
    self.opacity_label.text=@"opacity";
    self.opacity_label.textAlignment=NSTextAlignmentCenter;
    self.opacity_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.opacity_label];
    
    self.curve_label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, height, SCREEN_WIDTH/2, 20)];
    self.curve_label.text=@"curve";
    self.curve_label.textAlignment=NSTextAlignmentCenter;
    self.curve_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.curve_label];
    
    height+=25;
    
    self.opacity_slider = [[UISlider alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH/2-20, 30)];
//    self.opacity_slider.value=0;
//    [self.opacity_slider setMinimumValue:0.1];
//    [self.opacity_slider setMinimumValue:1.0];
    [self.opacity_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.opacity_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.opacity_slider addTarget:self action:@selector(opacity_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.opacity_slider];
    
    self.curve_slider = [[UISlider alloc]initWithFrame:CGRectMake(10+(SCREEN_WIDTH/2), height, SCREEN_WIDTH/2-20, 30)];
    self.curve_slider.value=0;
    [self.curve_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.curve_slider setMaximumTrackTintColor:MAX_COLOR];

    [self.curve_slider addTarget:self action:@selector(curve_slider_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.curve_slider];
    
    
    int height2=((self.frame.size.height-self.black_view.frame.size.height)/2)+self.black_view.frame.size.height;
    
    
    self.character_spacing_label = [[UILabel alloc]initWithFrame:CGRectMake(0, height2, SCREEN_WIDTH/2, 20)];
    self.character_spacing_label.text=@"character spacing";
    self.character_spacing_label.textAlignment=NSTextAlignmentCenter;
    self.character_spacing_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.character_spacing_label];
    
    self.line_spacing_label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, height2, SCREEN_WIDTH/2, 20)];
    self.line_spacing_label.text=@"Line Spacing";
    self.line_spacing_label.textAlignment=NSTextAlignmentCenter;
    self.line_spacing_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.line_spacing_label];
    
    height2+=25;

    self.character_spacing_slider = [[UISlider alloc]initWithFrame:CGRectMake(10, height2, SCREEN_WIDTH/2-20, 30)];
    self.character_spacing_slider.minimumValue=0.5;
    self.character_spacing_slider.maximumValue = 10;
    [self.character_spacing_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.character_spacing_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.character_spacing_slider addTarget:self action:@selector(character_spacing_slider_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.character_spacing_slider];
    
    self.line_spacing_slider = [[UISlider alloc]initWithFrame:CGRectMake(10+(SCREEN_WIDTH/2), height2, SCREEN_WIDTH/2-20, 30)];
    self.line_spacing_slider.value=0;
    [self.line_spacing_slider setMaximumValue:40.0];
    [self.line_spacing_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.line_spacing_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.line_spacing_slider addTarget:self action:@selector(line_spacing_slider_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.line_spacing_slider];
    
}

-(void)setDeafultValues{
    
}
-(void)resetValues{
    
}

#pragma mark - Button Pressed Method - 

-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.text_tools_delegate respondsToSelector:@selector(text_tools_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.text_tools_delegate text_tools_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}

#pragma mark - SLider Value Methods -

 -(IBAction)opacity_value_changed:(UISlider *)slider{
     if ([self.text_tools_delegate respondsToSelector:@selector(opacity_value_changed:onSelectedView:)]) {
         [self.text_tools_delegate opacity_value_changed:slider onSelectedView:self];
         
     }
 }

 -(IBAction)curve_slider_value_changed:(UISlider *)slider{
     if ([self.text_tools_delegate respondsToSelector:@selector(curve_slider_value_changed:onSelectedView:)]) {
         [self.text_tools_delegate curve_slider_value_changed:slider onSelectedView:self];
         
     }
 }

 -(IBAction)character_spacing_slider_value_changed:(UISlider *)slider{
     if ([self.text_tools_delegate respondsToSelector:@selector(character_spacing_slider_value_changed:onSelectedView:)]) {
         [self.text_tools_delegate character_spacing_slider_value_changed:slider onSelectedView:self];
         
     }
 }

 -(IBAction)line_spacing_slider_value_changed:(UISlider *)slider{
     if ([self.text_tools_delegate respondsToSelector:@selector(line_spacing_slider_value_changed:onSelectedView:)]) {
         [self.text_tools_delegate line_spacing_slider_value_changed:slider onSelectedView:self];
         
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
