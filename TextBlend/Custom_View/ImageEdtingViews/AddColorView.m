//
//  AddColorView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "AddColorView.h"
#import "AddColorSelectionView.h"
#define text_buffer 50

@interface AddColorView (){
    
    AddColorSelectionView *color_selection_view;
    
}

@end

@implementation AddColorView

#define EDITING_BACKGROUND_COLOR [UIColor colorWithRed:0.7254 green:0.7254 blue:0.7254 alpha:1]
#define MAX_COLOR [UIColor grayColor]
#define MIN_COLOR [UIColor greenColor]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

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

-(void)addToolsView{
    
    int height=25;
    
    
    self.gradent_label = [[UILabel alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH/2, 50)];
    self.gradent_label.text=@"opacity";
    self.gradent_label.textAlignment=NSTextAlignmentCenter;
    self.gradent_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.gradent_label];
    
    if (!self.gradent_label.layer.sublayers.count) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.gradent_label.bounds;
        gradient.colors = [self setGradientColor:gradient];
        [self.gradent_label.layer insertSublayer:gradient atIndex:0];
        
    }
    
    
    
    height+=60;
    color_selection_view=[[AddColorSelectionView alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-20, 40)];
    color_selection_view.add_color_gradient_view=self;
    //    color_selection_view.backgroundColor=[UIColor yellowColor];
    
    [self addSubview:color_selection_view];
    
    
    
    height+=60;
    
    self.direction_slider = [[UISlider alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-20, 30)];
    [self.direction_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.direction_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.direction_slider addTarget:self action:@selector(opacity_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.direction_slider];
    
    
    
}
-(void)updateGradientColors{
    if (self.gradent_label.layer.sublayers.count) {
        for (CALayer *layer in self.gradent_label.layer.sublayers) {
            [layer removeFromSuperlayer];
        }
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.gradent_label.bounds;
        gradient.colors = [self setGradientColor:gradient];
        [self.gradent_label.layer insertSublayer:gradient atIndex:0];
        
    }
    
}




-(NSArray *)setGradientColor:(CAGradientLayer *)gradient{
    
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
        
    }
    
    return [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], (id)[color3 CGColor], (id)[color4 CGColor], (id)[color5 CGColor], (id)[color6 CGColor], (id)[color7 CGColor], (id)[color8 CGColor], (id)[color9 CGColor], (id)[color10 CGColor], nil];
    
    
}


- (void)imageView:(DTColorPickerImageView *)imageView didPickColorWithColor:(UIColor *)color
{
    //    [self.colorPreviewView setBackgroundColor:color];
    self.selected_color=color;
    if ([color_selection_view.start_color_label isEqual:selected_label]) {
        color_selection_view.start_color_label.backgroundColor=color;
        
    }
    else
        color_selection_view.end_color_label.backgroundColor=color;
    
    if (self.gradent_label.layer.sublayers.count) {
        for (CALayer *layer in self.gradent_label.layer.sublayers) {
            [layer removeFromSuperlayer];
        }
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.gradent_label.bounds;
        gradient.colors = [self setGradientColor:gradient];
        [self.gradent_label.layer insertSublayer:gradient atIndex:0];
        
    }
    
    //    self.gradent_label.textColor= [self setGradientCOlor];
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    NSLog(@"Picked Color Components: %.0f, %.0f, %.0f", red * 255.0f, green * 255.0f, blue * 255.0f);
}

-(IBAction)opacity_value_changed:(UISlider *)sender{
    
}



#pragma mark - New code

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self addToolsView];
        self.gradent_label.text = @"Hello";
        
        self.gradent_label.textColor = [UIColor colorWithPatternImage:[self gradientImage]];
        
    }
    return self;
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
