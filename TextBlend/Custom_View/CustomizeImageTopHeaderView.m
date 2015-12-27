//
//  CustomizeImageTopHeaderView.m
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "CustomizeImageTopHeaderView.h"

@implementation CustomizeImageTopHeaderView
@synthesize back_button,next_button,share_button,settings_button,customize_screen_top_header_delegate;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=[UIColor blackColor];
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}

-(void)initializeView{
    self.back_button= [UIButton buttonWithType:UIButtonTypeCustom];
    self.back_button.frame=CGRectMake(15,13, 32, 24);
    [self.back_button setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    
    [self.back_button addTarget:self action:@selector(back_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.back_button];;
    
    
    self.next_button= [UIButton buttonWithType:UIButtonTypeCustom];
    self.next_button.frame=CGRectMake(SCREEN_WIDTH-45,13, 32, 24);
    [self.next_button setImage:[UIImage imageNamed:@"next_button.png"] forState:UIControlStateNormal];
    [self.next_button addTarget:self action:@selector(next_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.next_button];;
    
    
    self.settings_button= [UIButton buttonWithType:UIButtonTypeCustom];
    self.settings_button.frame=CGRectMake(85,10, 30, 30);
    [self.settings_button setImage:[UIImage imageNamed:@"settings_button.PNG"] forState:UIControlStateNormal];
    
    [self.settings_button addTarget:self action:@selector(settings_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settings_button];;
    
    self.share_button= [UIButton buttonWithType:UIButtonTypeCustom];
    self.share_button.frame=CGRectMake(SCREEN_WIDTH-47,13, 32, 24);
    [self.share_button setImage:[UIImage imageNamed:@"share_button.PNG"] forState:UIControlStateNormal];
    
    [self.share_button addTarget:self action:@selector(share_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.share_button];;
    self.share_button.hidden=YES;

}

#pragma mark - Button Pressed Methods -

-(IBAction)back_button_pressed:(UIButton *)sender{
    if ([self.customize_screen_top_header_delegate respondsToSelector:@selector(back_button_pressed:onView:)]) {
        [self.customize_screen_top_header_delegate back_button_pressed:sender onView:self];
        
    }
}

-(IBAction)next_button_pressed:(UIButton *)sender{
    if ([self.customize_screen_top_header_delegate respondsToSelector:@selector(next_button_pressed:onView:)]) {
        [self.customize_screen_top_header_delegate next_button_pressed:sender  onView:self];
        
    }
}

-(IBAction)settings_button_pressed:(UIButton *)sender{
    if ([self.customize_screen_top_header_delegate respondsToSelector:@selector(settings_button_pressed:onView:)]) {
        [self.customize_screen_top_header_delegate next_button_pressed:sender onView:self];
        
    }
}

-(IBAction)share_button_pressed:(UIButton *)sender{
    if ([self.customize_screen_top_header_delegate respondsToSelector:@selector(share_button_pressed:onView:)]) {
        [self.customize_screen_top_header_delegate share_button_pressed:sender onView:self];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
