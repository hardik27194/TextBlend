//
//  ImageCropperView.m
//  TextBlend
//
//  Created by Wayne on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ImageCropperView.h"

@implementation ImageCropperView
@synthesize scroll_view,original_image_button;
@synthesize image_cropper_delegate;
@synthesize instagram_post_button,facebook_post_button,facebook_cover_button,twitter_post_button,iPhone4_wallpaper_button,iPhone5_6_wallpaper_button,ratio_3X2_button,ratio_4X3_button,ratio_5X3_button,ratio_16X9_button,ratio_1X1_button,ratio_3X5_button,ratio_3X4_button,ratio_2X3_button;


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}

-(void)initializeView{
    self.choose_image_size_view = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-172)/2, 14, 172, 13)];
    self.choose_image_size_view.image=[UIImage imageNamed:@"image_cropper_choose_crop_size.png"];
    [self addSubview:self.choose_image_size_view];
    
    self.scroll_view =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 80)];
    self.scroll_view.delegate=self;
    self.scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH+(2*SCREEN_WIDTH)/3, SCREEN_HEIGHT);
    self.scroll_view.contentOffset=CGPointZero;
    [self addSubview:self.scroll_view];
    
    int width_buttons = 10;
    
    self.original_image_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.original_image_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.original_image_button setImage:[UIImage imageNamed:@"image_cropper_original.png"] forState:UIControlStateNormal];
    [self.original_image_button addTarget:self action:@selector(original_image_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.original_image_button];
    width_buttons+=85;
    
    self.instagram_post_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.instagram_post_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.instagram_post_button setImage:[UIImage imageNamed:@"image_cropper_instagram_post.png"] forState:UIControlStateNormal];
    [self.instagram_post_button addTarget:self action:@selector(instagram_post_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.instagram_post_button];
    width_buttons+=85;
    
    self.facebook_post_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.facebook_post_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.facebook_post_button setImage:[UIImage imageNamed:@"image_cropper_facebook_post.png"] forState:UIControlStateNormal];
    [self.facebook_post_button addTarget:self action:@selector(facebook_post_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.facebook_post_button];
    width_buttons+=85;
    
    
    self.facebook_cover_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.facebook_cover_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.facebook_cover_button setImage:[UIImage imageNamed:@"image_cropper_facebook_cover.PNG"] forState:UIControlStateNormal];
    
    [self.facebook_cover_button addTarget:self action:@selector(facebook_cover_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.facebook_cover_button];
    width_buttons+=85;
    
    self.twitter_post_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.twitter_post_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.twitter_post_button setImage:[UIImage imageNamed:@"image_cropper_twitter_post.PNG"] forState:UIControlStateNormal];
    [self.twitter_post_button addTarget:self action:@selector(twitter_post_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.twitter_post_button];
    width_buttons+=85;
    
    self.iPhone4_wallpaper_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iPhone4_wallpaper_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height+10);
    [self.iPhone4_wallpaper_button setImage:[UIImage imageNamed:@"image_cropper_iPhone4_wallpaper.PNG"] forState:UIControlStateNormal];
    [self.iPhone4_wallpaper_button addTarget:self action:@selector(iPhone4_wallpaper_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.iPhone4_wallpaper_button];
    width_buttons+=85;
    
    self.iPhone5_6_wallpaper_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iPhone5_6_wallpaper_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height+10);
    [self.iPhone5_6_wallpaper_button setImage:[UIImage imageNamed:@"image_cropper_iPhone5_6_wallpaper.PNG"] forState:UIControlStateNormal];
    
    [self.iPhone5_6_wallpaper_button addTarget:self action:@selector(iPhone5_6_wallpaper_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.iPhone5_6_wallpaper_button];
    width_buttons+=85;
    
    self.ratio_3X2_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_3X2_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.ratio_3X2_button setImage:[UIImage imageNamed:@"image_cropper_3X2.PNG"] forState:UIControlStateNormal];
    [self.ratio_3X2_button addTarget:self action:@selector(ratio_3X2_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_3X2_button];
    width_buttons+=85;
    
    
    self.ratio_4X3_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_4X3_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.ratio_4X3_button setImage:[UIImage imageNamed:@"image_cropper_4X3.PNG"] forState:UIControlStateNormal];
    [self.ratio_4X3_button addTarget:self action:@selector(ratio_4X3_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_4X3_button];
    width_buttons+=85;
    
    self.ratio_5X3_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_5X3_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.ratio_5X3_button setImage:[UIImage imageNamed:@"image_cropper_5X3.PNG"] forState:UIControlStateNormal];
    
    [self.ratio_5X3_button addTarget:self action:@selector(ratio_5X3_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_5X3_button];
    width_buttons+=85;
    
    self.ratio_16X9_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_16X9_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.ratio_16X9_button setImage:[UIImage imageNamed:@"image_cropper_16X9.PNG"] forState:UIControlStateNormal];
    [self.ratio_16X9_button addTarget:self action:@selector(ratio_16X9_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_16X9_button];
    width_buttons+=85;
    
    self.ratio_1X1_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_1X1_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height+10);
    [self.ratio_1X1_button setImage:[UIImage imageNamed:@"image_cropper_1X1.PNG"] forState:UIControlStateNormal];
    [self.ratio_1X1_button addTarget:self action:@selector(ratio_1X1_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_1X1_button];
    width_buttons+=85;
    
    self.ratio_3X5_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_3X5_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.ratio_3X5_button setImage:[UIImage imageNamed:@"image_cropper_3X5.PNG"] forState:UIControlStateNormal];
    [self.ratio_3X5_button addTarget:self action:@selector(ratio_3X5_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_3X5_button];
    width_buttons+=85;
    
    self.ratio_3X4_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_3X4_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.ratio_3X4_button setImage:[UIImage imageNamed:@"image_cropper_3X4.PNG"] forState:UIControlStateNormal];
    [self.ratio_3X4_button addTarget:self action:@selector(ratio_3X4_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_3X4_button];
    width_buttons+=85;
    
    self.ratio_2X3_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ratio_2X3_button.frame=CGRectMake(width_buttons,0, 75, self.scroll_view.frame.size.height);
    [self.ratio_2X3_button setImage:[UIImage imageNamed:@"image_cropper_2X3.png"] forState:UIControlStateNormal];
    [self.ratio_2X3_button addTarget:self action:@selector(ratio_2X3_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:self.ratio_2X3_button];
    width_buttons+=85;
    
    self.scroll_view.contentSize=CGSizeMake(width_buttons, self.scroll_view.frame.size.height);
    self.scroll_view.showsHorizontalScrollIndicator=NO;
    self.scroll_view.showsVerticalScrollIndicator=NO;
    
    
    [[self.original_image_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.instagram_post_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.facebook_post_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.facebook_cover_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.twitter_post_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.iPhone4_wallpaper_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.iPhone5_6_wallpaper_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_3X2_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_4X3_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_5X3_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_16X9_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_1X1_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_3X5_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_3X4_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    [[self.ratio_2X3_button imageView]setContentMode:UIViewContentModeScaleAspectFit];
    
}

#pragma mark - Button Pressed Methods -


-(IBAction)original_image_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(original_image_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate original_image_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)instagram_post_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(instagram_post_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate instagram_post_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)facebook_post_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(facebook_post_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate facebook_post_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)facebook_cover_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(facebook_cover_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate facebook_cover_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)twitter_post_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(twitter_post_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate twitter_post_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)iPhone4_wallpaper_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(iPhone4_wallpaper_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate iPhone4_wallpaper_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)iPhone5_6_wallpaper_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(iPhone5_6_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate iPhone5_6_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_3X2_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio3X2_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio3X2_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_4X3_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio4X3_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio4X3_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_5X3_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio5X3_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio5X3_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_16X9_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio16X9_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio16X9_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_1X1_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio1X1_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio1X1_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_3X5_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio3X5_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio3X5_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_3X4_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio3X4_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio3X4_button_pressed:sender onSelectedView:self];
    }
    
}

-(IBAction)ratio_2X3_button_pressed:(UIButton *)sender{
    
    if ([self.image_cropper_delegate respondsToSelector:@selector(ratio2X3_button_pressed:onSelectedView:)]) {
        [self.image_cropper_delegate ratio2X3_button_pressed:sender onSelectedView:self];
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
