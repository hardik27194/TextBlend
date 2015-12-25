//
//  KWLoadingView.m
//  
//
//  Created by Katie Warren on 10/4/12.
//  Copyright (c) 2012 Katie Warren. All rights reserved.
//

#import "KWLoadingView.h"

@implementation KWLoadingView

#define clockwise 1
#define counterclockwise -1

@synthesize loadingImage, viewWillBeHidden, didError, background, centralImage, loadingText;

-(id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
    if (self) {

		[self setupView];
        
	}
	
    return self;
}

//lay everything out
-(void)setupView {
	
	background = [[UIImageView alloc]init];
	loadingText = [[UILabel alloc] init];
	loadingImage = [[UIImageView alloc]init];
	centralImage = [[UIImageView alloc]init];
    
	[self addSubview:background];
	[self addSubview:loadingText];
	[self addSubview:centralImage];
	[self addSubview:loadingImage];
    
}

//the size of the static central image in our loading indicator (centralImage.png)
+(CGSize)centralLoadingImage {
    
	return CGSizeMake(61, 61);
    
}

//the size of our static error indicator image (errorTriangle.png)
+(CGSize)errorIndicator {
    
	return CGSizeMake(64, 57);
    
}

-(void)layoutSubviews {

    CGRect rect = self.frame;
	CGSize centralImageSize = [[self class] centralLoadingImage];
	CGSize errorImageSize = [[self class] errorIndicator];
    
    //if we're preparing to show the error indicator set the correct frame size
	if (didError) {
        
		loadingImage.frame = CGRectMake(((rect.size.width-errorImageSize.width)/2), rect.size.height/6, errorImageSize.width, errorImageSize.height);
        
    }
    
	else {
        
		loadingImage.frame = CGRectMake(((rect.size.width-centralImageSize.width)/2), rect.size.height/6, centralImageSize.width, centralImageSize.height);        

	}
    
    centralImage.frame = CGRectMake(((rect.size.width-centralImageSize.width)/2), rect.size.height/6, centralImageSize.width, centralImageSize.height);
    //the background and loadingText frames are always the same size
    background.frame = CGRectMake(0, 0.0f, rect.size.width, rect.size.height);
    loadingText.frame = CGRectMake(05, rect.size.height-35, rect.size.width-10, 20);

    [super layoutSubviews];
}

-(void)indicatorText:(NSString *)loadingTextString didError:(BOOL)error {
    
    didError = error;
    
    //if we're showing an error 
	if (didError) {
        
		loadingImage.image = [UIImage imageNamed:@"errorTriangle.png"];
		centralImage.image = nil;
        
		[self hideSelf:NO];
        
        
	}
    
    //if we're showing a loading indicator
	else {
        
		loadingImage.image = [UIImage imageNamed:@"loading.png"];
		centralImage.image = [UIImage imageNamed:@"centralImage.png"];
        
		[self hideSelf:NO];
        
	}

    background.image = [UIImage imageNamed:@"alertViewBG.png"];
    
    loadingText.text = loadingTextString;
    loadingText.textAlignment = NSTextAlignmentCenter;
    loadingText.font = [UIFont fontWithName:CUSTOM_LIGHT_FONT size:16];
    loadingText.backgroundColor = [UIColor clearColor];
    loadingText.textColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.0f];
    loadingText.shadowColor = [UIColor darkGrayColor];
    loadingText.shadowOffset = CGSizeMake(0, 1);
   
    [self setNeedsLayout];

}

//Called when we dismiss the view or bring it on-screen. It animates the view in and out of the hidden state by changing its alpha (also removes animations once the view is gone)
-(void)hideSelf:(BOOL)hide {
    
	viewWillBeHidden = hide;
    
    //if we're showing an error
	if (didError) {

        //prepare to bring the view to the front
		if (!viewWillBeHidden) {
            
			[UIView animateWithDuration:0.3 animations:^() {
               
				self.alpha = 0.9;
            
            } completion:^(BOOL finished) {
                
                [loadingImage.layer removeAllAnimations];
                    
            }];
		}
        
        //prepare to hide the view
		else {
            
			[UIView animateWithDuration:0.3 animations:^() {
                
				self.alpha = 0.0;
                
			} completion:^(BOOL finished) {
             
                [loadingImage.layer removeAllAnimations];
                
            }];
            
		}
	}
    
    //if we're loading
	if (!didError) {
        
        //prepare to bring the view to the front
		if (!viewWillBeHidden) {
           
            [self spinLayer:loadingImage.layer duration:0.3 direction:clockwise];
            
			[UIView animateWithDuration:0.3 animations:^() {
                
				self.alpha = 0.9;
                
			}];
            
        }
        
		//prepare to hide the view
		else {
                        
			[UIView animateWithDuration:0.3 animations:^() {
                
				self.alpha = 0.0;

            } completion:^(BOOL finished) {
                
                [loadingImage.layer removeAllAnimations];
            
            }];
        }

    }
    
}

//I use this if the user dismisses the whole app while we're loading--it's purely a vanity method
-(void)quickHide {

    [loadingImage.layer removeAllAnimations];
    self.alpha = 0.0;
    
}

//Handles all of the layer animation
-(void)spinLayer:(CALayer *)inLayer duration:(CFTimeInterval)inDuration direction:(int)direction {

	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat: M_PI_2 * direction];
    animation.duration = inDuration;
    animation.cumulative = YES;
	animation.repeatCount = INFINITY;
    
	[inLayer addAnimation:animation forKey:@"loadingViewRotation"];
    
}

@end
