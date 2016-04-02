//
//  SplashEffectView.m
//  TextBlend
//
//  Created by Itesh Dutt on 17/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "SplashEffectView.h"
#import "UIImage+Utility.h"
#define MAX_COLOR [UIColor grayColor]

@interface SplashEffectView(){
    UIImageView *_drawingView;
    UIImage *_maskImage;
    UIImage *_grayImage;
    CGSize _originalImageSize;
    
    CGPoint _prevDraggingPosition;
    UIView *_menuView;
    UISlider *_widthSlider;
    UIView *_strokePreview;
    UIView *_strokePreviewBackground;
    UIImageView *_eraserIcon;
    UILabel *eraserLabel;
    UILabel *infoLabel;
    BOOL isEraserOn;

}
@end

@implementation SplashEffectView
@synthesize selected_sticker_view;
@synthesize black_view,done_check_mark_button;
@synthesize splash_effect_delegate;
@synthesize original_image;
@synthesize radiusSlider,widthSlider;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
      
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        
    }
    return self;
    
}
-(void)setUp{
    [self initializeView];
    //[self getPopularPosts:YES];
    [self initializeMainView];
}

-(void)initializeView{
    self.black_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    self.black_view.backgroundColor=[UIColor blackColor];
    [self addSubview:self.black_view];
    
    self.done_check_mark_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.done_check_mark_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    self.done_check_mark_button.showsTouchWhenHighlighted=YES;
    
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.done_check_mark_button];
    
    
}

-(void)initializeMainView{
    CGFloat W = 70;

    
    self.widthSlider = [[UISlider alloc]init];
    [self.widthSlider setFrame:CGRectZero];
    self.widthSlider.minimumValue = 0;
    self.widthSlider.value = 0.1;
    self.widthSlider.maximumValue = 1;
    [self.widthSlider addTarget:self action:@selector(widthSliderDidChange:) forControlEvents:UIControlEventValueChanged];
    self.widthSlider.frame = CGRectMake((SCREEN_WIDTH-200)/2, 25+((self.frame.size.height-30)/2), 200, 30);
    //self.widthSlider.continuous = YES;
    
    self.widthSlider.maximumTrackTintColor = MAX_COLOR;
    
    [self addSubview:self.widthSlider];
    
    _strokePreview = [[UIView alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH-200)/2)+220, 25+((self.frame.size.height-(W-15))/2), W - 15, W - 15)];
    _strokePreview.layer.cornerRadius = _strokePreview.frame.size.height/2;
    _strokePreview.layer.borderWidth = 1;
    _strokePreview.layer.borderColor = [UIColor whiteColor].CGColor;
    //_strokePreview.center = CGPointMake(_menuView.frame.size.width-W/2, _menuView.frame.size.height/2);
    [self addSubview:_strokePreview];
    
    _strokePreviewBackground = [[UIView alloc] initWithFrame:_strokePreview.frame];
    _strokePreviewBackground.layer.cornerRadius = _strokePreviewBackground.frame.size.height/2;
    _strokePreviewBackground.alpha = 0.3;
    [_strokePreviewBackground addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(strokePreviewDidTap:)]];
    [self insertSubview:_strokePreviewBackground aboveSubview:_strokePreview];
    [self setImageOnMainView:[self.original_image grayScaleImage]];
    [self widthSliderDidChange:self.widthSlider];

}
// STROKE PREVIEW CIRCLE TAPPED

- (void)widthSliderDidChange:(UISlider*)sender
{
    CGFloat scale = MAX(0.05, self.widthSlider.value);
    _strokePreview.transform = CGAffineTransformMakeScale(scale, scale);
    _strokePreview.layer.borderWidth = 2/scale;
}

// STROKE PREVIEW CIRCLE TAPPED
- (void)strokePreviewDidTap:(UITapGestureRecognizer*)sender {
    if (isEraserOn) {
        
    }
    else{
        
    }
    
    /*
     _eraserIcon.hidden = !_eraserIcon.hidden;
    
    // Show an info Label
    eraserLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    eraserLabel.center = self.editor.view.center;
    eraserLabel.font = [UIFont fontWithName:@"BebasNeue" size:35];
    eraserLabel.textColor = LIGHT_COLOR;
    eraserLabel.textAlignment = NSTextAlignmentCenter;
    [self.editor.view addSubview:eraserLabel];
    
    if (_eraserIcon.hidden) {   eraserLabel.text = @"Eraser Off";
    } else {  eraserLabel.text = @"Eraser On";  }
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeSplashLabel) userInfo:nil repeats:false];
     */
}

- (UIImage*)applyEffect:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CICircularScreen" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    CIVector *vector = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
    [filter setValue:vector forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithFloat:0.3] forKey:@"inputSharpness"];
    [filter setValue:[NSNumber numberWithFloat:self.radiusSlider.value] forKey:@"inputWidth"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return result;
}

- (void)drawingViewDidPan:(UIPanGestureRecognizer*)sender
{
    CGPoint currentDraggingPosition = [sender locationInView:_drawingView];
    
    if(sender.state == UIGestureRecognizerStateBegan){
        _prevDraggingPosition = currentDraggingPosition;
    }
    
    if(sender.state != UIGestureRecognizerStateEnded){
        [self drawLine:_prevDraggingPosition to:currentDraggingPosition];
        _drawingView.image = [_grayImage maskedImage:_maskImage];
    }
    _prevDraggingPosition = currentDraggingPosition;
}

-(void)drawLine:(CGPoint)from to:(CGPoint)to
{
    CGSize size = _drawingView.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat strokeWidth = MAX(1, widthSlider.value * 65);
    
    if(_maskImage==nil){
        CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        
    } else {   [_maskImage drawAtPoint:CGPointZero];   }
    
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
//    if(!_eraserIcon.hidden){
//        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
//    } else{
//        CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
//    }
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    
    _maskImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

- (UIImage*)buildImage
{
    _grayImage = [self.original_image grayScaleImage];
    
    UIGraphicsBeginImageContextWithOptions(_originalImageSize, false, self.original_image.scale);
    
    [self.original_image drawAtPoint:CGPointZero];
    [[_grayImage maskedImage:_maskImage] drawInRect:CGRectMake(0, 0, _originalImageSize.width, _originalImageSize.height)];
    
    UIImage *tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tmp;
}




#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.splash_effect_delegate respondsToSelector:@selector(splash_effect_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.splash_effect_delegate splash_effect_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}


#pragma mark - Select Color Palette View Delegate Methods -

-(void)setImageOnMainView:(UIImage *)image{
    
    if ([self.splash_effect_delegate respondsToSelector:@selector(splash_effect_set_image:onSelectedView:onSelectedZticker:)]) {
        [self.splash_effect_delegate splash_effect_set_image:image onSelectedView:self onSelectedZticker:self.selected_sticker_view];
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
