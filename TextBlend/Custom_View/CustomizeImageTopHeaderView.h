//
//  CustomizeImageTopHeaderView.h
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

//This class is global class for the navigation bar headers used in the application. This class is a subclass of UIView.


#import <UIKit/UIKit.h>

@class CustomizeImageTopHeaderView;

@protocol CustomizeImageHeaderButtonsDelegate <NSObject>

@optional
-(void)back_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView;
-(void)next_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView;
-(void)share_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView;
-(void)settings_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView;
@end


@interface CustomizeImageTopHeaderView : UIView{
    
}

@property(nonatomic,strong)UIButton *back_button;
@property(nonatomic,strong)UIButton *next_button;
@property(nonatomic,strong)UIButton *settings_button;
@property(nonatomic,strong)UIButton *share_button;
@property(nonatomic,strong)id <CustomizeImageHeaderButtonsDelegate> customize_screen_top_header_delegate;


@end
