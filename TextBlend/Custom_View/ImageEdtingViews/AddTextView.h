//
//  AddTextView.h
//  TextBlend
//
//  Created by Itesh Dutt on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@class AddTextView;

@protocol AddTextViewDelegate <NSObject>

@optional
-(void)add_text_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)fonts_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)text_tools_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)colors_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)rotate_3d_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;

-(void)eraser_button_pressed:(UIButton *)sender onSelectedView:(AddTextView *)selected_view;
@end


@interface AddTextView : UIView
{
    
}
@property(nonatomic,strong)CustomButton *add_text_button;
@property(nonatomic,strong)CustomButton *fonts_button;
@property(nonatomic,strong)CustomButton *text_tools_button;
@property(nonatomic,strong)CustomButton *colors_button;
@property(nonatomic,strong)CustomButton *rotate_3d_button;
@property(nonatomic,strong)CustomButton *eraser_button;
@property(nonatomic,strong)id <AddTextViewDelegate> add_text_view_delegate;

@end
