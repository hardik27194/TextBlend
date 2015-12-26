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
#define HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW 145
#define CENTRE_FRAME CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)
#define BOTTOM_FRAME CGRectMake(0, SCREEN_HEIGHT-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW-50, SCREEN_WIDTH +(2*SCREEN_WIDTH)/3, HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)
@interface CustomizeImageViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) OHAttributedLabel *lblAdd;



@end

@implementation CustomizeImageViewController
@synthesize selected_image,scroll_view;
@synthesize image_editing_options_view,message_editing_text_view;
@synthesize adBannerView,top_header_view,image_edit_main_view;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializeView];
    [self initializeAdbannerView];

    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.image_edit_main_view.selected_image=self.selected_image;
    self.image_edit_main_view.main_image_view.image=self.selected_image;
    
}
-(void)initializeTopHeaderView{
    self.top_header_view = [[CustomizeImageTopHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.top_header_view.customize_screen_top_header_delegate=self;
    [self.scroll_view addSubview:self.top_header_view];
    
}
-(void)initializeView{
    
    self.scroll_view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scroll_view.delegate=self;
    self.scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.scroll_view];
    [self initializeTopHeaderView];
    [self initializeMainImageView];
    AppDel.mainLabelTag                                    = 499;
    AppDel.gloabalSelectedTag                            = 499;
    [self initailizeImageEditingOptionsView];
    //[self initailizeMessageTextView];
    
    
    
    UIPanGestureRecognizer *panRecognizer1               = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan1:)];
    [self.image_edit_main_view addGestureRecognizer:panRecognizer1];

//    UIPinchGestureRecognizer *pinch                      = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchLabel:)];
//    [self.image_edit_main_view addGestureRecognizer:pinch];

    
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
    
    
}

-(void)shape_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)quotes_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)photo_edit_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)saying_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)draw_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)filters_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)colorize_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)effects_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

-(void)spalsh_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view{
    
}

#pragma mark - Add Text View -

-(void)add_text_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{

    ZDStickerView *v        = [self func_createDefaultTextLabel:NEW_LABEL_DEFAULT_TEXT];
    [self handleTapToLabels:v.gestureRecognizers.firstObject];
}

-(void)fonts_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!select_fonts_view) {
        select_fonts_view=[[SelectFontsView alloc]initWithFrame:BOTTOM_FRAME];
        select_fonts_view.select_font_view_delegate=self;
        [self.view addSubview:select_fonts_view];
    }
}

-(void)text_tools_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!text_tools_view) {
        text_tools_view=[[TextToolsView alloc]initWithFrame:BOTTOM_FRAME];
        text_tools_view.text_tools_delegate=self;
        [self.view addSubview:text_tools_view];
    }
}

-(void)colors_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!add_color_view) {
        add_color_view=[[AddColorView alloc]initWithFrame:BOTTOM_FRAME];
//        add_color_view.text_tools_delegate=self;
        [self.view addSubview:add_color_view];
    }
}

-(void)rotate_3d_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!rotate_3d_view) {
        rotate_3d_view=[[Rotate3DView alloc]initWithFrame:BOTTOM_FRAME];
        rotate_3d_view.rotate_3d_delegate=self;
        [self.view addSubview:rotate_3d_view];
    }
}

-(void)eraser_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view{
    if (!eraser_view) {
        eraser_view=[[EraserView alloc]initWithFrame:BOTTOM_FRAME];
        eraser_view.eraser_delegate=self;
        [self.view addSubview:eraser_view];
    }
}

#pragma - Select Font - 
-(void)setFont:(UIFont*)font onSelectedView:(ZDStickerView *)selected_view;
{
    OHAttributedLabel *selectedLabel = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    
    NSAttributedString *str = selectedLabel.attributedText;
    
    [str enumerateAttributesInRange:NSMakeRange(0, [str length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop)
    {
         //Do something here
        UIFont *oldfont = [attributes objectForKey:NSFontAttributeName];
        if(!oldfont)
        {
            oldfont = [UIFont systemFontOfSize:12.0];
        }
        
        NSMutableDictionary *dic = [attributes mutableCopy];
        [dic setObject:[UIFont fontWithName:font.fontName size:oldfont.pointSize] forKey:NSFontAttributeName];
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str.string attributes:dic];
        
        [selectedLabel setAttributedText:attrString];
    
    
    }
     ];
    [selectedLabel setNeedsDisplay];
    
    ZDStickerView*v = [self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    [v setNeedsDisplay];
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

}
-(void)character_spacing_slider_value_changed:(UISlider *)slider onSelectedView:(TextToolsView *)selected_view
{
    float f;
    //    UISlider *slider                                     = (UISlider*)sender;
    f                                                           = slider.value;
    ZDStickerView *sticker                          = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    OHAttributedLabel *label                      = (OHAttributedLabel*)[sticker viewWithTag:AppDel.gloabalSelectedTag];
    
    
    NSMutableAttributedString *strattr                   = [NSMutableAttributedString attributedStringWithAttributedString:label.attributedText];
    [strattr setCharacterSpacing:f];
    
    label.attributedText                                 = strattr;
    [label setAccessibilityValue:[NSString stringWithFormat:@"%f",f]];
    
    CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width, 200000.0f);
    CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
    CGFloat height                                       = MAX(size.height, 14.0f);
    
    CGRect rect                                          = sticker.bounds;
    rect.size.height                                     = height;
    rect.size.width                                      = (isPad)?MIN(758.0, size.width):MIN(320.0, size.width);
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
    
    CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width, 200000.0f);
    CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
    CGFloat height                                       = MAX(size.height, 40.0f);
    
    CGRect rect                                          = sticker.bounds;
    rect.size.height                                     = height;
    rect.size.width                                      = (isPad)?MIN(758.0, size.width):MIN(320.0, size.width);
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
    
    [sticker setNeedsDisplay];
    [label setNeedsLayout];
    [self.image_edit_main_view setNeedsDisplay];



}
-(void)text_tools_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(TextToolsView *)selected_view{
    
}

#pragma mark - Eraser View Delegate Methods -

-(void)eraser_size_slider_value_changed:(UISlider *)slider onSelectedView:(EraserView *)selected_view{
    
}
-(void)eraser_intensity_slider_value_changed:(UISlider *)slider onSelectedView:(EraserView *)selected_view{
    
}
-(void)eraser_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(EraserView *)selected_view{
    
}
-(void)undo_last_erase_button_pressed:(UIButton *)sender onSelectedView:(EraserView *)selected_view{
    
}

#pragma mark - Rotate 3D Delegate Methods - 

-(void)rotate_3d_intensity_slider_value_changed:(UISlider *)slider onSelectedView:(Rotate3DView *)selected_view{
    
}
-(void)rotate_3d_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(Rotate3DView *)selected_view{
    
}
-(void)reset_3d_rotate_button_pressed:(UIButton *)sender onSelectedView:(Rotate3DView *)selected_view{
    
}
#pragma mark - ZDSticker View Delegate Methods -

- (void)stickerViewDidLongPressed:(ZDStickerView *)sticker
{
}

- (void)stickerViewDidClose:(ZDStickerView *)sticker
{
}

- (void)stickerViewDidCustomButtonTap:(ZDStickerView *)sticker
{
    [((UITextView*)sticker.contentView) becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *strMain                                    =  @"This is how the things will work for me." ;
    NSMutableAttributedString *strattr                   = [NSMutableAttributedString attributedStringWithString:strMain];

    [strattr modifyParagraphStylesWithBlock:^(OHParagraphStyle *paragraphStyle)
    {
        paragraphStyle.lineSpacing                           = 3.f;
    }];
    [strattr setCharacterSpacing:1.0];
    
    self.lblAdd.font                                         = [UIFont systemFontOfSize:20.0];
    self.lblAdd.opaque                                   = NO;
    self.lblAdd.backgroundColor                    = [UIColor clearColor];
    self.lblAdd.attributedText                         = strattr;
    self.lblAdd.textAlignment                            = NSTextAlignmentCenter;
    CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width, 200000.0f);
    CGSize size                                          = [strattr sizeConstrainedToSize:constraint];
    CGFloat height                                       = MAX(size.height, 14.0f);
    CGRect rect                                          = self.lblAdd.bounds;
    rect.size.height                                     = height;
    rect.size.width                                      = (isPad)?MIN(748.0, size.width):(isPad)?MIN(758.0, size.width):MIN(320.0, size.width);
    self.lblAdd.bounds                                   = rect;

    
    ZDStickerView *userResizableView1                    = [[ZDStickerView alloc] initWithFrame:self.lblAdd.frame];
    userResizableView1.tag                               = self.lblAdd.tag*5000;
    userResizableView1.delegate                          = self;
    userResizableView1.contentView1                      = self.lblAdd;//contentView;
    userResizableView1.preventsPositionOutsideSuperview  = NO;
    [userResizableView1 showEditingHandles];
    userResizableView1.center                            = CGPointMake(self.image_edit_main_view.center.x, self.image_edit_main_view.center.y);
    UIPinchGestureRecognizer *pinch                      = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchLabel:)];
    [userResizableView1 addGestureRecognizer:pinch];

    
    
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

-(void)addGesturesToView:(ZDStickerView*)sticker{
    UITapGestureRecognizer *gesture                      = [[UITapGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            
                                                            action:@selector(handleTapToLabels:)] ;
    gesture.numberOfTapsRequired                         = 1;
    [sticker addGestureRecognizer:gesture];
    
    
    UITapGestureRecognizer *gestureDoubleTap             = [[UITapGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            
                                                            action:@selector(handleDoubleTapToLabels:)] ;
    gestureDoubleTap.numberOfTapsRequired                = 2;
    [sticker addGestureRecognizer:gestureDoubleTap];
    [gesture requireGestureRecognizerToFail:gestureDoubleTap];
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

- (void)handlePinchLabel:(UIPinchGestureRecognizer *)recognizer
{
    OHAttributedLabel *label                             = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    ZDStickerView *sticker                               = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
//    NSString *fontName                               = label.font.fontName;
//    CGFloat fontSize                                     = label.font.pointSize;
   __block NSString *fontName;
   __block CGFloat fontSize;
    
    [label.attributedText enumerateAttributesInRange:NSMakeRange(0, [label.attributedText.string length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop)
     {
         //Do something here
         UIFont *oldfont = [attributes objectForKey:NSFontAttributeName];
         if(!oldfont)
         {
             oldfont = [UIFont systemFontOfSize:12.0];
         }
         fontName = oldfont.fontName;
         fontSize = oldfont.pointSize;
     }];
    
    
    if(recognizer.state == UIGestureRecognizerStateChanged){
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
        
        CGSize constraint                                    = CGSizeMake(self.image_edit_main_view.frame.size.width, 200000.0f);
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

-(void)handlePan1:(UIPanGestureRecognizer *)recognizer {
    
    OHAttributedLabel *label                             = (OHAttributedLabel*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag];
    ZDStickerView *sticker                               = (ZDStickerView*)[self.image_edit_main_view viewWithTag:AppDel.gloabalSelectedTag*5000];
    
    if (!label || !sticker) {
        return;
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
    
}

-(void)handleDoubleTapToLabels:(UIGestureRecognizer *)sender{
    
    NSLog(@"%@",sender.view);

    MessageTextViewController *message_text_vc=[[MessageTextViewController alloc]init];
    message_text_vc.view.backgroundColor=DARK_GRAY_COLOR;
    message_text_vc.custom_sticker=(ZDStickerView *)sender.view;
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



@end
