//
//  CustomizeImageViewController.m
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "CustomizeImageViewController.h"
#import "OHAttributedLabel.h"
#import "MessageTextViewController.h"
#import "ChooseShapeViewController.h"
#import "ChooseQuoteViewController.h"
#import "PurchaseFontsViewController.h"
#define HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW 145
#define CENTRE_FRAME CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)
#define BOTTOM_FRAME CGRectMake(0, SCREEN_HEIGHT-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW-50, SCREEN_WIDTH +(2*SCREEN_WIDTH)/3, HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)
@interface CustomizeImageViewController ()<UIScrollViewDelegate>
{
    UIFont *initial_selected_font_for_purchase;
    
}
@property (strong, nonatomic) OHAttributedLabel *lblAdd;
@end

@implementation CustomizeImageViewController
@synthesize selected_image,scroll_view;
@synthesize image_editing_options_view,message_editing_text_view;
@synthesize adBannerView,top_header_view,image_edit_main_view;
@synthesize isFirstImageEditingOptionSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeToIntitalFontAfterPurchaseFailNotification:) name:SELECT_INITIAL_FONT_NOTIFICATION object:nil];
    
//    [self initializeView];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.image_edit_main_view.selected_image=self.selected_image;
//    self.image_edit_main_view.main_image_view.image=self.selected_image;
    
}
-(void)initializeTopHeaderView{
    self.top_header_view = [[CustomizeImageTopHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.top_header_view.customize_screen_top_header_delegate=self;
    [self.scroll_view addSubview:self.top_header_view];
    self.top_header_view.next_button.hidden=YES;
    self.top_header_view.share_button.hidden=YES;
    self.top_header_view.settings_button.hidden=YES;
    
    
}
-(void)initializeView{
    
    self.scroll_view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scroll_view.delegate=self;
    self.scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.scroll_view];
    [self initializeMainImageView];
    AppDel.mainLabelTag                                    = 499;
    AppDel.gloabalSelectedTag                            = 499;
    [self initailizeImageEditingOptionsView];
    //[self initailizeMessageTextView];
    
    [self initializeTopHeaderView];
    [self initializeAdbannerView];

    
    
    UIPanGestureRecognizer *panRecognizer1               = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan1:)];
    [self.image_edit_main_view addGestureRecognizer:panRecognizer1];
    
        UIPinchGestureRecognizer *pinch                      = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchLabel:)];
        [self.image_edit_main_view addGestureRecognizer:pinch];
    
    rotationAndPerspectiveTransform1 = CATransform3DIdentity;
    rotationAndPerspectiveTransform2 = CATransform3DIdentity;
    rotationAndPerspectiveTransform3 = CATransform3DIdentity;

}

-(void)initializeMainImageView
{
    self.image_edit_main_view = [[ImageEditMainView alloc]initWithFrame:CENTRE_FRAME];
    self.image_edit_main_view.hasSelectedImage = YES;
    self.image_edit_main_view.selected_image=self.selected_image;
    [self.image_edit_main_view initializeView];
    [self.scroll_view addSubview:self.image_edit_main_view];
    
}

-(void)initailizeImageEditingOptionsView{
    
    if (!image_editing_options_view) {
        image_editing_options_view=[[ImageEditingOptionsView alloc]initWithFrame:BOTTOM_FRAME];
        image_editing_options_view.image_editing_options_delegate=self;
        [self.scroll_view addSubview:self.image_editing_options_view];
    }
    
}

-(void)initializeAdbannerView{
    
    
    UIView *banner_view=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    banner_view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:banner_view];
    
    UILabel *banner_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 50)];
    banner_label.text=@"ADMOB BANNER";
    banner_label.textColor=[UIColor whiteColor];
    banner_label.textAlignment=NSTextAlignmentCenter;
    [banner_view addSubview:banner_label];
    
    /*
     self.adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
     self.adBannerView.delegate=self;
     self.adBannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
     self.adBannerView.rootViewController = self;
     [self.adBannerView loadRequest:[GADRequest request]];
     [self.view addSubview:self.adBannerView];
     */
    
}

-(void)initailizeMessageTextView{
    
    if (!self.message_editing_text_view) {
        self.message_editing_text_view=[[InsertMessageTextView alloc]initWithFrame:CENTRE_FRAME];
        [self.scroll_view addSubview:self.message_editing_text_view];
    }
    
}


#pragma mark - Banner View Delegate -

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    bannerView.hidden = NO;
    
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{
    
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView{
    
}

- (void)adViewWillDismissScreen:(GADBannerView *)bannerView{
    
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{
    
}

#pragma mark - Customize Top Header Delegate Methods -

-(void)back_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
       
    if (isFirstImageEditingOptionSelected) {
        
        [self removeAllSubviews];
        
        isFirstImageEditingOptionSelected=NO;
        return;
    }
    
    if(self.isDrawOptionSelected)
    {
        for(UIGestureRecognizer*recoganizer in self.image_edit_main_view.gestureRecognizers)
        {
            if([recoganizer isKindOfClass:[UIPanGestureRecognizer class]])
            {
                [recoganizer setEnabled:YES];
            }
        }        self.isDrawOptionSelected = NO;
        [drawing_view cleanup];
        [drawing_view removeFromSuperview];
        drawing_view = nil;
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)share_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)settings_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)moveToMessageEditingView{
    CGRect message_editing_text_view_frame=self.message_editing_text_view.frame;
    message_editing_text_view_frame.origin.x=SCREEN_WIDTH;
    self.message_editing_text_view.frame=message_editing_text_view_frame;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect message_view_frame=self.message_editing_text_view.frame;
        message_view_frame.origin.x=0;
        self.message_editing_text_view.frame=message_view_frame;
        
        CGRect image_edit_main_view_frame=self.image_edit_main_view.frame;
        image_edit_main_view_frame.origin.x=-SCREEN_WIDTH;
        self.image_edit_main_view.frame=image_edit_main_view_frame;
        
        
    } completion:^(BOOL finished) {
        [self.message_editing_text_view.message_text_view becomeFirstResponder];
        
    }];
    
}
#pragma mark - ImageEditingOptionsDelegate -

-(void)text_edit_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
    if (!add_text_view) {
        add_text_view=[[AddTextView alloc]initWithFrame:BOTTOM_FRAME];
        add_text_view.add_text_view_delegate=self;
        [self.view addSubview:add_text_view];
    }
    isFirstImageEditingOptionSelected=YES;
    [self.view bringSubviewToFront:add_text_view];
    
    BOOL hasAlreadyAddedStickerView = [self checkIfViewHasAlreadyAddedStickerView];
    if (!hasAlreadyAddedStickerView) {
        ZDStickerView *v        = [self func_createDefaultTextLabel:NEW_LABEL_DEFAULT_TEXT];
        [self handleTapToLabels:v.gestureRecognizers.firstObject];
        v.preventsPositionOutsideSuperview=YES;
    }
    
    
}

-(void)shape_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(add_image_notification:) name:UPDATE_IMAGE_STICKER_VIEW_NOTIFICATION object:nil];
    
    ChooseShapeViewController *choose_shape_vc=[[ChooseShapeViewController alloc]init];
    choose_shape_vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:choose_shape_vc animated:YES];
    
}

-(void)quotes_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(add_image_notification:) name:UPDATE_IMAGE_STICKER_VIEW_NOTIFICATION object:nil];
    
    ChooseQuoteViewController *choose_quote_vc=[[ChooseQuoteViewController alloc]init];
    choose_quote_vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:choose_quote_vc animated:YES];

}

-(void)photo_edit_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
    if (!photo_edit_custom_view) {
        photo_edit_custom_view=[[PhotoEditCustomView alloc]initWithFrame:BOTTOM_FRAME];
        photo_edit_custom_view.photo_edit_tool_options_delegate=self;
        
        photo_edit_custom_view.photo_edit_crop_slider_value = photo_edit_crop_slider_value;
        photo_edit_custom_view.photo_edit_tone_curve_slider_value = photo_edit_tone_curve_slider_value;
        photo_edit_custom_view.photo_edit_blur_slider_value = photo_edit_blur_slider_value;
        photo_edit_custom_view.photo_edit_exposure_slider_value = photo_edit_exposure_slider_value;
        photo_edit_custom_view.photo_edit_brightness_slider_value = photo_edit_brightness_slider_value;
        photo_edit_custom_view.photo_edit_saturation_slider_value = photo_edit_saturation_slider_value;
        photo_edit_custom_view.photo_edit_contrast_slider_value = photo_edit_contrast_slider_value;

        [self.view addSubview:photo_edit_custom_view];
    }
    isFirstImageEditingOptionSelected=YES;
    [self.view bringSubviewToFront:photo_edit_custom_view];
}

-(void)saying_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(add_image_notification:) name:UPDATE_IMAGE_STICKER_VIEW_NOTIFICATION object:nil];
    
    ChooseQuoteViewController *choose_quote_vc=[[ChooseQuoteViewController alloc]init];
    choose_quote_vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:choose_quote_vc animated:YES];
}

-(void)draw_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view
{
    for(UIGestureRecognizer*recoganizer in self.image_edit_main_view.gestureRecognizers)
    {
        if([recoganizer isKindOfClass:[UIPanGestureRecognizer class]])
        {
            [recoganizer setEnabled:NO];
        }
    }

    if (!drawing_view)
    {
        drawing_view=[[DrawingTool alloc]initWithFrame:BOTTOM_FRAME];
        [self.view addSubview:drawing_view];
        drawing_view.imageEditorVw = self.image_edit_main_view;
        [drawing_view setup];
        drawing_view.parentController = self;
    }
    self.isDrawOptionSelected = YES;
}

-(void)filters_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    if (!filter_effect_view)
    {
        filter_effect_view=[[FilterEffectCustomView alloc]initWithFrame:BOTTOM_FRAME];
        filter_effect_view.filter_effect_delegate=self;
        filter_effect_view.original_image= [Utility decode:self.image_edit_main_view.selected_image];
        [filter_effect_view.custom_collection_view reloadData];
        [self.view addSubview:filter_effect_view];
    }
    isFirstImageEditingOptionSelected=YES;
    [self.view bringSubviewToFront:filter_effect_view];

}

-(void)colorize_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
    if (!colorize_effect_view) {
        colorize_effect_view=[[ColorizeEffectView alloc]initWithFrame:BOTTOM_FRAME];
        colorize_effect_view.colorize_effect_delegate=self;
        colorize_effect_view.original_image= [Utility decode:self.image_edit_main_view.selected_image];
        [colorize_effect_view.custom_collection_view reloadData];
        [self.view addSubview:colorize_effect_view];
    }
    isFirstImageEditingOptionSelected=YES;
    [self.view bringSubviewToFront:colorize_effect_view];

    
}

-(void)effects_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    if (!fx_effect_view)
    {
        fx_effect_view=[[FXEffectView alloc]initWithFrame:BOTTOM_FRAME];
        fx_effect_view.fx_effect_delegate=self;
        fx_effect_view.original_image= [Utility decode:self.image_edit_main_view.selected_image];
        [fx_effect_view.custom_collection_view reloadData];
        [self.view addSubview:fx_effect_view];
    }
    isFirstImageEditingOptionSelected=YES;
    [self.view bringSubviewToFront:fx_effect_view];

}

-(void)spalsh_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

#pragma mark - Add Text View -

-(void)add_text_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    
    ZDStickerView *v        = [self func_createDefaultTextLabel:NEW_LABEL_DEFAULT_TEXT];
    [self handleTapToLabels:v.gestureRecognizers.firstObject];
    v.preventsPositionOutsideSuperview=YES;
}

-(void)fonts_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!select_fonts_view) {
        select_fonts_view=[[SelectFontsView alloc]initWithFrame:BOTTOM_FRAME];
        select_fonts_view.select_font_view_delegate=self;
        select_fonts_view.selected_sticker_view=[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
        
        
        [self.view addSubview:select_fonts_view];
    }
    OHAttributedLabel *selectedLabel = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    
    NSAttributedString *str = selectedLabel.attributedText;
    
    [str enumerateAttributesInRange:NSMakeRange(0, [str length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop)
     {
         //Do something here
         UIFont *oldfont = [attributes objectForKey:NSFontAttributeName];
         initial_selected_font_for_purchase=oldfont;
         
     }];

    [self.view bringSubviewToFront:select_fonts_view];
    
}

-(void)text_tools_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!text_tools_view) {
        text_tools_view=[[TextToolsView alloc]initWithFrame:BOTTOM_FRAME];
        text_tools_view.text_tools_delegate=self;
        text_tools_view.selected_sticker_view=[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
        [text_tools_view initializeWithDefaultValues];

        [self.view addSubview:text_tools_view];
    }
    [self.view bringSubviewToFront:text_tools_view];
    
}

-(void)colors_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    
    
     if (!add_color_view) {
     add_color_view=[[AddColorView alloc]initWithFrame:BOTTOM_FRAME];
     add_color_view.add_color_view_delegate = self;
     add_color_view.selected_sticker_view=[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    [add_color_view initializeWithDefaultValues];

    [self.view addSubview:add_color_view];
     }
     [self.view bringSubviewToFront:add_color_view];
    
}

-(void)rotate_3d_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!rotate_3d_view) {
        rotate_3d_view=[[Rotate3DView alloc]initWithFrame:BOTTOM_FRAME];
        rotate_3d_view.rotate_3d_delegate=self;
        rotate_3d_view.selected_sticker_view=[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
        [rotate_3d_view initializeWithDefaultValues];
        [self.view addSubview:rotate_3d_view];
    }
    [self.view bringSubviewToFront:rotate_3d_view];
    
}

-(void)eraser_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
//    if (!eraser_view) {
//        eraser_view=[[EraserView alloc]initWithFrame:BOTTOM_FRAME];
//        eraser_view.eraser_delegate=self;
//        [self.view addSubview:eraser_view];
//    }
//    [self.view bringSubviewToFront:eraser_view];
   
    if (!color_palette_view) {
        color_palette_view=[[ColorPaletteView alloc]initWithFrame:BOTTOM_FRAME];
        color_palette_view.color_palette_view_delegate=self;
        color_palette_view.selected_sticker_view=[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];

        [self.view addSubview:color_palette_view];
    }
    [self.view bringSubviewToFront:color_palette_view];

}

-(void)shadow_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!shadow_custom_view) {
        shadow_custom_view=[[ShadowCustomView alloc]initWithFrame:BOTTOM_FRAME];
        shadow_custom_view.shadow_tools_delegate=self;
        shadow_custom_view.selected_sticker_view=[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
        [shadow_custom_view initializeWithDefaultValues];

        [self.view addSubview:shadow_custom_view];
    }
    [self.view bringSubviewToFront:shadow_custom_view];
}


#pragma mark - Color Palette View Methods -

-(void)setSelectedColor:(UIColor*)color onSelectedView:(ColorPaletteView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view{

    if (!sticker_view) {
        return;
    }
    
    [self setSelectedOnStickerView:sticker_view withColor:color];
}

-(void)color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(ColorPaletteView *)selected_view{
    if (color_palette_view) {
        [color_palette_view removeFromSuperview];
        color_palette_view=  nil;
    }

}

#pragma mark - Add Color Delegate -

/*
- (UIImage *)gradientImagewithStartColor:(UIColor*)startColor andEndColor:(UIColor*)endColor withRotationAngle:(CGFloat)rotationAngle
{
    
    ZDStickerView *sticker                          = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    OHAttributedLabel *label = (OHAttributedLabel*)sticker.contentView1;
    
    CGSize textSize = label.frame.size;
    CGFloat width = textSize.width;
    CGFloat height = textSize.height;
    
    // create a new bitmap image contextk
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // push context to make it current (need to do this manually because we are not drawing in a UIView)
    UIGraphicsPushContext(context);
    
    //draw gradient
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 3;
    
    
    
    endColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    const CGFloat *componentsStartColor= CGColorGetComponents(startColor.CGColor);
    CGFloat Startred                                         = componentsStartColor[0];
    CGFloat Startgreen                                      = componentsStartColor[1];
    CGFloat Startblue                                        = componentsStartColor[2];
    
    
    const CGFloat *componentsEndColor= CGColorGetComponents(endColor.CGColor);
    CGFloat endRed                                         = componentsEndColor[0];
    CGFloat endGreen                                      = componentsEndColor[1];
    CGFloat endBlue                                        = componentsEndColor[2];
    
    UIColor *green_color = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    
    const CGFloat *componentsEndColor1= CGColorGetComponents(green_color.CGColor);
    CGFloat endRed1                                         = componentsEndColor1[0];
    CGFloat endGreen1                                      = componentsEndColor1[1];
    CGFloat endBlue1                                        = componentsEndColor1[2];
    
    
    
    
    CGFloat locations[3] = { 0.0,0.5, 1.0 };
    CGFloat components[12] = {Startred, Startgreen, Startblue, 1.0, endRed1,endGreen1,endBlue1,1.0, // Start color
        endRed, endGreen, endBlue, 1.0}; // End color
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    
    // Apply Rotation for Linear Gradient.
    CGFloat degree = rotationAngle * M_PI / 180;
    CGPoint center = CGPointMake(width/2, height/2);
    CGPoint startPoint = CGPointMake(center.x - cos (degree) * width/2, center.y - sin(degree) * height/2);
    CGPoint endPoint = CGPointMake(center.x + cos (degree) * width/2, center.y + sin(degree) * height/2);
    
    // Pass the generated Start Point and End Point. Try to Rotate.
    CGContextDrawLinearGradient(context, glossGradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    // pop context
    UIGraphicsPopContext();
    // get a UIImage from the image context
    UIImage *gradientImageToReturn = UIGraphicsGetImageFromCurrentImageContext();
    // clean up drawing environment
    UIGraphicsEndImageContext();
    return  gradientImageToReturn;
}
*/
-(void)updateViewWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor withPercenatgeValue:(CGFloat)percentage onSelectedView:(AddColorView *)selected_view withCurrentDirection:(CGFloat)directionValue
{
    //Update values

    ZDStickerView *sticker                          = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];

    OHAttributedLabel *label = (OHAttributedLabel*)sticker.contentView1;
    NSMutableAttributedString* string = label.attributedText.mutableCopy;
    [string setTextColor:[UIColor colorWithPatternImage:[self gradientImagewithStartColor:startColor andEndColor:endColor withRotationAngle:directionValue withPercenatgeValue:percentage]]];
    label.gradient_start_color=startColor;
    label.gradient_end_color=endColor;
    label.gradient_direction_slider_value = directionValue;
    [label setAttributedText:string];
    
}
-(void)add_color_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(AddColorView *)selected_view{
    
    if (add_color_view) {
        [add_color_view removeFromSuperview];
        add_color_view=  nil;
    }
    
}


-(void)add_color_set_selected_single_text_color:(UIColor *)color on_sticker_view:(ZDStickerView *)sticker_view onSelectedView:(AddColorView *)selected_view{
    
    if (!sticker_view) {
        return;
    }
    
    [self setSelectedOnStickerView:sticker_view withColor:color];
    
}

- (UIImage *)gradientImagewithStartColor:(UIColor*)startColor andEndColor:(UIColor*)endColor withRotationAngle:(CGFloat)rotationAngle withPercenatgeValue:(CGFloat)percentage
{
    
    ZDStickerView *sticker                          = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    OHAttributedLabel *label = (OHAttributedLabel*)sticker.contentView1;

    CGSize textSize = label.frame.size;
    CGFloat width = textSize.width;
    CGFloat height = textSize.height;
    
    // create a new bitmap image contextk
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // push context to make it current (need to do this manually because we are not drawing in a UIView)
    UIGraphicsPushContext(context);
    
    //draw gradient
    CGGradientRef glossGradient;
    glossGradient = [Utility getGradientSpaceRef:startColor andEndColor:endColor withPercenatgeValue:percentage*10];
    // Apply Rotation for Linear Gradient.
    CGFloat degree = rotationAngle * M_PI / 180;
    CGPoint center = CGPointMake(width/2, height/2);
    CGPoint startPoint = CGPointMake(center.x - cos (degree) * width/2, center.y - sin(degree) * height/2);
    CGPoint endPoint = CGPointMake(center.x + cos (degree) * width/2, center.y + sin(degree) * height/2);
    
    // Pass the generated Start Point and End Point. Try to Rotate.
    CGContextDrawLinearGradient(context, glossGradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(glossGradient);
    // pop context
    UIGraphicsPopContext();
    // get a UIImage from the image context
    UIImage *gradientImageToReturn = UIGraphicsGetImageFromCurrentImageContext();
    // clean up drawing environment
    UIGraphicsEndImageContext();
    return  gradientImageToReturn;
}

-(void)rotateGradientByAngle:(UISlider*)slider
{
    ZDStickerView *sticker                          = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    OHAttributedLabel *label = (OHAttributedLabel*)sticker.contentView1;
    
    [label setTextColor:[UIColor colorWithPatternImage:[self gradientImagewithStartColor:[UIColor redColor] andEndColor:[UIColor blueColor] withRotationAngle:slider.value withPercenatgeValue:0.9]]];
}

#pragma mark - Select Font Delegate Methods  -
-(void)setFont:(UIFont*)font onSelectedView:(ZDStickerView *)selected_view;
{
    if (!selected_view) {
        return;
    }
    
    OHAttributedLabel *selectedLabel = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    
    NSAttributedString *str = selectedLabel.attributedText;
    
    [str enumerateAttributesInRange:NSMakeRange(0, [str length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop)
     {
         //Do something here
         UIFont *oldfont = [attributes objectForKey:NSFontAttributeName];
         if(!oldfont)
         {
             oldfont = [UIFont boldSystemFontOfSize:25.0f];
         }
         
         NSMutableDictionary *dic = [attributes mutableCopy];
         [dic setObject:[UIFont fontWithName:font.fontName size:oldfont.pointSize] forKey:NSFontAttributeName];
         
         NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str.string attributes:dic];
         
         [selectedLabel setAttributedText:attrString];
         [selectedLabel setNeedsDisplay];
         
         
         ZDStickerView*v = [self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
         
         CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width-20, 200000.0f);
         CGSize size                                          = [selectedLabel.attributedText sizeConstrainedToSize:constraint];
         CGFloat height                                       = MAX(size.height, 14.0f);
         
         CGRect rect                                          = v.bounds;
         rect.size.height                                     = height;
         rect.size.width                                      = (isPad)?MIN(758.0, size.width):MIN(self.image_edit_main_view.frame.size.width-20, size.width);
         v.bounds                                       = rect;
         [v setNeedsDisplay];
         
     }];
    
}


-(void)select_font_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectFontsView *)selected_view{
    initial_selected_font_for_purchase=nil;
    if (select_fonts_view) {
        [select_fonts_view removeFromSuperview];
        select_fonts_view=  nil;
    }
    
}

#pragma mark - PhotoEditToolOptionsDelegate Methods -

-(void)photo_edit_tool_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{
    
    if (photo_edit_custom_view) {
        [photo_edit_custom_view removeFromSuperview];
        photo_edit_custom_view  = nil;
    }
}

-(void)crop_image_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{
    
}
-(void)brightness_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{
    
}

-(void)tone_curve_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{
    
}
-(void)saturation_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{
    
}


-(void)blur_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{
    
}
-(void)contrast_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{
    
}
-(void)exposure_button_pressed:(UIButton *)sender onSelectedView:(PhotoEditCustomView *)selected_view{

}
#pragma mark - Photo Edit view Slider Delegate Methods -


-(void)photo_edit_tone_curve_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view{
    photo_edit_tone_curve_slider_value=slider.value;

}

-(void)photo_edit_crop_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view{
    photo_edit_crop_slider_value=slider.value;

}
-(void)blur_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view
{
    photo_edit_blur_slider_value=slider.value;

    CGFloat blurLevel = MIN(1.0, MAX(0.0, slider.value));
    
    int boxSize = (int)(blurLevel * 0.1 * MIN(self.image_edit_main_view.main_image_view.image.size.width, self.image_edit_main_view.main_image_view.image.size.height));
    boxSize = boxSize - (boxSize % 2) + 1;
    
    NSData *imageData = UIImageJPEGRepresentation(self.selected_image, 1);
    UIImage *tmpImage = [UIImage imageWithData:imageData];
    
    CGImageRef img = tmpImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    NSInteger windowR = boxSize/2;
    CGFloat sig2 = windowR / 3.0;
    if(windowR>0){ sig2 = -1/(2*sig2*sig2); }
    
    int16_t *kernel = (int16_t*)malloc(boxSize*sizeof(int16_t));
    int32_t  sum = 0;
    for(NSInteger i=0; i<boxSize; ++i){
        kernel[i] = 255*exp(sig2*(i-windowR)*(i-windowR));
        sum += kernel[i];
    }
    
    // convolution
    error = vImageConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, kernel, boxSize, 1, sum, NULL, kvImageEdgeExtend);
    error = vImageConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, kernel, 1, boxSize, sum, NULL, kvImageEdgeExtend);
    outBuffer = inBuffer;
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGBitmapAlphaInfoMask & kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    self.image_edit_main_view.main_image_view.image = returnImage;
}
-(void)contrast_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view
{
    
    photo_edit_contrast_slider_value=slider.value;

    CIImage *ciImage = [[CIImage alloc] initWithImage:self.selected_image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    
    filter = [CIFilter filterWithName:@"CIGammaAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    CGFloat contrast   = slider.value*slider.value;
    [filter setValue:[NSNumber numberWithFloat:contrast] forKey:@"inputPower"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    self.image_edit_main_view.main_image_view.image = result;
    
}
-(void)exposure_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view
{
    photo_edit_exposure_slider_value=slider.value;

    CIImage *ciImage = [[CIImage alloc] initWithImage:self.selected_image];
    CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    CGFloat exposure = slider.value;
    [filter setValue:[NSNumber numberWithFloat:exposure] forKey:@"inputEV"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    self.image_edit_main_view.main_image_view.image = result;
    
}



-(void)saturation_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view{
    photo_edit_saturation_slider_value=slider.value;

    CIImage *ciImage = [[CIImage alloc] initWithImage:self.selected_image];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    [filter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputSaturation"];
    
    filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    
    filter = [CIFilter filterWithName:@"CIGammaAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    self.image_edit_main_view.main_image_view.image = result;
    
}
-(void)brightness_sliderValueChanged:(UISlider *)slider onSelectedView:(PhotoEditCustomView *)selected_view
{
    photo_edit_brightness_slider_value=slider.value;
    CIImage *ciImage = [[CIImage alloc] initWithImage:selected_image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    
    CGFloat brightness = 2*slider.value;
    [filter setValue:[NSNumber numberWithFloat:brightness] forKey:@"inputEV"];
    
    filter = [CIFilter filterWithName:@"CIGammaAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    self.image_edit_main_view.main_image_view.image = result;
    
}
#pragma mark - Colorize View Delegate Methods -

-(void)colorize_effect_set_image:(UIImage *)image onSelectedView:(ColorizeEffectView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view{
    
    self.image_edit_main_view.selected_image = image;
    self.selected_image = image;
    self.image_edit_main_view.main_image_view.image=image;

}
-(void)colorize_effect_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(ColorizeEffectView *)selected_view{
    
    if (colorize_effect_view) {
        [colorize_effect_view removeFromSuperview];
        colorize_effect_view =  nil;
    }
}

#pragma mark - Filter Effect Delegate Methods -
-(void)filter_effect_set_image:(UIImage *)image onSelectedView:(FilterEffectCustomView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view{
    
    self.image_edit_main_view.selected_image = image;
    self.selected_image = image;
    self.image_edit_main_view.main_image_view.image=image;
    
}
-(void)filter_effect_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(FilterEffectCustomView *)selected_view{
    
    if (filter_effect_view) {
        [filter_effect_view removeFromSuperview];
        filter_effect_view =  nil;
    }
}

#pragma mark - FX Effect Delegate Methods -

-(void)fx_effect_set_image:(UIImage *)image onSelectedView:(FXEffectView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view{
    
    self.image_edit_main_view.selected_image = image;
    self.selected_image = image;
    self.image_edit_main_view.main_image_view.image=image;
    
}
-(void)fx_effect_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(FXEffectView *)selected_view{
    if (fx_effect_view) {
        [fx_effect_view removeFromSuperview];
        fx_effect_view =  nil;
    }
}
#pragma mark - Text Tools View Delegate Methods -

-(void)opacity_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view
{
    float f;
    //    UISlider *slider                                     = (UISlider*)sender;
    f                                                    = 1-slider.value;
    
    OHAttributedLabel *selectedLabel                     = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    
    if(selectedLabel != nil)
    {
        NSString *checkColor                                 = selectedLabel.accessibilityHint;
        selectedLabel.text_tool_opacity_slider_value=slider.value;
        if([checkColor isEqualToString:@"Image"])
        {/*
          UIImage *img                                         = _patternFinalImage;
          //UIImage *new = [img imageWithAlpha:f];
          NSString *fontName                                   = selectedLabel.font.fontName;
          selectedLabel.font                                   = [UIFont fontWithName:fontName size:selectedLabel.font.pointSize];
          
          NSMutableAttributedString *strattr                   = [NSMutableAttributedString attributedStringWithAttributedString:selectedLabel.attributedText];
          selectedLabel.textColor                              = [[UIColor colorWithPatternImage:img] colorWithAlphaComponent:f];
          [strattr setFontName:fontName size:selectedLabel.font.pointSize];
          [strattr setTextColor:[[UIColor colorWithPatternImage:img] colorWithAlphaComponent:f]];
          selectedLabel.attributedText                         = strattr;
          [self.image_edit_main_view setNeedsDisplay];
          */
        }
        else
        {
            //            const CGFloat *components                            = CGColorGetComponents(selectedLabel.textColor.CGColor);
            //            CGFloat red                                         = components[0];
            //            CGFloat green                                      = components[1];
            //            CGFloat blue                                        = components[2];
            //
            //            NSMutableAttributedString *strattr                   = [NSMutableAttributedString attributedStringWithAttributedString:selectedLabel.attributedText];
            //            if(selectedLabel.isIn3DMode)
            //            {
            //                if(f<0.3)
            //                {
            //                    f                                                    = 0.3;
            //                }
            //            }
            //            [strattr setTextColor:[UIColor colorWithRed:red green:green blue:blue alpha:f]];
            //            selectedLabel.textColor                              = [UIColor colorWithRed:red green:green blue:blue alpha:f];
            //            selectedLabel.attributedText                         = strattr;
            
            [selectedLabel setAlpha:f];
            [self.image_edit_main_view setNeedsDisplay];
        }
    }
}

-(void)curve_slider_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view
{
    
    OHAttributedLabel *selectedLabel                     = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    
    if(selectedLabel != nil)
    {

    selectedLabel.text_tool_curve_slider_value=slider.value;
    }

}
-(void)character_spacing_slider_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view
{
    float f;
    //    UISlider *slider                                     = (UISlider*)sender;
    f                                                           = slider.value;
    ZDStickerView *sticker                          = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    OHAttributedLabel *label                      = (OHAttributedLabel*)[sticker viewWithTag:AppDel.gloabalSelectedTag];
    
    label.text_tool_character_spacing_slider_value=slider.value;

    NSMutableAttributedString *strattr                   = [NSMutableAttributedString attributedStringWithAttributedString:label.attributedText];
    [strattr setCharacterSpacing:f];
    
    label.attributedText                                 = strattr;
    [label setAccessibilityValue:[NSString stringWithFormat:@"%f",f]];
    
    CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width-20, 200000.0f);
    CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
    CGFloat height                                       = MAX(size.height, 14.0f);
    
    CGRect rect                                          = sticker.bounds;
    rect.size.height                                     = height;
    rect.size.width                                      = (isPad)?MIN(758.0, size.width):MIN(self.image_edit_main_view.frame.size.width-20, size.width);
    sticker.bounds                                       = rect;
    
    sticker.deltaAngle                                   = atan2(sticker.frame.origin.y+sticker.bounds.size.height - sticker.center.y,
                                                                 sticker.frame.origin.x+sticker.bounds.size.width - sticker.center.x);
    [sticker setNeedsDisplay];
    
    
    CGPoint originalCenter                               = CGPointApplyAffineTransform(label.center,
                                                                                       CGAffineTransformInvert(label.transform));
    
    CGPoint topLeft                                      = originalCenter;
    topLeft.x                                            -= label.bounds.size.width / 2;
    topLeft.y                                            -= label.bounds.size.height / 2;
    
    for(UIView *v in self.image_edit_main_view.subviews){
        if([v isKindOfClass:[ZDStickerView class]]){
            ZDStickerView *sticker                               = (ZDStickerView*)v;
            if(sticker.tag == AppDel.gloabalSelectedTag*5000){
                [sticker showEditingHandles];
            }else{
                [sticker hideEditingHandles];
            }
        }
    }
    
    [sticker setNeedsDisplay];
    [self.image_edit_main_view setNeedsDisplay];
    
    
    
}
-(void)line_spacing_slider_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view
{
    
    CGFloat f;
    //    UISlider *slider                                     = (UISlider*)sender;
    f                                                    = slider.value;
    
    OHAttributedLabel *label                             = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    ZDStickerView *sticker                               = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    label.text_tool_line_spacing_slider_value=slider.value;

    NSMutableAttributedString *strattr                   = [NSMutableAttributedString attributedStringWithAttributedString:label.attributedText];
    [strattr modifyParagraphStylesWithBlock:^(OHParagraphStyle *paragraphStyle) {
        if(label.isIn3DMode){
            
            paragraphStyle.maximumLineHeight                     = 0;
            
        }
        else
        {
            if(f > 18.0){
                paragraphStyle.maximumLineHeight                     = f;
            }
        }
        
        paragraphStyle.lineSpacing                           = f;
        
    }];
    
    label.attributedText                                 = strattr;
    
    [label setAccessibilityIdentifier:[NSString stringWithFormat:@"%f",f]];
    
    CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width-20, 200000.0f);
    CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
    CGFloat height                                       = MAX(size.height, 40.0f);
    
    CGRect rect                                          = sticker.bounds;
    rect.size.height                                     = height;
    rect.size.width                                      = (isPad)?MIN(758.0, size.width):MIN(self.image_edit_main_view.frame.size.width-20, size.width);
    sticker.bounds                                       = rect;
    
    sticker.deltaAngle                                   = atan2(sticker.frame.origin.y+sticker.bounds.size.height - sticker.center.y,
                                                                 sticker.frame.origin.x+sticker.bounds.size.width - sticker.center.x);
    
    for(UIView *v in self.image_edit_main_view.subviews){
        if([v isKindOfClass:[ZDStickerView class]]){
            ZDStickerView *sticker                               = (ZDStickerView*)v;
            if(sticker.tag == AppDel.gloabalSelectedTag*5000){
                [sticker showEditingHandles];
            }else{
                [sticker hideEditingHandles];
            }
        }
    }
    
    [label setNeedsLayout];
    [sticker setNeedsDisplay];
    [self.image_edit_main_view setNeedsDisplay];
    
    
    
}
-(void)text_tools_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(TextToolsView *)selected_view{
    
    if (text_tools_view) {
        [text_tools_view removeFromSuperview];
        text_tools_view =  nil;
    }
}

#pragma mark - Eraser View Delegate Methods -

-(void)eraser_size_slider_value_changed:(UISlider *)slider onSelectedView:(EraserView *)selected_view{
    
}
-(void)eraser_intensity_slider_value_changed:(UISlider *)slider onSelectedView:(EraserView *)selected_view{
    
}
-(void)eraser_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(EraserView *)selected_view{
    if (eraser_view) {
        [eraser_view removeFromSuperview];
        eraser_view=  nil;
    }
}
-(void)undo_last_erase_button_pressed:(UIButton *)sender onSelectedView:(EraserView *)selected_view{
    
}

#pragma mark - Rotate 3D Delegate Methods -

-(void)rotate_3d_intensity_slider_valueX_changed:(UISlider *)slider onSelectedView:(Rotate3DView *)selected_view
{
/* ZdSticker */
 ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    if(sticker == nil)
    {
        return;
    }
    sticker.rotate_3d_x_coordinate_slider_value=slider.value;
    sticker.layer.zPosition = 300;
    CALayer *layer = sticker.layer;
    rotationAndPerspectiveTransform1 = CATransform3DIdentity;
    rotationAndPerspectiveTransform1.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform1 = CATransform3DRotate(rotationAndPerspectiveTransform1, slider.value* M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = CATransform3DConcat(CATransform3DConcat(rotationAndPerspectiveTransform1, rotationAndPerspectiveTransform2), rotationAndPerspectiveTransform3);
}

-(void)rotate_3d_intensity_slider_valueY_changed:(UISlider *)slider onSelectedView:(Rotate3DView *)selected_view
{
    /* ZdSticker */
    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    sticker.layer.zPosition = 300;

    if(sticker == nil)
    {
        return;
    }
    sticker.rotate_3d_y_coordinate_slider_value=slider.value;

    CALayer *layer = sticker.layer;
    rotationAndPerspectiveTransform2 = CATransform3DIdentity;
    rotationAndPerspectiveTransform2.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform2 = CATransform3DRotate(rotationAndPerspectiveTransform2, slider.value* M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    layer.transform = CATransform3DConcat(CATransform3DConcat(rotationAndPerspectiveTransform1, rotationAndPerspectiveTransform2), rotationAndPerspectiveTransform3);}

-(void)rotate_3d_intensity_slider_valueZ_changed:(UISlider *)slider onSelectedView:(Rotate3DView *)selected_view
{
    /* ZdSticker */
    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    sticker.layer.zPosition = 300;

    if(sticker == nil)
    {
        return;
    }
    sticker.rotate_3d_z_coordinate_slider_value=slider.value;

    CALayer *layer = sticker.layer;
    rotationAndPerspectiveTransform3 = CATransform3DIdentity;
    rotationAndPerspectiveTransform3.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform3 = CATransform3DRotate(rotationAndPerspectiveTransform3, slider.value* M_PI / 180.0f, 0.0f, 0.0f, 1.0f);
    layer.transform = CATransform3DConcat(CATransform3DConcat(rotationAndPerspectiveTransform1, rotationAndPerspectiveTransform2), rotationAndPerspectiveTransform3);
}



-(void)rotate_3d_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(Rotate3DView *)selected_view{
    if (rotate_3d_view) {
        [rotate_3d_view removeFromSuperview];
        rotate_3d_view=  nil;
    }
}
-(void)reset_3d_rotate_button_pressed:(UIButton *)sender onSelectedView:(Rotate3DView *)selected_view
{
    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
//    CALayer *layer                                       = sticker.layer;

    rotationAndPerspectiveTransform1 = CATransform3DIdentity;
    rotationAndPerspectiveTransform2 = CATransform3DIdentity;
    rotationAndPerspectiveTransform3 = CATransform3DIdentity;
    
    [selected_view.intensity_sliderX setValue:0.0];
    [selected_view.intensity_sliderY setValue:0.0];
    [selected_view.intensity_sliderZ setValue:0.0];
    
    sticker.rotate_3d_x_coordinate_slider_value=0;
    sticker.rotate_3d_y_coordinate_slider_value=0;
    sticker.rotate_3d_z_coordinate_slider_value=0;

   sticker.layer.transform =  CATransform3DConcat(CATransform3DConcat(rotationAndPerspectiveTransform1, rotationAndPerspectiveTransform2), rotationAndPerspectiveTransform3);
}

#pragma mark - Shadow Tools Delegate Methods -
-(void)opacity_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view
{
    
    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    if (!sticker) {
        return;
    }
    sticker.shadow_opacity_slider_value=slider.value;
    [sticker.layer setShadowOpacity:slider.value];


}

-(void)blur_radius_slider_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view
{
    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    if (!sticker) {
        return;
    }
    sticker.shadow_blur_slider_value=slider.value;
    [sticker.layer setShadowRadius:slider.value];
    
}

-(void)x_position_slider_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view
{
    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    if (!sticker) {
        return;
    }
    sticker.shadow_x_position_slider_value=slider.value;
    [sticker.layer setShadowOffset:CGSizeMake(slider.value, selected_view.y_position_slider.value)];
}

-(void)y_position_slider_value_changed_shadow_view:(UISlider *)slider onSelectedView:(ShadowCustomView *)selected_view
{
    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    if (!sticker) {
        return;
    }
    sticker.shadow_y_position_slider_value=slider.value;
    [sticker.layer setShadowOffset:CGSizeMake(selected_view.x_position_slider.value, slider.value)];
}

-(void)shadow_tools_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(ShadowCustomView *)selected_view{
    if (shadow_custom_view) {
        [shadow_custom_view removeFromSuperview];
        shadow_custom_view=  nil;
    }

}
-(void)shadow_tools_color_selection:(UIColor *)selected_color onSelectedView:(ShadowCustomView *)selected_view{

    ZDStickerView *sticker = (ZDStickerView*)[self.image_edit_main_view  viewWithTag:AppDel.gloabalSelectedTag*5000];
    sticker.layer.shadowColor = selected_color.CGColor;
    
    
}

#pragma mark - ZDSticker View Delegate Methods -

- (void)stickerViewDidLongPressed:(ZDStickerView *)sticker
{
}

- (void)stickerViewDidClose:(ZDStickerView *)sticker
{
    OHAttributedLabel *label                             = (OHAttributedLabel *)[self.image_edit_main_view viewWithTag:sticker.tag/5000];
    
    [label   removeFromSuperview];
    [sticker removeFromSuperview];
    
    [self.image_edit_main_view setNeedsDisplay];
    
}

- (void)stickerViewDidCustomButtonTap:(ZDStickerView *)sticker
{
    [((UITextView*)sticker.contentView) becomeFirstResponder];
}

#pragma mark - Sukhi Starts here -

-(ZDStickerView *)func_createDefaultTextLabel:(NSString*)text{
    
    self.lblAdd                                          = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    self.lblAdd.isIn3DMode                               = NO;
    [self.lblAdd setAccessibilityIdentifier:[NSString stringWithFormat:@"%d",10]];
    [self.lblAdd setAccessibilityValue:[NSString stringWithFormat:@"%d",10]];
    [self.lblAdd setAccessibilityHint:@"Color"];
    self.lblAdd.userInteractionEnabled                   = YES;
    self.lblAdd.numberOfLines                            = 0;
    self.lblAdd.lineBreakMode                            = NSLineBreakByWordWrapping;
    self.lblAdd.tag                                              = AppDel.mainLabelTag;
    self.lblAdd.clipsToBounds                             = NO;
    
    AppDel.gloabalSelectedTag                            = AppDel.mainLabelTag;
    AppDel.mainLabelTag++;
    
    NSString *strMain                                    =  @"Double tap to edit text" ;
    NSMutableAttributedString *strattr                   = [NSMutableAttributedString attributedStringWithString:strMain];
    
    [strattr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,strattr.length)];
    
    [strattr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:32.0f] range:NSMakeRange(0,strattr.length)];
    
    
    [strattr modifyParagraphStylesWithBlock:^(OHParagraphStyle *paragraphStyle)
     {
         paragraphStyle.lineSpacing                           = 3.f;
     }];
    [strattr setCharacterSpacing:1.0];
    
    self.lblAdd.opaque                                   = NO;
    self.lblAdd.backgroundColor                    = [UIColor clearColor];
    self.lblAdd.attributedText                         = strattr;
    self.lblAdd.textAlignment                            = NSTextAlignmentCenter;
    CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width-20, 200000.0f);
    CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
    CGFloat height                                       = MAX(size.height, 14.0f);
    CGRect rect                                          = self.lblAdd.bounds;
    rect.size.height                                     = height;
    rect.size.width                                      = (isPad)?MIN(748.0, size.width):(isPad)?MIN(758.0, size.width):MIN(self.image_edit_main_view.frame.size.width-20, size.width);
    self.lblAdd.bounds                                   = rect;
    
    
    ZDStickerView *userResizableView1                    = [[ZDStickerView alloc] initWithFrame:self.lblAdd.frame];
    userResizableView1.tag                               = self.lblAdd.tag*5000;
    userResizableView1.delegate                          = self;
    userResizableView1.contentView1                      = self.lblAdd;//contentView;
    userResizableView1.preventsPositionOutsideSuperview  = NO;
    [userResizableView1 showEditingHandles];
    userResizableView1.center                            = CGPointMake(self.image_edit_main_view.center.x, self.image_edit_main_view.center.y);
//    UIPinchGestureRecognizer *pinch                      = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchLabel:)];
//    [userResizableView1 addGestureRecognizer:pinch];
    
    
    
    for(UIView *v in image_edit_main_view.subviews)
    {
        if([v isKindOfClass:[ZDStickerView class]])
        {
            ZDStickerView *sticker = (ZDStickerView*)v;
            if(sticker.tag ==  (AppDel.gloabalSelectedTag*5000))
            {
                [sticker showEditingHandles];
            }
            else
            {
                [sticker hideEditingHandles];
            }
        }
    }
    
    [self addGesturesToView:userResizableView1];
    [userResizableView1 setNeedsDisplay];
    [self.image_edit_main_view addSubview:userResizableView1];
    
    
    AppDel.gloabalSelectedTag                            = userResizableView1.tag/5000;
    [self.image_edit_main_view setNeedsDisplay];
    return userResizableView1;
}

-(void)addGesturesToView:(ZDStickerView*)sticker
{
    UITapGestureRecognizer *gesture                      = [[UITapGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            
                                                            action:@selector(handleTapToLabels:)] ;
    gesture.numberOfTapsRequired                         = 1;
    [sticker addGestureRecognizer:gesture];
    
    if([sticker.contentView1 isKindOfClass:[OHAttributedLabel class]])
    {
    UITapGestureRecognizer *gestureDoubleTap             = [[UITapGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            
                                                            action:@selector(handleDoubleTapToLabels:)] ;
    gestureDoubleTap.numberOfTapsRequired                = 2;
    [sticker addGestureRecognizer:gestureDoubleTap];
    [gesture requireGestureRecognizerToFail:gestureDoubleTap];
    }
}

-(void)handleTapToLabels:(UITapGestureRecognizer*)recognizer{
    
    ZDStickerView *sticker                               = (ZDStickerView*)recognizer.view;
    AppDel.gloabalSelectedTag                            = sticker.tag/5000;
    OHAttributedLabel *selectedLabel                     = (OHAttributedLabel*)[sticker viewWithTag:AppDel.gloabalSelectedTag];
    sticker.deltaAngle                                   = atan2(sticker.frame.origin.y+sticker.bounds.size.height - sticker.center.y,
                                                                 sticker.frame.origin.x+sticker.bounds.size.width - sticker.center.x);
    [sticker setNeedsDisplay];
    CGPoint originalCenter                               = CGPointApplyAffineTransform(selectedLabel.center,
                                                                                       CGAffineTransformInvert(selectedLabel.transform));
    
    CGPoint topLeft                                      = originalCenter;
    topLeft.x                                            -= selectedLabel.bounds.size.width / 2;
    topLeft.y                                            -= selectedLabel.bounds.size.height / 2;
    
    for(UIView *v in self.image_edit_main_view.subviews){
        if([v isKindOfClass:[ZDStickerView class]]){
            ZDStickerView *lbl                                   = (ZDStickerView*)v;
            if(lbl.tag == AppDel.gloabalSelectedTag*5000){
                [lbl showEditingHandles];
            }
            else
            {
                [lbl hideEditingHandles];
            }
            
        }
    }
}

-(ZDStickerView *)func_createDefaultImageSticker:(UIImage*)image{
    
    UIImageView *imageHolder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [imageHolder setContentMode:UIViewContentModeScaleAspectFit];
    [imageHolder setImage:image];
    AppDel.gloabalSelectedTag                            = AppDel.mainLabelTag;
    AppDel.mainLabelTag++;
    [imageHolder setTag:AppDel.gloabalSelectedTag];
    
    
    
    ZDStickerView *userResizableView1                    = [[ZDStickerView alloc] initWithFrame:imageHolder.frame];
    userResizableView1.tag                               = imageHolder.tag*5000;
    userResizableView1.delegate                          = self;
    userResizableView1.contentView1                      = imageHolder;//contentView;
    userResizableView1.preventsPositionOutsideSuperview  = NO;
    [userResizableView1 showEditingHandles];
    userResizableView1.center                            = CGPointMake(self.image_edit_main_view.center.x, self.image_edit_main_view.center.y);
    
    for(UIView *v in image_edit_main_view.subviews)
    {
        if([v isKindOfClass:[ZDStickerView class]])
        {
            ZDStickerView *sticker = (ZDStickerView*)v;
            if(sticker.tag ==  (AppDel.gloabalSelectedTag*5000))
            {
                [sticker showEditingHandles];
            }
            else
            {
                [sticker hideEditingHandles];
            }
        }
    }
    
    [self addGesturesToView:userResizableView1];
    [userResizableView1 setNeedsDisplay];
    [self.image_edit_main_view addSubview:userResizableView1];
    
    AppDel.gloabalSelectedTag                            = userResizableView1.tag/5000;
    [self.image_edit_main_view setNeedsDisplay];
    return userResizableView1;
}


- (void)handlePinchLabel:(UIPinchGestureRecognizer *)recognizer
{
    OHAttributedLabel *label                             = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    if(![label isKindOfClass:[OHAttributedLabel class]])
    {
        return;
    }
        ZDStickerView *sticker                               = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];

    __block NSString *fontName;
    __block CGFloat fontSize;
    
    [label.attributedText enumerateAttributesInRange:NSMakeRange(0, [label.attributedText.string length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop)
     {
         //Do something here
         UIFont *oldfont = [attributes objectForKey:NSFontAttributeName];
         if(!oldfont)
         {
             oldfont = [UIFont boldSystemFontOfSize:25.0f];
         }
         fontName = oldfont.fontName;
         fontSize = oldfont.pointSize;
     }];
    
    if(recognizer.state == UIGestureRecognizerStateBegan && [self.image_edit_main_view.gridLayer isHidden])
    {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        } completion:^(BOOL finished)
         {
             [self.image_edit_main_view.gridLayer setHidden:NO];
         }];
    }

    
    if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat factor                                       = [(UIPinchGestureRecognizer *)recognizer scale];
        if(factor > 1.0)
        {
            fontSize +=(isPad)?3:3;
        }
        else
        {
            fontSize                                             -= (isPad)?3:3;
        }
        if(isPad){
            if (fontSize >180) {
                return;
            }
        }else{
            if (fontSize >130) {
                return;
            }
        }
        
        
        if (fontSize <10) {
            return;
        }
        //        _zoomSlider.value                                    = fontSize;
        
        //        label.font                                           = [UIFont fontWithName:label.font.fontName size:fontSize];
        
        NSMutableAttributedString *strattr                   =[NSMutableAttributedString attributedStringWithAttributedString:label.attributedText];
        [strattr setFontName:fontName size:fontSize];
        label.attributedText                                 = strattr;
        
        CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width-20, 200000.0f);
        CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
        CGFloat height                                       = MAX(size.height, 14.0f);
        
        CGRect rect                                          = sticker.bounds;
        rect.size.height                                     = height;
        rect.size.width                                      = (isPad)?MIN(758.0, size.width):MIN(self.image_edit_main_view.frame.size.width-20, size.width);
        sticker.bounds                                       = rect;
        
        
        for(UIView *v in self.image_edit_main_view.subviews){
            if([v isKindOfClass:[ZDStickerView class]]){
                ZDStickerView *sticker                               = (ZDStickerView*)v;
                if(sticker.tag == AppDel.gloabalSelectedTag*5000){
                    [sticker showEditingHandles];
                }else{
                    [sticker hideEditingHandles];
                }
            }
        }
        sticker.deltaAngle                                   = atan2(sticker.frame.origin.y+sticker.bounds.size.height - sticker.center.y,
                                                                     sticker.frame.origin.x+sticker.bounds.size.width - sticker.center.x);
        [sticker setNeedsDisplay];
        
        
        [sticker setNeedsDisplay];
        [self.image_edit_main_view setNeedsDisplay];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if(![self.image_edit_main_view.gridLayer isHidden])
        {
            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            } completion:^(BOOL finished)
             {
                 [self.image_edit_main_view.gridLayer setHidden:YES];
             }];
        }

    }
}

-(void)handlePan1:(UIPanGestureRecognizer *)recognizer
{
    
    OHAttributedLabel *label                             = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    ZDStickerView *sticker                               = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    
    if (!label || !sticker) {
        return;
    }
    
    if(recognizer.state == UIGestureRecognizerStateBegan && [self.image_edit_main_view.gridLayer isHidden])
    {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        } completion:^(BOOL finished)
         {
             [self.image_edit_main_view.gridLayer setHidden:NO];

         }];
    }
    
    CGPoint translation                                  = [recognizer translationInView:self.image_edit_main_view];
    
    
    
    sticker.center                                       = CGPointMake(sticker.center.x + translation.x,
                                                                       sticker.center.y + translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.image_edit_main_view];
    
    
    CGPoint originalCenter                               = CGPointApplyAffineTransform(label.center,
                                                                                       CGAffineTransformInvert(label.transform));
    
    CGPoint topLeft                                      = originalCenter;
    topLeft.x                                            -= label.bounds.size.width / 2;
    topLeft.y                                            -= label.bounds.size.height / 2;
    
    for(UIView *v in self.image_edit_main_view.subviews){
        if([v isKindOfClass:[ZDStickerView class]]){
            ZDStickerView *sticker                               = (ZDStickerView*)v;
            if(sticker.tag == AppDel.gloabalSelectedTag*5000){
                [sticker showEditingHandles];
            }else{
                [sticker hideEditingHandles];
            }
        }
    }
    
    sticker.deltaAngle                                   = atan2(sticker.frame.origin.y+sticker.bounds.size.height - sticker.center.y,
                                                                 sticker.frame.origin.x+sticker.bounds.size.width - sticker.center.x);
    [sticker setNeedsDisplay];
    
    [self.image_edit_main_view setNeedsDisplay];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if(![self.image_edit_main_view.gridLayer isHidden])
        {
            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            } completion:^(BOOL finished)
             {
                 [self.image_edit_main_view.gridLayer setHidden:YES];
             }];
        }
        
    }
    
    
}

-(void)handleDoubleTapToLabels:(UIGestureRecognizer *)sender{
    
    NSLog(@"%@",sender.view);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(update_text_and_alignment_notification:) name:UPDATE_MESSAGE_TEXT_NOTIFICATION object:nil];
    ZDStickerView *sticker_view=(ZDStickerView *)sender.view;
    OHAttributedLabel *label=[self.view viewWithTag:sticker_view.tag/5000];//=
    NSString *text;
    if (label && ![label isEqual:[NSNull null]]) {
        text=label.attributedText.string;
        
    }
    
    MessageTextViewController *message_text_vc=[[MessageTextViewController alloc]init];
    message_text_vc.view.backgroundColor=DARK_GRAY_COLOR;
    message_text_vc.custom_sticker=(ZDStickerView *)sender.view;
    if (text.length && ![text isEqualToString:@"Double tap to edit text"]) {
        message_text_vc.message_text_view.text=text;
        
    }
    [self.navigationController pushViewController:message_text_vc animated:YES];
    
    /*
     NSLog(@"%@",sender.view);
     [self initailizeMessageTextView];
     
     [UIView animateWithDuration:0.3 animations:^{
     self.scroll_view.contentOffset=CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT);
     
     [self.message_editing_text_view.message_text_view becomeFirstResponder];
     }];
     */
    
    
}

-(void)updateZDStickerViewDetails:(NSNotification *)notification{
    
}

#pragma mark - Misc Functions -


-(void)removeAllSubviews{
    [add_text_view removeFromSuperview];
    add_text_view = nil;
    
    [photo_edit_custom_view removeFromSuperview];
    photo_edit_custom_view  = nil;
    
    [select_fonts_view removeFromSuperview];
    select_fonts_view =nil;
    
    if (add_color_view) {
        [add_color_view removeFromSuperview];
        add_color_view = nil;
    }
    
    
    if (text_tools_view) {
        [text_tools_view removeFromSuperview];
        text_tools_view = nil;
    }
    
    
    if (rotate_3d_view) {
        [rotate_3d_view removeFromSuperview];
        rotate_3d_view = nil;
    }
    
    
    if (eraser_view) {
        [eraser_view removeFromSuperview];
        eraser_view = nil;
    }
    
    if (color_palette_view) {
        [color_palette_view removeFromSuperview];
        color_palette_view = nil;
    }
    
    if (shadow_custom_view) {
        [shadow_custom_view removeFromSuperview];
        shadow_custom_view = nil;
    }
    if (colorize_effect_view) {
        if (colorize_effect_view.original_image) {
            self.image_edit_main_view.selected_image = colorize_effect_view.original_image;
            self.selected_image = colorize_effect_view.original_image;
            self.image_edit_main_view.main_image_view.image=colorize_effect_view.original_image;

        }
        [colorize_effect_view removeFromSuperview];
        colorize_effect_view = nil;
    }
    
    
    if (filter_effect_view) {
        if (filter_effect_view.original_image) {
            self.image_edit_main_view.selected_image = filter_effect_view.original_image;
            self.selected_image = filter_effect_view.original_image;
            self.image_edit_main_view.main_image_view.image=filter_effect_view.original_image;
            
        }
        [filter_effect_view removeFromSuperview];
        filter_effect_view = nil;
    }
    
    
    if (fx_effect_view) {
        if (fx_effect_view.original_image) {
            self.image_edit_main_view.selected_image = fx_effect_view.original_image;
            self.selected_image = fx_effect_view.original_image;
            self.image_edit_main_view.main_image_view.image=fx_effect_view.original_image;
            
        }
        [fx_effect_view removeFromSuperview];
        fx_effect_view = nil;
    }
    
    
    
}

-(void)setSelectedOnStickerView:(ZDStickerView *)sticker_view withColor:(UIColor*)color{
    OHAttributedLabel *selected_label=   (OHAttributedLabel*)sticker_view.contentView1;
    
    NSMutableAttributedString *res = [selected_label.attributedText mutableCopy];
    
    [res beginEditing];
    __block BOOL found = NO;
    [res enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(0, res.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value) {
            //            UIColor *oldColor = (UIColor *)value;
            //            UIColor *newColor = color;
            [res removeAttribute:NSForegroundColorAttributeName range:range];
            [res addAttribute:NSForegroundColorAttributeName value:color range:range];
            found = YES;
        }
    }];
    if (!found) {
        // No font was found - do something else?
    }
    [res endEditing];
    selected_label.attributedText = res;
    [selected_label setNeedsDisplay];
    [sticker_view setNeedsDisplay];
    
}




-(BOOL)checkIfViewHasAlreadyAddedStickerView{
    
    BOOL hasAlreadyAddedStickerView=NO;
    for (id object in self.image_edit_main_view.subviews) {
        
        if ([object isKindOfClass:[ZDStickerView class]]) {
            hasAlreadyAddedStickerView = YES;
            break;
        }
    }
    
    return hasAlreadyAddedStickerView;
    
}
#pragma mark - Notification Methods -


-(void)update_text_and_alignment_notification:(NSNotification *)notification{
    // NSLog(@"%@",notification);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UPDATE_MESSAGE_TEXT_NOTIFICATION object:nil];
    
    if ([notification.object valueForKey:@"TEXT_VIEW"] && [notification.object valueForKey:@"ZD_STICKER_VIEW"]) {
        UITextView *text_view=[notification.object valueForKey:@"TEXT_VIEW"];
        
        ZDStickerView *sticker=[notification.object valueForKey:@"ZD_STICKER_VIEW"];
        OHAttributedLabel *label=(OHAttributedLabel *)[self.view viewWithTag:sticker.tag/5000];
        
        __block NSMutableDictionary *attributes_dict;
        [label.attributedText enumerateAttributesInRange:NSMakeRange(0, [label.attributedText.string length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
         ^(NSDictionary *attributes, NSRange range, BOOL *stop)
         {
             //Do something here
             //NSLog(@"%@",attributes);
             //              NSForegroundColorAttributeName : color
             attributes_dict = [attributes mutableCopy];
             if ([[notification.object valueForKey:@"ZD_STICKER_VIEW_TEXT_COLOR"]isKindOfClass:[UIColor class]]) {
                 [attributes_dict setValue:[notification.object valueForKey:@"ZD_STICKER_VIEW_TEXT_COLOR"] forKey:NSForegroundColorAttributeName];
             }
             
         }];
        
        
        //        NSMutableAttributedString *strattr                   =[NSMutableAttributedString attributedStringWithAttributedString:label.attributedText ];
        NSMutableAttributedString *strattr                   =[[NSMutableAttributedString alloc ]initWithString:text_view.text attributes:attributes_dict];
        
        
        [strattr modifyParagraphStylesWithBlock:^(OHParagraphStyle *paragraphStyle)
         {
             if (text_view.textAlignment == NSTextAlignmentRight ) {
                 paragraphStyle.textAlignment = kCTTextAlignmentRight;
                 
             }
             else if (text_view.textAlignment == NSTextAlignmentRight ) {
                 paragraphStyle.textAlignment = kCTTextAlignmentCenter;
                 
             }
             else
                 paragraphStyle.textAlignment = kCTTextAlignmentLeft;
             
         }];
        
        label.attributedText                                 = strattr;
        
        CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width-20, 200000.0f);
        CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
        CGFloat height                                       = MAX(size.height, 14.0f);
        
        CGRect rect                                          = sticker.bounds;
        rect.size.height                                     = height;
        rect.size.width                                      = (isPad)?MIN(758.0, size.width):MIN(320.0, size.width);
        sticker.bounds                                       = rect;
        
        
        for(UIView *v in self.image_edit_main_view.subviews){
            if([v isKindOfClass:[ZDStickerView class]]){
                ZDStickerView *sticker                               = (ZDStickerView*)v;
                if(sticker.tag == AppDel.gloabalSelectedTag*5000){
                    [sticker showEditingHandles];
                }else{
                    [sticker hideEditingHandles];
                }
            }
        }
        sticker.deltaAngle                                   = atan2(sticker.frame.origin.y+sticker.bounds.size.height - sticker.center.y,
                                                                     sticker.frame.origin.x+sticker.bounds.size.width - sticker.center.x);
        [sticker setNeedsDisplay];
        
        
        [sticker setNeedsDisplay];
        [self.image_edit_main_view setNeedsDisplay];
        
        
    }
    
}



-(void)add_image_notification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UPDATE_IMAGE_STICKER_VIEW_NOTIFICATION object:nil];
    
    if ([notification.object valueForKey:@"ZD_STICKER_VIEW_IMAGE"]) {
        UIImage *image=[notification.object valueForKey:@"ZD_STICKER_VIEW_IMAGE"];
        if (image)
        {
            [self func_createDefaultImageSticker:image];
        }
    }
}


-(void)getAllAttributes:(OHAttributedLabel *)selected_label withStickerView:(ZDStickerView *)selected_sticker_view{
    NSMutableAttributedString *res = [selected_label.attributedText mutableCopy];
    
    [res beginEditing];
    __block BOOL found = NO;
    [res enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, res.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            UIFont *newFont = [oldFont fontWithSize:oldFont.pointSize * 2];
            [res removeAttribute:NSFontAttributeName range:range];
            [res addAttribute:NSFontAttributeName value:newFont range:range];
            found = YES;
        }
    }];
    if (!found) {
        // No font was found - do something else?
    }
    [res endEditing];
    selected_label.attributedText = res;
    [selected_label setNeedsDisplay];
    [selected_sticker_view setNeedsDisplay];
    
}
-(void)changeToIntitalFontAfterPurchaseFailNotification:(NSNotification *)notificaton{
    
    if (!initial_selected_font_for_purchase) {
        return;
    }
    ZDStickerView *sticker                          = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    if (!sticker) {
        return;
    }
    
    [self setFont:initial_selected_font_for_purchase onSelectedView:sticker];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
