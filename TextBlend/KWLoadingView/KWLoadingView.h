//
//  KWLoadingView.h
//  
//
//  Created by Katie Warren on 10/4/12.
//  Copyright (c) 2012 Katie Warren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KWLoadingView : UIView

@property (nonatomic, strong) UILabel *loadingText;
@property (nonatomic, strong) UIImageView *loadingImage;
@property (nonatomic, strong) UIImageView *centralImage;
@property (nonatomic, strong) UIImageView *background;

@property (nonatomic) BOOL didError;
@property (nonatomic) BOOL viewWillBeHidden;

-(void)hideSelf:(BOOL)hide;
-(void)quickHide;
-(void)indicatorText:(NSString *)loadingTextString didError:(BOOL)error;

@end
