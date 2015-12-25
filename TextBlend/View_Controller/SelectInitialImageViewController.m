//
//  SelectInitialImageViewController.m
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "SelectInitialImageViewController.h"
#import "SelectImageBackgroundViewController.h"

@interface SelectInitialImageViewController ()

@end

@implementation SelectInitialImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewDidAppear:(BOOL)animated
{

    [self createScrollingImageView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image Capture Actions -

-(IBAction)choosePhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else{
        [Utility showAlertControllerWithMessage:@"Can not open photo library" withCustonTitle:nil onView:self];
        return;
        
    }
    [self presentViewController:picker animated:YES completion:NULL];
}
-(IBAction)capturePhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        [Utility showAlertControllerWithMessage:@"Can not open camera" withCustonTitle:nil onView:self];
        return;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(IBAction)chooseImageBackground:(id)sender
{
    SelectImageBackgroundViewController *select_image_background_vc=[[SelectImageBackgroundViewController alloc]init];
    [self.navigationController pushViewController:select_image_background_vc animated:YES];
}

#pragma mark - Image Picker Controller Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    selected_image=image;
    [picker dismissViewControllerAnimated:YES completion:^{
        // [self saveInfoDetails:info];
        selected_image=image;
        ImageCropperViewController *customize_image_vc=[[ImageCropperViewController alloc]init];
        //    CustomizeImageViewController *customize_image_vc = [[CustomizeImageViewController alloc]init];
        customize_image_vc.view.backgroundColor=DARK_GRAY_COLOR;
        customize_image_vc.selected_image=selected_image;
        [customize_image_vc initializeView];
        [customize_image_vc initializeAdbannerView];
        [self.navigationController pushViewController:customize_image_vc animated:YES];    }];
}

#pragma mark - Scrolling Images ScrollVw -

-(void)createScrollingImageView
{
    int numberOfPages = 3;
    if(!scrollVw_images)
    {
        scrollVw_images = [[UIScrollView alloc]init];
    }
    
    // For ease in referencing sizes
    CGFloat portalHeight = scrollVw_images.frame.size.height;
    CGFloat portalWidth = scrollVw_images.frame.size.width;
    
    scrollVw_images.contentSize = CGSizeMake(scrollVw_images.frame.size.width * numberOfPages, scrollVw_images.frame.size.height);
    // Needed to lock scrolling to pages
    scrollVw_images.pagingEnabled = YES;
    // Setup pages

    if(!scrollerImage1)
        {
            scrollerImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, portalWidth, portalHeight)];
            scrollerImage1.image = [UIImage imageNamed:@"tempHorse.jpg"];
            [scrollVw_images addSubview:scrollerImage1];
            [scrollerImage1 setContentMode:UIViewContentModeScaleAspectFill];
        }
    
        if(!scrollerImage2)
        {
            scrollerImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(portalWidth*1, 0, portalWidth, portalHeight)];
            scrollerImage2.image = [UIImage imageNamed:@"tempHouse.jpg"];
            [scrollVw_images addSubview:scrollerImage2];
            [scrollerImage2 setContentMode:UIViewContentModeScaleAspectFill];
        }
        if(!scrollerImage3)
        {
            scrollerImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(portalWidth*2, 0, portalWidth, portalHeight)];
            scrollerImage3.image = [UIImage imageNamed:@"tempColor.jpg"];
            [scrollVw_images addSubview:scrollerImage3];
            [scrollerImage3 setContentMode:UIViewContentModeScaleAspectFill];
        }
    scrollVw_images.contentOffset = CGPointMake(portalWidth, 0);
    [self startScrolling];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x + scrollView.frame.size.width == scrollView.contentSize.width)
    {
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
        // Image Tweaks
        
        UIImage *backBol = scrollerImage1.image;
        
        scrollerImage1.image = scrollerImage2.image;
        scrollerImage2.image = scrollerImage3.image;
        scrollerImage3.image = backBol;
    }
    else if(scrollView.contentOffset.x  == 0)
    {
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];

        UIImage *backBol = scrollerImage2.image;
        scrollerImage2.image = scrollerImage1.image;
        scrollerImage1.image = scrollerImage3.image;
        scrollerImage3.image = backBol;

    }
}

-(void)startScrolling
{
    [scrollVw_images scrollRectToVisible:CGRectMake(scrollVw_images.frame.size.width*2, 0, scrollVw_images.frame.size.width, scrollVw_images.frame.size.height) animated:YES];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScrolling) object:nil];
    [self performSelector:@selector(startScrolling) withObject:nil afterDelay:3.0];
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
