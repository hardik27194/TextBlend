//
//  ZDStickerView.m
//
//  Created by Seonghyun Kim on 5/29/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import "ZDStickerView.h"
#import <QuartzCore/QuartzCore.h>
#import "OHAttributedLabel.h"

#define kSPUserResizableViewGlobalInset -5.0
#define kSPUserResizableViewDefaultMinWidth 48.0
#define kSPUserResizableViewInteractiveBorderSize 10.0
#define kZDStickerViewControlSize 20.0

@interface ZDStickerView ()

@property (strong, nonatomic) UIImageView *resizingControl;
@property (strong, nonatomic) UIButton *deleteControl;
@property (strong, nonatomic) UIImageView *customControl;

@property (nonatomic) BOOL preventsLayoutWhileResizing;


@property (nonatomic) CGPoint prevPoint;
@property (nonatomic) CGAffineTransform startTransform;

@property (nonatomic) CGPoint touchStart;

@end

@implementation ZDStickerView
@synthesize contentView1, touchStart;

@synthesize prevPoint;
@synthesize deltaAngle, startTransform; //rotation
@synthesize resizingControl, deleteControl, customControl;
@synthesize preventsPositionOutsideSuperview;
@synthesize preventsResizing;
@synthesize preventsDeleting;
@synthesize preventsCustomButton;
@synthesize minWidth, minHeight;
@synthesize rotate_3d_x_coordinate_slider_value,rotate_3d_y_coordinate_slider_value,rotate_3d_z_coordinate_slider_value;
@synthesize shadow_opacity_slider_value,shadow_blur_slider_value,shadow_x_position_slider_value,shadow_y_position_slider_value;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#ifdef ZDSTICKERVIEW_LONGPRESS
-(void)longPress:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if([_delegate respondsToSelector:@selector(stickerViewDidLongPressed:)]) {
            [_delegate stickerViewDidLongPressed:self];
        }
    }
}
#endif

-(void)btnDeleteClicked{
    //    NSDictionary* dict = [NSDictionary dictionaryWithObject:
    //                          [NSNumber numberWithInt:self.tag]
    //                                                     forKey:@"index"];
    
    if([_delegate respondsToSelector:@selector(stickerViewDidClose:)]) {
        [_delegate stickerViewDidClose:self];
    }
    
}


-(void)singleTap:(UIPanGestureRecognizer *)recognizer
{
//    if (NO == self.preventsDeleting)
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckButtons" object:nil];
//        UIView * close = (UIView *)[recognizer view];
//        [close.superview removeFromSuperview];
//    }
    
    if([_delegate respondsToSelector:@selector(stickerViewDidClose:)]) {
        [_delegate stickerViewDidClose:self];
    }
}

-(void)customTap:(UIPanGestureRecognizer *)recognizer
{
    if (NO == self.preventsCustomButton) {
        if([_delegate respondsToSelector:@selector(stickerViewDidCustomButtonTap:)]) {
            [_delegate stickerViewDidCustomButtonTap:self];
        }
    }
}

-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if(recognizer.view.hidden){
        return;
    }
    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:self];
//        [borderView setNeedsDisplay];
        [self setNeedsDisplay];

        
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (self.bounds.size.width < minWidth || self.bounds.size.height < minHeight)
        {
//            self.bounds = CGRectMake(self.bounds.origin.x,
//                                     self.bounds.origin.y,
//                                     minWidth+1,
//                                     minHeight+1);
            resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize+10,
                                       self.bounds.size.height-kZDStickerViewControlSize+10,
                                              kZDStickerViewControlSize,
                                              kZDStickerViewControlSize);
            deleteControl.frame = CGRectMake(-10, -10,
                                             kZDStickerViewControlSize, kZDStickerViewControlSize);
            customControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                              0,
                                              kZDStickerViewControlSize,
                                              kZDStickerViewControlSize);
            prevPoint = [recognizer locationInView:self];
             
        } else {
            /*
            CGPoint point = [recognizer locationInView:self];
            float wChange = 0.0, hChange = 0.0;
            
            wChange = (point.x - prevPoint.x);
            hChange = (point.y - prevPoint.y);
            
            if (ABS(wChange) > 20.0f || ABS(hChange) > 20.0f) {
                prevPoint = [recognizer locationInView:self];
                return;
            }
            
            if (YES == self.preventsLayoutWhileResizing) {
                if (wChange < 0.0f && hChange < 0.0f) {
                    float change = MIN(wChange, hChange);
                    wChange = change;
                    hChange = change;
                }
                if (wChange < 0.0f) {
                    hChange = wChange;
                } else if (hChange < 0.0f) {
                    wChange = hChange;
                } else {
                    float change = MAX(wChange, hChange);
                    wChange = change;
                    hChange = change;
                }
            }
//            
//            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y,
//                                     self.bounds.size.width + (wChange),
//                                     self.bounds.size.height + (hChange));
//            resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
//                                              self.bounds.size.height-kZDStickerViewControlSize,
//                                              kZDStickerViewControlSize, kZDStickerViewControlSize);
//            deleteControl.frame = CGRectMake(0, 0,
//                                             kZDStickerViewControlSize, kZDStickerViewControlSize);
//            customControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
//                                            0,
//                                            kZDStickerViewControlSize,
//                                            kZDStickerViewControlSize);
            resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize+10,
                                              self.bounds.size.height-kZDStickerViewControlSize+10,
                                              kZDStickerViewControlSize,
                                              kZDStickerViewControlSize);
            deleteControl.frame = CGRectMake(-20, -20,
                                             kZDStickerViewControlSize, kZDStickerViewControlSize);
            customControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                            0,
                                            kZDStickerViewControlSize,
                                            kZDStickerViewControlSize);
             */
            prevPoint = [recognizer locationInView:self];
        }
        
        /* Rotation */
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                          [recognizer locationInView:self.superview].x - self.center.x);
        float angleDiff = deltaAngle - ang;
        
        if (NO == preventsResizing) {
            self.transform = CGAffineTransformMakeRotation(-angleDiff);
        }
        
        borderView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, -10);
        [borderView setNeedsDisplay];
        
        [self setNeedsDisplay];
       
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        prevPoint = [recognizer locationInView:self];
        
        deltaAngle = atan2(self.frame.origin.y+self.bounds.size.height - self.center.y,
                           self.frame.origin.x+self.bounds.size.width - self.center.x);
        
        [self setNeedsDisplay];
    }
     [self.superview setNeedsDisplay];
    
}

- (void)setupDefaultAttributes {
    
    
    if (self.frame.size.width != 0 || self.frame.size.height != 0) {
        
        borderView = [[SPGripViewBorderView alloc] initWithFrame:CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, kSPUserResizableViewGlobalInset)];
        [borderView setHidden:YES];
        [self addSubview:borderView];
        
        if (kSPUserResizableViewDefaultMinWidth > self.bounds.size.width*0.5) {
            self.minWidth = kSPUserResizableViewDefaultMinWidth;
            self.minHeight = self.bounds.size.height * (kSPUserResizableViewDefaultMinWidth/self.bounds.size.width);
        } else {
            self.minWidth = self.bounds.size.width*0.5;
            self.minHeight = self.bounds.size.height*0.5;
        }
        self.preventsPositionOutsideSuperview = YES;
        self.preventsLayoutWhileResizing = YES;
        self.preventsResizing = NO;
        self.preventsDeleting = NO;
        self.preventsCustomButton = YES;
#ifdef ZDSTICKERVIEW_LONGPRESS
        UILongPressGestureRecognizer* longpress = [[UILongPressGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(longPress:)];
        [self addGestureRecognizer:longpress];
#endif
        deleteControl = [[UIButton alloc]initWithFrame:CGRectMake(-10, -10,
                                                                  kZDStickerViewControlSize, kZDStickerViewControlSize)];
        deleteControl.backgroundColor = [UIColor clearColor];
        [deleteControl setImage:[UIImage imageNamed:@"ZDBtn3.png"] forState:UIControlStateNormal];
        deleteControl.userInteractionEnabled = YES;
        [deleteControl addTarget:self action:@selector(btnDeleteClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]
        //                                          initWithTarget:self
        //                                          action:@selector(singleTap:)];
        //    [deleteControl addGestureRecognizer:singleTap];
        [self addSubview:deleteControl];
        
        resizingControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-kZDStickerViewControlSize+10,
                                                                       self.frame.size.height-kZDStickerViewControlSize+10,
                                                                       kZDStickerViewControlSize, kZDStickerViewControlSize)];
        resizingControl.backgroundColor = [UIColor clearColor];
        resizingControl.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"ZDBtn2.png"];
        resizingControl.image = image;
        
        
        UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(resizeTranslate:)];
        [resizingControl addGestureRecognizer:panResizeGesture];
        [self addSubview:resizingControl];
        
        customControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-kZDStickerViewControlSize,
                                                                     0,
                                                                     kZDStickerViewControlSize, kZDStickerViewControlSize)];
        customControl.backgroundColor = [UIColor clearColor];
        customControl.userInteractionEnabled = YES;
        customControl.image = nil;
        UITapGestureRecognizer * customTapGesture = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(customTap:)];
        [customControl addGestureRecognizer:customTapGesture];
        [self addSubview:customControl];
        
        
        deltaAngle = atan2(self.frame.origin.y+self.bounds.size.height - self.center.y,
                           self.frame.origin.x+self.bounds.size.width - self.center.x);

    }
    
}
-(void)deleteStickerHandle
{
    //self.hidden = YES;
    NSLog(@"zdSticker %@",self.subviews);
    
    for (id obj in self.subviews) {
        [obj removeFromSuperview];
    }
    
}
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setupDefaultAttributes];
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupDefaultAttributes];
    }
    return self;
}

- (void)setContentView1:(UIView *)newContentView {
    [contentView1 removeFromSuperview];
    contentView1 = newContentView;
    
    contentView1.frame = CGRectInset(self.bounds, 0, 0);
    
    contentView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentView1.clipsToBounds = NO;
   // [self addSubview:contentView1];
    [self.contentView addSubview:contentView1];
    
    for (UIView* subview in [contentView1 subviews]) {
        [subview setFrame:CGRectMake(0, 0,
                                     contentView1.frame.size.width,
                                     contentView1.frame.size.height)];
        subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    [self bringSubviewToFront:borderView];
    [self bringSubviewToFront:resizingControl];
    [self bringSubviewToFront:deleteControl];
    [self bringSubviewToFront:customControl];
}

#if IPHONE5

#endif

- (void)setBounds:(CGRect)newFrame {
    [super setBounds:newFrame];
//    contentView.frame = CGRectInset(self.bounds, 0, 0);
//    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    for (UIView* subview in [contentView subviews]) {
//        [subview setFrame:CGRectMake(0, 0,
//                                     contentView.frame.size.width,
//                                     contentView.frame.size.height)];
//        subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    }
    
   
    contentView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    borderView.frame = CGRectInset(self.bounds,
                                   kSPUserResizableViewGlobalInset,
                                   -10);
    resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize+10,
                                      self.bounds.size.height-kZDStickerViewControlSize+10,
                                      kZDStickerViewControlSize,
                                      kZDStickerViewControlSize);
    deleteControl.frame = CGRectMake(-10, -10,
                                     kZDStickerViewControlSize, kZDStickerViewControlSize);
    customControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                    0,
                                    kZDStickerViewControlSize,
                                    kZDStickerViewControlSize);
    [borderView setNeedsDisplay];
}

- (void)setFrame:(CGRect)newFrame {
    [super setFrame:newFrame];
    contentView1.frame = CGRectInset(self.bounds, 0, 0);
    contentView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    for (UIView* subview in [contentView1 subviews]) {
        [subview setFrame:CGRectMake(0, 0,
                                     contentView1.frame.size.width,
                                     contentView1.frame.size.height)];
        subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    borderView.frame = CGRectInset(self.bounds,
                                   kSPUserResizableViewGlobalInset,
                                   -10);
    resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize+10,
                                      self.bounds.size.height-kZDStickerViewControlSize+10,
                                      kZDStickerViewControlSize,
                                      kZDStickerViewControlSize);
    
    deleteControl.frame = CGRectMake(-10, -10,
                                     kZDStickerViewControlSize, kZDStickerViewControlSize);
    
    
    customControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                      0,
                                      kZDStickerViewControlSize,
                                      kZDStickerViewControlSize);
    [borderView setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    touchStart = [touch locationInView:self.superview];
    if([_delegate respondsToSelector:@selector(stickerViewDidBeginEditing:)]) {
        [_delegate stickerViewDidBeginEditing:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    deltaAngle = atan2(self.frame.origin.y+self.bounds.size.height - self.center.y,
                       self.frame.origin.x+self.bounds.size.width - self.center.x);
    if([_delegate respondsToSelector:@selector(stickerViewDidEndEditing:)]) {
        [_delegate stickerViewDidEndEditing:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    if([_delegate respondsToSelector:@selector(stickerViewDidCancelEditing:)]) {
        [_delegate stickerViewDidCancelEditing:self];
    }
}

- (void)translateUsingTouchLocation:(CGPoint)touchPoint {
    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - touchStart.x,
                                    self.center.y + touchPoint.y - touchStart.y);
    if (self.preventsPositionOutsideSuperview) {
        // Ensure the translation won't cause the view to move offscreen.
        CGFloat midPointX = CGRectGetMidX(self.bounds);
        if (newCenter.x > self.superview.bounds.size.width - midPointX) {
            newCenter.x = self.superview.bounds.size.width - midPointX;
        }
        if (newCenter.x < midPointX) {
            newCenter.x = midPointX;
        }
        CGFloat midPointY = CGRectGetMidY(self.bounds);
        if (newCenter.y > self.superview.bounds.size.height - midPointY) {
            newCenter.y = self.superview.bounds.size.height - midPointY;
        }
        if (newCenter.y < midPointY) {
            newCenter.y = midPointY;
        }
    }
    self.center = newCenter;
}


//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    CGPoint touchLocation = [[touches anyObject] locationInView:self];
//    if (CGRectContainsPoint(resizingControl.frame, touchLocation)) {
//        return;
//    }
//    
//    CGPoint touch = [[touches anyObject] locationInView:self.superview];
//    //[self translateUsingTouchLocation:touch];
//    [self.superview setNeedsDisplay];
//    touchStart = touch;
//}

- (void)hideDelHandle
{
    resizingControl.hidden = YES;
}

- (void)showDelHandle
{
    resizingControl.hidden = NO;
}

- (void)hideEditingHandles
{
    resizingControl.hidden = YES;
    
    deleteControl.hidden = YES;
    
    customControl.hidden = YES;
    
    [borderView setHidden:YES];
}

- (void)showEditingHandles
{
    if (NO == preventsCustomButton) {
        customControl.hidden = NO;
    } else {
        customControl.hidden = YES;
    }
    if (NO == preventsDeleting) {
        deleteControl.hidden = NO;
    } else {
        deleteControl.hidden = YES;
    }
    if (NO == preventsResizing)
    {
        if([self.contentView1 isKindOfClass:[OHAttributedLabel class]])
        {
        OHAttributedLabel *label = (OHAttributedLabel*)self.contentView1;
        if(label && label.isIn3DMode)
        {
            resizingControl.hidden = YES;
        }
        else
        {
            resizingControl.hidden = NO;
        }
        }
        
    } else {
        resizingControl.hidden = YES;
    }
    [borderView setHidden:NO];
}

- (void)showCustmomHandle
{
    customControl.hidden = NO;
}

- (void)hideCustomHandle
{
    customControl.hidden = YES;
}

- (void)setButton:(ZDSTICKERVIEW_BUTTONS)type image:(UIImage*)image
{
    switch (type) {
        case ZDSTICKERVIEW_BUTTON_RESIZE:
            resizingControl.image = image;
            break;
        case ZDSTICKERVIEW_BUTTON_DEL:
           //deleteControl.image = image;
            break;
        case ZDSTICKERVIEW_BUTTON_CUSTOM:
            customControl.image = image;
            break;
            
        default:
            break;
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint buttonPoint = [self convertPoint:point toView:deleteControl];
    if ([deleteControl pointInside:buttonPoint withEvent:event]) { // you may add your requirement here
        return deleteControl;
    }
    CGPoint buttonPoint1 = [self convertPoint:point toView:resizingControl];
    if ([resizingControl pointInside:buttonPoint1 withEvent:event]) { // you may add your requirement here
        return resizingControl;
    }
    CGFloat radius = 20.0;
    CGRect frame = CGRectMake(-radius, -radius,
                              self.bounds.size.width ,
                              self.bounds.size.height);
    
    
    if (CGRectContainsPoint(frame, point)){
        return self;
    }

    return [super hitTest:point withEvent:event];
}

@end
