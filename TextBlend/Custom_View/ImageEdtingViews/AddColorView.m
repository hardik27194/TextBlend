//
//  AddColorView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "AddColorView.h"
#import "AddColorSelectionView.h"
#import "ColorPaletteGradientView.h"
#define text_buffer 50
#define EDITING_BACKGROUND_COLOR [UIColor colorWithRed:0.7254 green:0.7254 blue:0.7254 alpha:1]
#define MAX_COLOR [UIColor grayColor]
#define MIN_COLOR [UIColor greenColor]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW 145
#define CENTRE_FRAME CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)
#define BOTTOM_FRAME CGRectMake(0, SCREEN_HEIGHT-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW-50, SCREEN_WIDTH +(2*SCREEN_WIDTH)/3, HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)

@interface AddColorView ()<ColorPaletteGradientColorViewDelegate,SelectColorPaletteViewDelegate>{
    ColorPaletteGradientView *color_palette_view;
    SelectColorPaletteView *select_color_palette_view;
    
}

@end

@implementation AddColorView
@synthesize selected_label;
@synthesize selected_color;
@synthesize add_color_view_delegate;
@synthesize black_view,done_check_mark_button,colorPreviewView;
@synthesize selected_sticker_view;
@synthesize color_selection_view;
/*
 -(id)initWithFrame:(CGRect)frame{
 if (self = [super initWithFrame:frame]){
 self.backgroundColor=EDITING_BACKGROUND_COLOR;
 [self addToolsView];
 //[self getPopularPosts:YES];
 }
 return self;
 
 }
 */

//-(void)setNeedsDisplay{
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    [self setGradientCOlor:ctx];
//}

#pragma mark - New code

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        [self addToolsView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addSelectColorView) name:@"ADD_SELECTION_COLOR_NOTIFICATION" object:nil];

        //        self.gradent_label.text = @"Hello";
        //
        //        self.gradent_label.textColor = [UIColor colorWithPatternImage:[self gradientImage]];
        
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
    
    
}

-(void)initializeWithDefaultValues{
    if (!self.selected_sticker_view) {
        return;
    }
    BOOL shouldUpdate=NO;
    OHAttributedLabel *label =(OHAttributedLabel *) self.selected_sticker_view.contentView1;
    if (label.gradient_start_color) {
        color_selection_view.start_color_label.backgroundColor=label.gradient_start_color;
        shouldUpdate=YES;
    }
    if (label.gradient_end_color) {
        color_selection_view.end_color_label.backgroundColor=label.gradient_end_color;
        shouldUpdate=YES;

    }
    
    
    if (label.gradient_direction_slider_value) {
        self.direction_slider.value=label.gradient_direction_slider_value;
        shouldUpdate=YES;

    }
    if (shouldUpdate) {
        [self updateGradientColors];
    }

}

-(void)addToolsView{
    if (!color_palette_view) {
        color_palette_view=[[ColorPaletteGradientView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 35)];
        color_palette_view.color_palette_view_delegate=self;
        color_palette_view.selected_sticker_view=self.selected_sticker_view;
        
        [self addSubview:color_palette_view];
    }
    
    int height=self.frame.size.height-30-42;
    
    
//    self.gradent_label = [[UILabel alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH/2, 50)];
//    self.gradent_label.text=@"opacity";
//    self.gradent_label.textAlignment=NSTextAlignmentCenter;
//    self.gradent_label.textColor=[UIColor darkGrayColor];
//    [self addSubview:self.gradent_label];
//    
//    if (!self.gradent_label.layer.sublayers.count) {
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = self.gradent_label.bounds;
//        gradient.colors = [self setGradientColor:gradient];
//        [self.gradent_label.layer insertSublayer:gradient atIndex:0];
//        
//    }
//    
    
    
//    height+=60;
    color_selection_view=[[AddColorSelectionView alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-20, 40)];
    color_selection_view.add_color_gradient_view=self;
    //    color_selection_view.backgroundColor=[UIColor yellowColor];
    
    [self addSubview:color_selection_view];
    
    
    
    height+=50;
    
    self.direction_slider = [[UISlider alloc]initWithFrame:CGRectMake(10, self.frame.size.height-25, SCREEN_WIDTH-20, 20)];
    [self.direction_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.direction_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.direction_slider addTarget:self action:@selector(direction_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self.direction_slider setMinimumValue:0.0];
    [self.direction_slider setMaximumValue:360.0];
    [self addSubview:self.direction_slider];
    
    
    
}
-(void)updateGradientColors{
//    if (self.gradent_label.layer.sublayers.count) {
//        for (CALayer *layer in self.gradent_label.layer.sublayers) {
//            [layer removeFromSuperlayer];
//        }
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = self.gradent_label.bounds;
//        gradient.colors = [self setGradientColor:gradient];
//        [self.gradent_label.layer insertSublayer:gradient atIndex:0];
//        
//    }
    [self setGradientColor];
}




//-(NSArray *)setGradientColor:(CAGradientLayer *)gradient{
    -(void)setGradientColor{
 
    UIColor *color1=[UIColor grayColor];
    UIColor *color2=[UIColor grayColor];
    UIColor *color3=[UIColor grayColor];
    UIColor *color4=[UIColor grayColor];
    UIColor *color5=[UIColor grayColor];
    UIColor *color6=[UIColor grayColor];
    UIColor *color7=[UIColor grayColor];
    UIColor *color8=[UIColor grayColor];
    UIColor *color9=[UIColor grayColor];
    UIColor *color10=[UIColor grayColor];
    
    CGFloat per_slot = color_selection_view.frame.size.width/10;
    
    if (color_selection_view.start_color_label.frame.size.width<=text_buffer) {
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.end_color_label.backgroundColor;
        color3 = color_selection_view.end_color_label.backgroundColor;
        color4 = color_selection_view.end_color_label.backgroundColor;
        color5 = color_selection_view.end_color_label.backgroundColor;
        color6 = color_selection_view.end_color_label.backgroundColor;
        color7 = color_selection_view.end_color_label.backgroundColor;
        color8 = color_selection_view.end_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.1 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }
        
    }
    else if (color_selection_view.start_color_label.frame.size.width>=color_selection_view.frame.size.width-text_buffer){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.start_color_label.backgroundColor;
        color5 = color_selection_view.start_color_label.backgroundColor;
        color6 = color_selection_view.start_color_label.backgroundColor;
        color7 = color_selection_view.start_color_label.backgroundColor;
        color8 = color_selection_view.start_color_label.backgroundColor;
        color9 = color_selection_view.start_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.9 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

    }
    else if (color_selection_view.start_color_label.frame.size.width<=2*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.end_color_label.backgroundColor;
        color4 = color_selection_view.end_color_label.backgroundColor;
        color5 = color_selection_view.end_color_label.backgroundColor;
        color6 = color_selection_view.end_color_label.backgroundColor;
        color7 = color_selection_view.end_color_label.backgroundColor;
        color8 = color_selection_view.end_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.2 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

        
        
    }
    else if (color_selection_view.start_color_label.frame.size.width<=3*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.end_color_label.backgroundColor;
        color5 = color_selection_view.end_color_label.backgroundColor;
        color6 = color_selection_view.end_color_label.backgroundColor;
        color7 = color_selection_view.end_color_label.backgroundColor;
        color8 = color_selection_view.end_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.3 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

        
    }
    else if (color_selection_view.start_color_label.frame.size.width<=4*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.start_color_label.backgroundColor;
        color5 = color_selection_view.end_color_label.backgroundColor;
        color6 = color_selection_view.end_color_label.backgroundColor;
        color7 = color_selection_view.end_color_label.backgroundColor;
        color8 = color_selection_view.end_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.4 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

    }
    else if (color_selection_view.start_color_label.frame.size.width<=5*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.start_color_label.backgroundColor;
        color5 = color_selection_view.start_color_label.backgroundColor;
        color6 = color_selection_view.end_color_label.backgroundColor;
        color7 = color_selection_view.end_color_label.backgroundColor;
        color8 = color_selection_view.end_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.5 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

    }
    else if (color_selection_view.start_color_label.frame.size.width<=6*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.start_color_label.backgroundColor;
        color5 = color_selection_view.start_color_label.backgroundColor;
        color6 = color_selection_view.start_color_label.backgroundColor;
        color7 = color_selection_view.end_color_label.backgroundColor;
        color8 = color_selection_view.end_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.6 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }
 
    }
    else if (color_selection_view.start_color_label.frame.size.width<=7*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.start_color_label.backgroundColor;
        color5 = color_selection_view.start_color_label.backgroundColor;
        color6 = color_selection_view.start_color_label.backgroundColor;
        color7 = color_selection_view.start_color_label.backgroundColor;
        color8 = color_selection_view.end_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.7 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

    }
    else if (color_selection_view.start_color_label.frame.size.width<=8*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.start_color_label.backgroundColor;
        color5 = color_selection_view.start_color_label.backgroundColor;
        color6 = color_selection_view.start_color_label.backgroundColor;
        color7 = color_selection_view.start_color_label.backgroundColor;
        color8 = color_selection_view.start_color_label.backgroundColor;
        color9 = color_selection_view.end_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.8 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

    }
    else if (color_selection_view.start_color_label.frame.size.width<=9*per_slot){
        color1 = color_selection_view.start_color_label.backgroundColor;
        color2 = color_selection_view.start_color_label.backgroundColor;
        color3 = color_selection_view.start_color_label.backgroundColor;
        color4 = color_selection_view.start_color_label.backgroundColor;
        color5 = color_selection_view.start_color_label.backgroundColor;
        color6 = color_selection_view.start_color_label.backgroundColor;
        color7 = color_selection_view.start_color_label.backgroundColor;
        color8 = color_selection_view.start_color_label.backgroundColor;
        color9 = color_selection_view.start_color_label.backgroundColor;
        color10 = color_selection_view.end_color_label.backgroundColor;
        if ([self.add_color_view_delegate respondsToSelector:@selector(updateViewWithStartColor:andEndColor:withPercenatgeValue:onSelectedView:withCurrentDirection:)]) {
            [self.add_color_view_delegate updateViewWithStartColor:color_selection_view.start_color_label.backgroundColor andEndColor:color_selection_view.end_color_label.backgroundColor withPercenatgeValue:0.9 onSelectedView:self withCurrentDirection:self.direction_slider.value];
            
        }

        
    }
    
  //  return [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], (id)[color3 CGColor], (id)[color4 CGColor], (id)[color5 CGColor], (id)[color6 CGColor], (id)[color7 CGColor], (id)[color8 CGColor], (id)[color9 CGColor], (id)[color10 CGColor], nil];
    
    
}


- (void)imageView:(DTColorPickerImageView *)imageView didPickColorWithColor:(UIColor *)color
{
    
//    UIView *Add_subview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
//    Add_subview.backgroundColor = color_selection_view.end_color_label.backgroundColor;
//    [imageView addSubview:Add_subview];
//    
//
//    return;
    //    [self.colorPreviewView setBackgroundColor:color];
    self.selected_color=color;
    if ([color_selection_view.start_color_label isEqual:selected_label]) {
        color_selection_view.start_color_label.backgroundColor=color;
        
    }
    else
        color_selection_view.end_color_label.backgroundColor=color;
    
    [color_selection_view updateBufferImageViewColors];
    /*
    if (self.gradent_label.layer.sublayers.count) {
        for (CALayer *layer in self.gradent_label.layer.sublayers) {
            [layer removeFromSuperlayer];
        }
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.gradent_label.bounds;
        gradient.colors = [self setGradientColor:gradient];
        [self.gradent_label.layer insertSublayer:gradient atIndex:0];
        
    }
    */
    [self setGradientColor];
    //    self.gradent_label.textColor= [self setGradientCOlor];
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    NSLog(@"Picked Color Components: %.0f, %.0f, %.0f", red * 255.0f, green * 255.0f, blue * 255.0f);
}

-(IBAction)direction_value_changed:(UISlider *)sender{
    [self updateGradientColors];
    
}
-(void)select_font_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(AddColorView *)selected_view{
    
    
}
-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if (self.colorPreviewView) {
        [self.colorPreviewView removeFromSuperview];

        self.colorPreviewView = nil;
        
    }
    else if ([self.add_color_view_delegate respondsToSelector:@selector(add_color_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.add_color_view_delegate add_color_done_check_mark_button_pressed:sender onSelectedView:self];
    }
}

-(void)add_color_selection_subview_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(AddColorSelectionView *)selected_view{
    
    
}

- (UIImage *)gradientImage
{
    CGSize textSize = [self.gradent_label.text sizeWithFont:self.gradent_label.font];
    CGFloat width = textSize.width;         // max 1024 due to Core Graphics limitations
    CGFloat height = textSize.height;       // max 1024 due to Core Graphics limitations
    
    // create a new bitmap image context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // push context to make it current (need to do this manually because we are not drawing in a UIView)
    UIGraphicsPushContext(context);
    
    //draw gradient
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    //    CGFloat locations[2] = { 0.0, 1.0 };
    //    CGFloat components[8] = { 0.0, 1.0, 1.0, 1.0,  // Start color
    //        1.0, 1.0, 0.0, 1.0 }; // End color
    
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 1.0, 1.0, 1.0,  // Start color
        1.0, 1.0, 0.0, 1.0 }; // End color
    
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGPoint topCenter = CGPointMake(0, 0);
    CGPoint bottomCenter = CGPointMake(0, textSize.height);
    CGContextDrawLinearGradient(context, glossGradient, topCenter, bottomCenter, 0);
    
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    
    // pop context
    UIGraphicsPopContext();
    
    // get a UIImage from the image context
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // clean up drawing environment
    UIGraphicsEndImageContext();
    
    return  gradientImage;
}


#pragma mark -Add Color Palette Gradient View Delegate Methods -
-(void)addSelectColorView
{
    
    if (!select_color_palette_view) {
        select_color_palette_view=[[SelectColorPaletteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        select_color_palette_view.select_color_palette_delegate = self;
        select_color_palette_view.selected_sticker_view=self.selected_sticker_view;
        [self addSubview:select_color_palette_view];
    }
    [self bringSubviewToFront:select_color_palette_view];
}



#pragma mark - Select Color Palette View Delegate Methods -

-(void)setSelectedColorFromSelectColorPaletteView:(UIColor*)color onSelectedView:(SelectColorPaletteView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view{
    
    NSLog(@"%@",sticker_view);
    
    if ([self.add_color_view_delegate respondsToSelector:@selector(add_color_set_selected_single_text_color:on_sticker_view:onSelectedView:)]) {
        [self.add_color_view_delegate add_color_set_selected_single_text_color:color on_sticker_view:self.selected_sticker_view onSelectedView:self];
    }
    
}


-(void)select_color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectColorPaletteView *)selected_view{
    
    [select_color_palette_view removeFromSuperview];
    select_color_palette_view=nil;
    
    if ([self.add_color_view_delegate respondsToSelector:@selector(add_color_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.add_color_view_delegate add_color_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
    
}

-(void)setSelectedColorFromGradientView:(UIColor*)color onSelectedView:(ColorPaletteGradientView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view{
    NSLog(@"%@",sticker_view);
    
    if ([self.add_color_view_delegate respondsToSelector:@selector(add_color_set_selected_single_text_color:on_sticker_view:onSelectedView:)]) {
        [self.add_color_view_delegate add_color_set_selected_single_text_color:color on_sticker_view:self.selected_sticker_view onSelectedView:self];
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
