//
//  AddTextView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "AddTextView.h"

@implementation AddTextView
@synthesize add_text_button,fonts_button,text_tools_button,colors_button,rotate_3d_button,eraser_button,add_text_view_delegate;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}

-(void)initializeView{
    
    
    
    int width_buttons = 0;
    
    self.add_text_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.add_text_button.frame=CGRectMake(width_buttons,0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.add_text_button setImage:[UIImage imageNamed:@"add_text_view_add_text.PNG"] forState:UIControlStateNormal];
    
    [self.add_text_button addTarget:self action:@selector(add_text_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.add_text_button];
    
    
    self.colors_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.colors_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.colors_button setImage:[UIImage imageNamed:@"add_text_view_color.png"]
                        forState:UIControlStateNormal];
    [self.colors_button addTarget:self action:@selector(colors_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.colors_button];
    
    width_buttons +=SCREEN_WIDTH/3;

    
    self.fonts_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.fonts_button.frame=CGRectMake(width_buttons,  0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.fonts_button setImage:[UIImage imageNamed:@"add_text_view_fonts.PNG"] forState:UIControlStateNormal];
    [self.fonts_button addTarget:self action:@selector(fonts_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.fonts_button];
    
    
    self.rotate_3d_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.rotate_3d_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.rotate_3d_button setImage:[UIImage imageNamed:@"add_text_view_3d_rotate.PNG"] forState:UIControlStateNormal];
    [self.rotate_3d_button addTarget:self action:@selector(rotate_3d_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rotate_3d_button];
    width_buttons +=SCREEN_WIDTH/3;

    
    self.text_tools_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.text_tools_button.frame=CGRectMake(width_buttons, 0, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.text_tools_button setImage:[UIImage imageNamed:@"add_text_view_text_tools.PNG"] forState:UIControlStateNormal];
    [self.text_tools_button addTarget:self action:@selector(text_tools_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.text_tools_button];
    
  
    
    self.eraser_button = [CustomButton buttonWithType:UIButtonTypeCustom];
    self.eraser_button.frame=CGRectMake(width_buttons, self.frame.size.height/2, SCREEN_WIDTH/3, self.frame.size.height/2);
    [self.eraser_button setImage:[UIImage imageNamed:@"add_text_view_eraser.PNG"] forState:UIControlStateNormal];
    [self.eraser_button addTarget:self action:@selector(eraser_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.eraser_button];
    
    
    
}

#pragma mark - Button Pressed Methods -

-(IBAction)add_text_button_pressed:(UIButton *)sender{
    
    if ([self.add_text_view_delegate respondsToSelector:@selector(add_text_button_pressed:onSelectedView:)]) {
        [self.add_text_view_delegate add_text_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)fonts_button_pressed:(UIButton *)sender{
    
    if ([self.add_text_view_delegate respondsToSelector:@selector(fonts_button_pressed:onSelectedView:)]) {
        [self.add_text_view_delegate fonts_button_pressed:sender onSelectedView:self];
    }
}



-(IBAction)text_tools_button_pressed:(UIButton *)sender{
    
    if ([self.add_text_view_delegate respondsToSelector:@selector(text_tools_button_pressed:onSelectedView:)]) {
        [self.add_text_view_delegate text_tools_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)colors_button_pressed:(UIButton *)sender{
    
    if ([self.add_text_view_delegate respondsToSelector:@selector(colors_button_pressed:onSelectedView:)]) {
        [self.add_text_view_delegate colors_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)rotate_3d_button_pressed:(UIButton *)sender{
    
    if ([self.add_text_view_delegate respondsToSelector:@selector(rotate_3d_button_pressed:onSelectedView:)]) {
        [self.add_text_view_delegate rotate_3d_button_pressed:sender onSelectedView:self];
    }
}

-(IBAction)eraser_button_pressed:(UIButton *)sender{
    
    if ([self.add_text_view_delegate respondsToSelector:@selector(eraser_button_pressed:onSelectedView:)]) {
        [self.add_text_view_delegate eraser_button_pressed:sender onSelectedView:self];
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
