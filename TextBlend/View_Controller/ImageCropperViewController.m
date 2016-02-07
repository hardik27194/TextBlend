//
//  ImageCropperViewController.m
//  TextBlend
//
//  Created by Wayne on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ImageCropperViewController.h"
#import "UIImage+PECrop.h"

#define HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW 138
#define CENTRE_FRAME CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)

@interface ImageCropperViewController ()

@end

@implementation ImageCropperViewController
@synthesize image_cropper_view,selected_image,scroll_view;
@synthesize top_header_view,adBannerView;
@synthesize image_edit_main_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self initializeView];
    //    [self initializeAdbannerView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.image_edit_main_view.image_edit_scroll_view.layer setBorderWidth:1.0];

}
-(void)initializeTopHeaderView{
    self.top_header_view = [[CustomizeImageTopHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.top_header_view.customize_screen_top_header_delegate=self;
    self.top_header_view.settings_button.hidden=YES;
    [self.scroll_view addSubview:self.top_header_view];
    
}
-(void)initializeView{
    
    self.scroll_view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scroll_view.delegate=self;
    self.scroll_view.contentSize=CGSizeMake(SCREEN_WIDTH, CENTRE_FRAME.size.height);
    [self.view addSubview:self.scroll_view];
    [self initializeMainImageView];
    [self initializeChooseCropperView];
    [self initializeTopHeaderView];
    //[self initailizeMessageTextView];
}

-(void)initializeMainImageView{
    self.image_edit_main_view = [[ImageEditMainView alloc]initWithFrame:CENTRE_FRAME];
    self.image_edit_main_view.selected_image=self.selected_image;
    self.image_edit_main_view.hasSelectedImage = NO;
    [self.image_edit_main_view initializeView];
    [self.scroll_view addSubview:self.image_edit_main_view];
    
}

-(void)initializeChooseCropperView{
    self.image_cropper_view=[[ImageCropperView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW, SCREEN_WIDTH, HEIGHT_OF_IMAGE_EDITNG_TOOL_VIEW)];
    self.image_cropper_view.image_cropper_delegate=self;
    [self.view addSubview:self.image_cropper_view];
    
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

#pragma mark - Image Cropper Button Pressed Methods -

-(void)original_image_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
//    [self.image_edit_main_view.cropView resetCropRectAnimated:YES];
//    CGRect cropRect = self.image_edit_main_view.cropView.cropRect;
//    CGSize size = self.image_edit_main_view.cropView.image.size;
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//    CGFloat ratio;
//    if (width < height)
//    {
//        ratio = width / height;
//        cropRect.size = CGSizeMake(CGRectGetHeight(cropRect) * ratio, CGRectGetHeight(cropRect));
//    } else
//    {
//        ratio = height / width;
//        cropRect.size = CGSizeMake(CGRectGetWidth(cropRect), CGRectGetWidth(cropRect) * ratio);
//    }
//    self.image_edit_main_view.cropView.cropRect = cropRect;
    CGRect cropRect;
    cropRect = [self.image_edit_main_view areaToDrawImage:CGRectMake(0, 0, self.image_edit_main_view.selected_image.size.width, self.image_edit_main_view.selected_image.size.height) inView:self.image_edit_main_view.frame];
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}


-(void)instagram_post_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    [self ratio1X1_button_pressed:nil onSelectedView:nil];
}

-(void)facebook_post_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake(width, width * 394/470);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;

    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)facebook_cover_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake(width, width * 315/851);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;
    
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)twitter_post_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake(width, width * 1/2);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;
    
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)iPhone4_wallpaper_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat height = CGRectGetHeight(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake((height*320)/480, height);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;
    
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)	iPhone5_6_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat height = CGRectGetHeight(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake((height*320)/568, height);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;
    
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void) ratio3X2_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake(width, width * 2/3);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;
    
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)ratio4X3_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake(width, width * 3/4);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;
    
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)ratio5X3_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake(width, width * 3/5);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;
    
    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)ratio16X9_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake(width, width * 9/16);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;

    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

-(void)ratio1X1_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    
    //[self.image_edit_main_view .cropView resetCropRectAnimated:YES];
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat height = CGRectGetHeight(self.image_edit_main_view.main_image_view.frame);
    CGFloat width = CGRectGetWidth(self.image_edit_main_view.main_image_view.frame);
    if(width<height)
    {
        cropRect.size = CGSizeMake(width, width);
    }
    else
    {
        cropRect.size = CGSizeMake(height, height);
    }
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;

    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];

}

-(void)ratio3X5_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat height = CGRectGetHeight(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake((height*3)/5, height);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;

    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}
-(void)ratio3X4_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view{
    
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat height = CGRectGetHeight(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake((height*3)/4, height);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;

    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}
-(void)ratio2X3_button_pressed:(UIButton *)sender onSelectedView:(ImageCropperView *)selected_view
{
    CGRect cropRect = self.image_edit_main_view.main_image_view.frame;
    CGFloat height = CGRectGetHeight(self.image_edit_main_view.main_image_view.frame);
    cropRect.size = CGSizeMake((height*2)/3, height);
    cropRect.origin.x = (self.image_edit_main_view.frame.size.width - cropRect.size.width)/2;
    cropRect.origin.y = (self.image_edit_main_view.frame.size.height - cropRect.size.height)/2;

    [self.image_edit_main_view layoutOverlayViewsWithCropRect:cropRect];
}

//h= 3/2w

#pragma mark - Customize Top Header Delegate Methods -

-(void)back_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView
{
    UIScrollView *contentScrollView = self.image_edit_main_view.image_edit_scroll_view;
    [contentScrollView.layer setBorderWidth:1.0];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView
{
    
//    self.selected_image = [self.image_edit_main_view.main_image_view.image rotatedImageWithtransform:self.image_edit_main_view.main_image_view.transform croppedToRect:self.image_edit_main_view.cropRectView] ;

/*
    
    UIImage *image  =self.image_edit_main_view.main_image_view.image;
    CGRect rect = self.image_edit_main_view.cropRectView;
    
    CGFloat heightRatio = image.size.height/self.image_edit_main_view.main_image_view.frame.size.height;
    CGFloat widthRatio = image.size.width/self.image_edit_main_view.main_image_view.frame.size.width;
    
    CGFloat newHeight = rect.size.height *heightRatio;
    CGFloat newWidth  =  rect.size.width *widthRatio;
    
    CGRect newFrameRect = CGRectMake((image.size.width - newWidth)/2, (image.size.height - newHeight)/2, newWidth, newHeight);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], newFrameRect);
    
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
*/

/*    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(rect.origin.x, rect.origin.y, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImg = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    [self pushViewController:smallImg];
*/
    
    UIScrollView *contentScrollView = self.image_edit_main_view.image_edit_scroll_view;
    UIGraphicsBeginImageContextWithOptions(contentScrollView.bounds.size,
                                           YES,
                                           self.image_edit_main_view.main_image_view.image.scale);
    [contentScrollView.layer setBorderWidth:0.0];
    
    //this is the key
    CGPoint offset=contentScrollView.contentOffset;
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -offset.x, -offset.y);
    
    [contentScrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *visibleScrollViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [self pushViewController:visibleScrollViewImage];

}

-(void)share_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)settings_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}


#pragma mark - Misc Functions -

-(void)pushViewController:(UIImage *)image{
    
    CustomizeImageViewController *customize_image_vc = [[CustomizeImageViewController alloc]init];
    customize_image_vc.view.backgroundColor=DARK_GRAY_COLOR;
    customize_image_vc.selected_image=image;
    [customize_image_vc initializeView];
    [self.navigationController pushViewController:customize_image_vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
