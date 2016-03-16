//
//  CustomizeImageViewController.h
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

/*
 This class is the heart of the application. This screen is responsible for image editing related activity. This class is a subclass of ImageCropperViewController.

 */
#import <UIKit/UIKit.h>
#import "ImageEditingOptionsView.h"
#import "InsertMessageTextView.h"
#import "CustomizeImageTopHeaderView.h"
#import "ImageEditMainView.h"
#import "AddTextView.h"
#import "CustomZDStickerView.h"
#import "SelectFontsView.h"
#import "TextToolsView.h"
#import "AddColorView.h"
#import "Rotate3DView.h"
#import "EraserView.h"
#import "PhotoEditCustomView.h"
#import "ColorPaletteView.h"
#import "ShadowCustomView.h"
#import "ColorizeEffectView.h"
#import "FilterEffectCustomView.h"
#import "DrawingTool.h"
#import "FXEffectView.h"
@import GoogleMobileAds;


@interface CustomizeImageViewController : UIViewController<GADBannerViewDelegate,UIScrollViewDelegate,ImageEditingOptionsDelegate,CustomizeImageHeaderButtonsDelegate,AddTextViewDelegate,ZDStickerViewDelegate,SelectFontsViewDelegate,TextToolsDelegate,EraserDelegate,Rotate3DDelegate,PhotoEditToolOptionsDelegate,AddColorViewDelegate,ColorPaletteViewDelegate,ShadowToolsDelegate,ColorizeEffectDelegate,FilterEffectDelegate>
{
    AddTextView *add_text_view;
    SelectFontsView *select_fonts_view;
    TextToolsView *text_tools_view;
    AddColorView *add_color_view;
    Rotate3DView *rotate_3d_view;
    EraserView *eraser_view;
    PhotoEditCustomView *photo_edit_custom_view;
    ColorPaletteView *color_palette_view;
    ShadowCustomView *shadow_custom_view;
    ColorizeEffectView *colorize_effect_view;
    FilterEffectCustomView *filter_effect_view;
    FXEffectView *fx_effect_view;

    DrawingTool *drawing_view;
    

    
    CATransform3D rotationAndPerspectiveTransform1;
    CATransform3D rotationAndPerspectiveTransform2;
    CATransform3D rotationAndPerspectiveTransform3;

    CGFloat photo_edit_crop_slider_value;
    CGFloat photo_edit_tone_curve_slider_value;
    CGFloat photo_edit_blur_slider_value;
    CGFloat photo_edit_exposure_slider_value;
    CGFloat photo_edit_brightness_slider_value;
    CGFloat photo_edit_saturation_slider_value;
    CGFloat photo_edit_contrast_slider_value;

}
@property(nonatomic,strong)UIScrollView *scroll_view;
@property(nonatomic,strong)UIImage *selected_image;
@property(nonatomic,strong)ImageEditingOptionsView *image_editing_options_view;
@property(nonatomic,strong)InsertMessageTextView *message_editing_text_view;
@property(nonatomic,strong)GADBannerView *adBannerView;
@property(nonatomic,strong)CustomizeImageTopHeaderView *top_header_view;
@property(nonatomic,strong)ImageEditMainView *image_edit_main_view;
@property(nonatomic,assign)BOOL isFirstImageEditingOptionSelected;
@property(nonatomic,assign)BOOL isDrawOptionSelected;

-(void)initializeView;

@end
