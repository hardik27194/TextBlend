//
//  FXEffectSubSelectedView.m
//  TextBlend
//
//  Created by Itesh Dutt on 15/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "FXEffectSubSelectedView.h"
#import "ColorizeEffectCustomCollectionViewCell.h"
#import "Colours.h"
#import "UIImage+Utility.h"
#define WIDTH_OF_COLOR 60
#define CELL_ROW_HEIGHT self.frame.size.height-25
#define MAX_COLOR [UIColor grayColor]

@implementation FXEffectSubSelectedView
@synthesize black_view,done_check_mark_button;
@synthesize fx_effect_sub_selected_delegate;
@synthesize original_image;
@synthesize slider_1,slider_2;
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
    
    
}
-(void)removeSlider2{
    [self.slider_2 removeFromSuperview];
    self.slider_2 = nil;

}

-(void)initializeSelectedView{
    self.slider_1 = [[UISlider alloc]init];
    [self.slider_1 setFrame:CGRectZero];
    [self.slider_1 addTarget:self action:@selector(slider_1_value_changed:) forControlEvents:UIControlEventValueChanged];
    self.slider_1.frame = CGRectMake((SCREEN_WIDTH-200)/2, 25+((self.frame.size.height-30)/2), 200, 30);
    self.slider_1.continuous = NO;

    self.slider_1.maximumTrackTintColor = MAX_COLOR;

    [self addSubview:self.slider_1];

    self.slider_2 = [[UISlider alloc]init];
    [self.slider_2 setFrame:CGRectZero];
    [self.slider_2 addTarget:self action:@selector(slider_2_value_changed:) forControlEvents:UIControlEventValueChanged];
    self.slider_2.frame = CGRectMake((SCREEN_WIDTH-200)/2, 25+((self.frame.size.height-30)/2), 200, 30);
    self.slider_2.continuous = NO;

    self.slider_2.maximumTrackTintColor = MAX_COLOR;
    [self addSubview:self.slider_2];
    
    if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"hue"]) {

        [self removeSlider2];
        self.slider_1.minimumValue=-M_PI;
        self.slider_1.maximumValue=M_PI;
        self.slider_1.value=0;
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"highlight"]) {
        
        [self removeSlider2];
        self.slider_1.minimumValue=-1;
        self.slider_1.maximumValue=1;
        self.slider_1.value=0;
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"bloom"]) {
        
        self.slider_1.frame = CGRectMake((SCREEN_WIDTH-200)/2, 25+((self.frame.size.height-30)/2)-30, 200, 30);
        self.slider_2.frame = CGRectMake((SCREEN_WIDTH-200)/2, 25+((self.frame.size.height-30)/2)+20, 200, 30);

        
        //SLider 1 = radius
        //Slider 2 intensity
        self.slider_1.minimumValue=0;
        self.slider_1.maximumValue=1;
        self.slider_1.value=0.5;

        self.slider_2.minimumValue=0;
        self.slider_2.maximumValue=1;
        self.slider_2.value=1;

    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"gloom"]) {
        
        self.slider_1.frame = CGRectMake((SCREEN_WIDTH-200)/2, 25+((self.frame.size.height-30)/2)-30, 200, 30);
        self.slider_2.frame = CGRectMake((SCREEN_WIDTH-200)/2, 25+((self.frame.size.height-30)/2)+20, 200, 30);
        
        
        //SLider 1 = radius
        //Slider 2 intensity
        self.slider_1.minimumValue=0;
        self.slider_1.maximumValue=1;
        self.slider_1.value=0.5;
        
        self.slider_2.minimumValue=0;
        self.slider_2.maximumValue=1;
        self.slider_2.value=1;
        
    }
    
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"posterize"]) {
        
        [self removeSlider2];
        self.slider_1.minimumValue=-10;
        self.slider_1.maximumValue=-2;
        self.slider_1.value=-4;
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"pixellate"]) {
        
        [self removeSlider2];
        self.slider_1.minimumValue=0;
        self.slider_1.maximumValue=1;
        self.slider_1.value=0.5;
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"bump"]) {
        
        [self removeSlider2];
        self.slider_1.minimumValue=0;
        self.slider_1.maximumValue=100;
        self.slider_1.value=50;
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"splash"]) {
        
        [self removeSlider2];
        self.slider_1.minimumValue=2;
        self.slider_1.maximumValue=10;
        self.slider_1.value=5;
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"pinch"]) {
        
        [self removeSlider2];
        self.slider_1.minimumValue=1;
        self.slider_1.maximumValue=1000;
        self.slider_1.value=100;
        
    }

    [self slider_1_value_changed:slider_1];
}

#pragma mark - SLider Delegate Methods -

-(void)slider_1_value_changed:(UISlider *)slider{
    UIImage *image;
    if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"hue"]) {
        image=[self applyHueFilter:self.original_image];
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"highlight"]) {
        image=[self applyHighlightFilter:self.original_image];
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"bloom"]) {
        image=[self applyBloomEffect:self.original_image];

    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"gloom"]) {
        image=[self applyGloomEffect:self.original_image];
        
    }
    
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"posterize"]) {
        image=[self applyPosterizeEffect:self.original_image];
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"pixellate"]) {
        image=[self applyPixellateEffect:self.original_image];
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"bump"]) {
        image=[self applyBumpEffect:self.original_image];
        
    }

    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"splash"]) {
        image=[self applySplashEffect:self.original_image];
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"pinch"]) {
        image=[self applyPinchEffect:self.original_image];
        
    }
    [self setImageOnMainView:image];
}

-(void)slider_2_value_changed:(UISlider *)slider{
    UIImage *image;
    if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"bloom"]) {
        image=[self applyBloomEffect:self.original_image];
        
    }
    else if ([[self.selected_fx_filter_string lowercaseString]  isEqualToString:@"gloom"]) {
        image=[self applyGloomEffect:self.original_image];
        
    }
    [self setImageOnMainView:image];

}

#pragma mark - Misc Methods -

-(UIImage *)getImageForIndexPath:(NSIndexPath *)indexPath withOriginalImage:(UIImage *)image withFilterName:(NSString *)filterName{
    
    if (!image) {
        return nil;
    }
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"effects_%@_effect.png",[filterName lowercaseString]]];
    
}




-(NSString  *)getStringTitleForIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title_string;
       return title_string;
}

- (CGRect)clippingRectForTransparentSpace:(CGImageRef)inImage {
    CGFloat left, right, top, bottom;
    left = 0; right=0; top=0; bottom=0;
    
    CFDataRef m_DataRef = CGDataProviderCopyData(CGImageGetDataProvider(inImage));
    UInt8 * m_PixelBuf = (UInt8 *) CFDataGetBytePtr(m_DataRef);
    
    int width  = (int)CGImageGetWidth(inImage);
    int height = (int)CGImageGetHeight(inImage);
    
    BOOL breakOut = false;
    for (int x = 0; breakOut == false && x < width; ++x) {
        for (int y = 0; y < height; ++y) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_PixelBuf[loc + 3] != 0) {
                left = x;
                breakOut = true;
                break;
            }
        }
    }
    
    breakOut = false;
    for (int y = 0;  breakOut == false && y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_PixelBuf[loc + 3] != 0) {
                top = y;
                breakOut = true;
                break;
            }
            
        }
    }
    
    breakOut = false;
    for (int y = height-1;breakOut==false && y >= 0; --y) {
        for (int x = width-1; x >= 0; --x) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_PixelBuf[loc + 3] != 0) {
                bottom = y;
                breakOut = true;
                break;
            }
            
        }
    }
    
    breakOut = false;
    for (int x = width-1;breakOut==false && x >= 0; --x) {
        for (int y = height-1; y >= 0; --y) {
            int loc = x + (y * width);
            loc *= 4;
            if (m_PixelBuf[loc + 3] != 0) {
                right = x;
                breakOut = true;
                break;
            }
            
        }
    }
    
    CFRelease(m_DataRef);
    
    return CGRectMake(left, top, right-left, bottom-top);
}

#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.fx_effect_sub_selected_delegate respondsToSelector:@selector(fx_effect_sub_view_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.fx_effect_sub_selected_delegate fx_effect_sub_view_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}


#pragma mark - Select Color Palette View Delegate Methods -

-(void)setImageOnMainView:(UIImage *)image{
    if (!image) {
        return;
    }
    if ([self.fx_effect_sub_selected_delegate respondsToSelector:@selector(fx_effect_sub_view_set_image:onSelectedView:)]) {
        [self.fx_effect_sub_selected_delegate fx_effect_sub_view_set_image:image onSelectedView:self];
    }
    
}


-(void)select_color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectColorPaletteView *)selected_view{
    
    
    if ([self.fx_effect_sub_selected_delegate respondsToSelector:@selector(fx_effect_sub_view_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.fx_effect_sub_selected_delegate fx_effect_sub_view_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
    
}



#pragma mark - Apply Filters -


-(UIImage *)applyHighlightFilter:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    [filter setValue:[NSNumber numberWithFloat:slider_1.value] forKey:@"inputShadowAmount"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

-(UIImage *)applyHueFilter:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    [filter setValue:[NSNumber numberWithFloat:slider_1.value] forKey:@"inputAngle"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

                      
                      
- (UIImage*)applyBloomEffect:(UIImage*)image {
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIBloom" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    CGFloat R = slider_1.value * MIN(image.size.width, image.size.height) * 0.05;
    [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
    [filter setValue:[NSNumber numberWithFloat:slider_2.value] forKey:@"inputIntensity"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    CGFloat dW = (result.size.width - image.size.width)/2;
    CGFloat dH = (result.size.height - image.size.height)/2;
    
    CGRect rct = CGRectMake(dW, dH, image.size.width, image.size.height);
    
    return [result crop:rct];
}
- (UIImage*)applyGloomEffect:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIGloom" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    CGFloat R = slider_1.value * MIN(image.size.width, image.size.height) * 0.05;
    [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
    [filter setValue:[NSNumber numberWithFloat:slider_2.value] forKey:@"inputIntensity"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    CGFloat dW = (result.size.width - image.size.width)/2;
    CGFloat dH = (result.size.height - image.size.height)/2;
    
    CGRect rct = CGRectMake(dW, dH, image.size.width, image.size.height);
    
    return [result crop:rct];
}

- (UIImage*)applyPosterizeEffect:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorPosterize" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    [filter setValue:[NSNumber numberWithFloat:-slider_1.value] forKey:@"inputLevels"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

- (UIImage*)applyPixellateEffect:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    CGFloat R = MIN(image.size.width, image.size.height) * 0.1 * slider_1.value;
    CIVector *vct = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
    [filter setValue:vct forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputScale"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    CGRect clippingRect = [self clippingRectForTransparentSpace:cgImage];
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return [result crop:clippingRect];
}
- (UIImage*)applyBumpEffect:(UIImage*)image {
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIBumpDistortion" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    CIVector *vector = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
    [filter setValue:vector forKey:@"inputCenter"];
    
    [filter setValue:[NSNumber numberWithFloat:slider_1.value] forKey:@"inputRadius"];
    [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputScale"];
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return result;
}
- (UIImage*)applySplashEffect:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CICircularScreen" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    CIVector *vector = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
    [filter setValue:vector forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithFloat:0.3] forKey:@"inputSharpness"];
    [filter setValue:[NSNumber numberWithFloat:slider_1.value] forKey:@"inputWidth"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return result;
}

- (UIImage*)applyPinchEffect:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIPinchDistortion" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    CIVector *vector = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
    [filter setValue:vector forKey:@"inputCenter"];
    
    [filter setValue:[NSNumber numberWithFloat:0.3] forKey:@"inputScale"];
    [filter setValue:[NSNumber numberWithFloat:slider_1.value] forKey:@"inputRadius"];
    
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return result;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
