//
//  AddColorSelectionView.m
//  GradientColor
//
//  Created by Itesh Dutt on 24/01/16.
//  Copyright © 2016 Itesh Dutt. All rights reserved.
//

#import "AddColorSelectionView.h"
#define EDITING_BACKGROUND_COLOR [UIColor colorWithRed:0.7254 green:0.7254 blue:0.7254 alpha:1]
#define MAX_COLOR [UIColor grayColor]
#define MIN_COLOR [UIColor greenColor]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define buffer_width 20
#define text_buffer 50
@interface AddColorSelectionView(){
    CGPoint start_point;
  
    
}
@end
@implementation AddColorSelectionView
@synthesize add_color_gradient_view;


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self addToolsView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}




-(void)addToolsView{
    
    
    int height=0;
    int view_width = self.frame.size.width;
    
    
    self.start_color_label = [[UILabel alloc]initWithFrame:CGRectMake(0, height, (view_width-buffer_width)/2, self.frame.size.height)];
    self.start_color_label.text=@"start color";
    self.start_color_label.font=[UIFont systemFontOfSize:12];
    self.start_color_label.textAlignment=NSTextAlignmentCenter;;
    self.start_color_label.textColor=[UIColor whiteColor];
    self.start_color_label.backgroundColor=[UIColor blackColor];

    self.start_color_label.numberOfLines=0;
    self.start_color_label.userInteractionEnabled=YES;
    [self addSubview:self.start_color_label];
    
    self.end_color_label = [[UILabel alloc]initWithFrame:CGRectMake((view_width+buffer_width)/2, height, (view_width-buffer_width)/2, self.frame.size.height)];
    self.end_color_label.text=@"end color";
    self.end_color_label.numberOfLines=0;
    self.end_color_label.font=[UIFont systemFontOfSize:12];

    self.end_color_label.textAlignment=NSTextAlignmentCenter;
    self.end_color_label.textColor=[UIColor whiteColor];
    self.end_color_label.backgroundColor=[UIColor lightGrayColor];

    self.end_color_label.userInteractionEnabled=YES;
    [self addSubview:self.end_color_label];
    
    
    self.center_pan_color_image_view = [[UIImageView alloc]initWithFrame:CGRectMake((view_width-buffer_width)/2, height, buffer_width, self.frame.size.height)];
    self.center_pan_color_image_view.backgroundColor =[UIColor redColor];
    self.center_pan_color_image_view.userInteractionEnabled=YES;
    [self addSubview:self.center_pan_color_image_view];

    [self addGesturesOnView];
    
}


-(void)addGesturesOnView{
    
    UIPanGestureRecognizer *pan_gesture_recognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan_gesture_recognizer:)];
    pan_gesture_recognizer.delegate=self;
    [self.center_pan_color_image_view addGestureRecognizer:pan_gesture_recognizer];
   
    
    UITapGestureRecognizer *start_tap_gesture_recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(start_gesture_recognizer:)];
    start_tap_gesture_recognizer.delegate=self;
    start_tap_gesture_recognizer.numberOfTapsRequired=1;
    [self.start_color_label addGestureRecognizer:start_tap_gesture_recognizer];

    
    UITapGestureRecognizer *end_tap_gesture_recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(end_gesture_recognizer:)];
    end_tap_gesture_recognizer.delegate=self;
    end_tap_gesture_recognizer.numberOfTapsRequired=1;
    [self.end_color_label addGestureRecognizer:end_tap_gesture_recognizer];

}

-(IBAction)pan_gesture_recognizer:(UIPanGestureRecognizer *)gesture_recognizer{
    
//    NSLog(@"pan_gesture_recognizer");
    CGPoint current_point=[gesture_recognizer locationInView:self];
    
    switch (gesture_recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            start_point=[gesture_recognizer locationInView:self];
            NSLog(@"%@",NSStringFromCGPoint(start_point));
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            [self updateFrames:start_point withCurrentPoint:current_point];
            
        }
            break;
            
            
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)updateFrames:(CGPoint)start_point withCurrentPoint:(CGPoint)current_point{
    
    __block CGRect startLabelFrame=self.start_color_label.frame;
    __block CGRect center_image_frame = self.center_pan_color_image_view.frame;
    __block CGRect endLabelFrame=self.end_color_label.frame;
    
    if (current_point.x<=text_buffer) {
        startLabelFrame.origin.x = 0;
        startLabelFrame.size.width=text_buffer;
        center_image_frame.origin.x = text_buffer;
        
        endLabelFrame.origin.x = text_buffer+buffer_width;
        endLabelFrame.size.width = self.frame.size.width-(text_buffer+buffer_width);
    }
    else if (current_point.x+text_buffer>=self.frame.size.width){
        startLabelFrame.origin.x = 0;
        startLabelFrame.size.width=self.frame.size.width-(text_buffer+buffer_width);
        center_image_frame.origin.x = self.frame.size.width-(text_buffer+buffer_width);;
        
        endLabelFrame.origin.x = self.frame.size.width-(text_buffer);;
        endLabelFrame.size.width = text_buffer;
    }
    else{
        startLabelFrame.origin.x = 0;
        startLabelFrame.size.width=current_point.x-(buffer_width/2);
        center_image_frame.origin.x = current_point.x-(buffer_width/2);
        
        endLabelFrame.origin.x = current_point.x+(buffer_width/2);
        endLabelFrame.size.width = self.frame.size.width-(current_point.x+(buffer_width/2));
        
    }
    
    self.start_color_label.frame=startLabelFrame;
    self.center_pan_color_image_view.frame=center_image_frame;
    self.end_color_label.frame=endLabelFrame;

    [add_color_gradient_view updateGradientColors];
   // [add_color_gradient_view setGradientCOlor];
    
    [UIView animateWithDuration:0.1 animations:^{
    
        
    }];
    
    
}

-(IBAction)start_gesture_recognizer:(UIGestureRecognizer *)sender{
    NSLog(@"start_gesture_recognizer");
   
    if (!self.colorPreviewView) {
        self.colorPreviewView = [DTColorPickerImageView colorPickerWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 200)];
        self.colorPreviewView.image=[UIImage imageNamed:@"fontcolor_bar.png"];
        self.colorPreviewView.delegate=add_color_gradient_view;
        [add_color_gradient_view addSubview:self.colorPreviewView];
    }
    
    add_color_gradient_view.selected_label=self.start_color_label;
    [add_color_gradient_view bringSubviewToFront:self.colorPreviewView];

}




-(IBAction)end_gesture_recognizer:(UIGestureRecognizer *)sender{
    NSLog(@"end_gesture_recognizer");
    if (!self.colorPreviewView) {
        self.colorPreviewView = [DTColorPickerImageView colorPickerWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
        self.colorPreviewView.image=[UIImage imageNamed:@"fontcolor_bar.png"];
        self.colorPreviewView.delegate=add_color_gradient_view;
        [add_color_gradient_view addSubview:self.colorPreviewView];
    }
    
    add_color_gradient_view.selected_label=self.end_color_label;

    [add_color_gradient_view bringSubviewToFront:self.colorPreviewView];

}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


