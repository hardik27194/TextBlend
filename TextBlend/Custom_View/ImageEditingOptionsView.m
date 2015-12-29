//
//  ImageEditingOptionsView.m
//  TextBlend
//
//  Created by Wayne Rooney on 05/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ImageEditingOptionsView.h"
@implementation ImageEditingOptionsView
@synthesize image_edit_scroll_view,text_edit_button,quotes_button,saying_button,filters_button,effects_button,shape_button,photo_edit_button,draw_button,colorize_button,spalsh_button,image_editing_options_delegate;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}

-(void)initializeView{
    
    self.image_edit_scroll_view =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.image_edit_scroll_view.delegate=self;
    self.image_edit_scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH+(2*SCREEN_WIDTH)/3, SCREEN_HEIGHT);
    self.image_edit_scroll_view.contentOffset=CGPointZero;
    [self addSubview:self.image_edit_scroll_view];
    
    int width_buttons = 0;
    
    self.text_edit_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.text_edit_button.frame=CGRectMake(width_buttons,0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.text_edit_button setImage:[UIImage imageNamed:@"image_editing_screen_text_edit.PNG"] forState:UIControlStateNormal];
    
    [self.text_edit_button addTarget:self action:@selector(text_edit_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.text_edit_button];
    
    self.shape_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.shape_button.frame=CGRectMake(width_buttons,  self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.shape_button setImage:[UIImage imageNamed:@"image_editing_screen_shape.PNG"] forState:UIControlStateNormal];
    [self.shape_button addTarget:self action:@selector(shape_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.shape_button];
    
    width_buttons +=SCREEN_WIDTH/3;
    
    self.quotes_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.quotes_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.quotes_button setImage:[UIImage imageNamed:@"image_editing_screen_quotes.PNG"] forState:UIControlStateNormal];
    [self.quotes_button addTarget:self action:@selector(quotes_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.quotes_button];
    
    self.photo_edit_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.photo_edit_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.photo_edit_button setImage:[UIImage imageNamed:@"image_editing_screen_phot_edit.png"]
                            forState:UIControlStateNormal];
    [self.photo_edit_button addTarget:self action:@selector(photo_edit_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.photo_edit_button];
    
    width_buttons +=SCREEN_WIDTH/3;
    
    self.saying_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.saying_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.saying_button setImage:[UIImage imageNamed:@"image_editing_screen_saying.PNG"] forState:UIControlStateNormal];
    [self.saying_button addTarget:self action:@selector(saying_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.saying_button];
    
    self.draw_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.draw_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.draw_button setImage:[UIImage imageNamed:@"image_editing_screen_draw.PNG"] forState:UIControlStateNormal];
    [self.draw_button addTarget:self action:@selector(draw_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.draw_button];
    
    width_buttons +=SCREEN_WIDTH/3;
    
    self.filters_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.filters_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.filters_button setImage:[UIImage imageNamed:@"image_editing_screen_filter.png"] forState:UIControlStateNormal];
    [self.filters_button addTarget:self action:@selector(filters_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.filters_button];
    
    self.colorize_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.colorize_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.colorize_button setImage:[UIImage imageNamed:@"image_editing_screen_colorize.png"] forState:UIControlStateNormal];
    [self.colorize_button addTarget:self action:@selector(colorize_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.colorize_button];
    
    width_buttons +=SCREEN_WIDTH/3;
    
    self.effects_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.effects_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.effects_button setImage:[UIImage imageNamed:@"image_editing_screen_effect.png"] forState:UIControlStateNormal];
    [self.effects_button addTarget:self action:@selector(effects_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.effects_button];
    
    self.spalsh_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.spalsh_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.spalsh_button setImage:[UIImage imageNamed:@"image_editing_screen_spalsh.png"] forState:UIControlStateNormal];
    [self.spalsh_button addTarget:self action:@selector(spalsh_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.image_edit_scroll_view addSubview:self.spalsh_button];
    
    width_buttons +=SCREEN_WIDTH/3;
    
}

#pragma mark - Button Pressed Methods -

-(IBAction)text_edit_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(text_edit_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate text_edit_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)shape_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(shape_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate shape_button_pressed:sender onSelectedView:self];
    }
}



-(IBAction)quotes_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(quotes_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate quotes_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)photo_edit_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(photo_edit_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate photo_edit_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)saying_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(saying_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate saying_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)draw_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(draw_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate draw_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)filters_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(filters_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate filters_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)colorize_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(colorize_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate colorize_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)effects_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(effects_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate effects_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)spalsh_button_pressed:(UIButton *)sender{
    
    if ([self.image_editing_options_delegate respondsToSelector:@selector(spalsh_button_pressed:onSelectedView:)]) {
        [self.image_editing_options_delegate spalsh_button_pressed:sender onSelectedView:self];
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
