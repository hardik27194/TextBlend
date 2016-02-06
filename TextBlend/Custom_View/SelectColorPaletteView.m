//
//  SelectColorPaletteView.m
//  TextBlend
//
//  Created by Itesh Dutt on 06/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "SelectColorPaletteView.h"
#import "ColorPaletteView.h"

@implementation SelectColorPaletteView
@synthesize black_view,done_check_mark_button;
@synthesize select_color_palette_delegate;
@synthesize selected_sticker_view;
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
    self.done_check_mark_button.showsTouchWhenHighlighted=YES;
    
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.done_check_mark_button];
    [self initializeColorPickerView];
    
    
}
-(void)initializeColorPickerView{
    self.colorPreviewView = [DTColorPickerImageView colorPickerWithFrame:CGRectMake(5, 30, SCREEN_WIDTH-10, self.frame.size.height-40)];
    self.colorPreviewView.image=[UIImage imageNamed:@"fontcolor_bar.png"];
    self.colorPreviewView.delegate=self;
    self.colorPreviewView.layer.cornerRadius=8;
    self.colorPreviewView.layer.borderColor=[UIColor blackColor].CGColor;
    self.colorPreviewView.layer.borderWidth=0.7;
    self.colorPreviewView.clipsToBounds=YES;
    

    [self addSubview:self.colorPreviewView];
    
}
- (void)imageView:(DTColorPickerImageView *)imageView didPickColorWithColor:(UIColor *)color
{
    if ([self.select_color_palette_delegate respondsToSelector:@selector(setSelectedColorFromSelectColorPaletteView:onSelectedView:onSelectedZticker:)]) {
        [self.select_color_palette_delegate setSelectedColorFromSelectColorPaletteView:color onSelectedView:self onSelectedZticker:self.selected_sticker_view];
        
    }
}
-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.select_color_palette_delegate respondsToSelector:@selector(select_color_palette_view_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.select_color_palette_delegate select_color_palette_view_done_check_mark_button_pressed:sender onSelectedView:self];
    }
    
}

@end
