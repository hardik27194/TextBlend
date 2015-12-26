//
//  CustomizeImageViewController.h
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

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
@import GoogleMobileAds;


@interface CustomizeImageViewController : UIViewController<GADBannerViewDelegate,UIScrollViewDelegate,ImageEditingOptionsDelegate,CustomizeImageHeaderButtonsDelegate,AddTextViewDelegate,ZDStickerViewDelegate,SelectFontsViewDelegate,TextToolsDelegate,EraserDelegate,Rotate3DDelegate>
{
    AddTextView *add_text_view;
    SelectFontsView *select_fonts_view;
    TextToolsView *text_tools_view;
    AddColorView *add_color_view;
    Rotate3DView *rotate_3d_view;
    EraserView *eraser_view;

}
@property(nonatomic,strong)UIScrollView *scroll_view;
@property(nonatomic,strong)UIImage *selected_image;
@property(nonatomic,strong)ImageEditingOptionsView *image_editing_options_view;
@property(nonatomic,strong)InsertMessageTextView *message_editing_text_view;
@property(nonatomic,strong)GADBannerView *adBannerView;
@property(nonatomic,strong)CustomizeImageTopHeaderView *top_header_view;
@property(nonatomic,strong)ImageEditMainView *image_edit_main_view;
@property(nonatomic,assign)BOOL isFirstImageEditingOptionSelected;

@end
