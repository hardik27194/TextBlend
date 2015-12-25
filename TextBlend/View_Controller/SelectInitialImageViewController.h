//
//  SelectInitialImageViewController.h
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectInitialImageViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    UIImage *selected_image;
    IBOutlet UIScrollView *scrollVw_images;
    
    UIImageView *scrollerImage1;
    UIImageView *scrollerImage2;
    UIImageView *scrollerImage3;


}

@end
