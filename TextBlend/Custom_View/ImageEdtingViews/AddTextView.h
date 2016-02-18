//
//  AddTextView.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

//This class consists of image editing functions like add text, font selection, color selection, 3d rotation and erase.This class is a subclass of UIView


@class AddTextView;
//Delegate Functions used for handling button actions in the AddTextView.

@protocol AddTextViewDelegate <NSObject>

@optional
-(void)add_text_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)fonts_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)text_tools_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)colors_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)rotate_3d_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)eraser_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;
-(void)shadow_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

@end


@interface AddTextView : UIView<UIScrollViewDelegate>{
  
    
}
@property(nonatomic,strong)UIScrollView *add_text_scroll_view;

@property(nonatomic,strong)CustomButton *add_text_button;
@property(nonatomic,strong)CustomButton *fonts_button;
@property(nonatomic,strong)CustomButton *text_tools_button;
@property(nonatomic,strong)CustomButton *colors_button;
@property(nonatomic,strong)CustomButton *rotate_3d_button;
@property(nonatomic,strong)CustomButton *eraser_button;
@property(nonatomic,strong)CustomButton *shadow_button;
@property(nonatomic,strong)CustomButton *misc_button;

@property(nonatomic,strong)id <AddTextViewDelegate> add_text_view_delegate;

@end
