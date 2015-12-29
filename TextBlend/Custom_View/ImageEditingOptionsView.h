//
//  ImageEditingOptionsView.h
//  TextBlend
//
//  Created by Wayne Rooney on 05/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

//This class is responsible for handling all actions performed on the image editing view. These actions includes text edit of an image, add a new shape in existing image, add a quote, edit the photo using photo editing tool, add a saying, draw an object using a pencil on the image, add certain filters on the image, colorize an image and add different effects on the image. This class is a subclass of UIView.
//Delegate Functions used for handling button actions in the ImageEditingOptions View.


#import <UIKit/UIKit.h>
#import "CustomButton.h"
@class ImageEditingOptionsView;

@protocol ImageEditingOptionsDelegate <NSObject>

@optional

-(void)text_edit_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)shape_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)quotes_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)photo_edit_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)saying_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)draw_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)filters_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)colorize_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)effects_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

-(void)spalsh_button_pressed:(UIButton *)sender onSelectedView:(ImageEditingOptionsView *)selected_view;

@end

@interface ImageEditingOptionsView : UIView<UIScrollViewDelegate>{
    
}
@property(nonatomic,strong)UIScrollView *image_edit_scroll_view;
@property(nonatomic,strong)CustomButton *text_edit_button;
@property(nonatomic,strong)CustomButton *quotes_button;
@property(nonatomic,strong)CustomButton *saying_button;
@property(nonatomic,strong)CustomButton *filters_button;
@property(nonatomic,strong)CustomButton *effects_button;
@property(nonatomic,strong)CustomButton *shape_button;
@property(nonatomic,strong)CustomButton *photo_edit_button;
@property(nonatomic,strong)CustomButton *draw_button;
@property(nonatomic,strong)CustomButton *colorize_button;
@property(nonatomic,strong)CustomButton *spalsh_button;

@property(nonatomic,strong)id <ImageEditingOptionsDelegate> image_editing_options_delegate;


@end
