//
//  MyLabel.m
//  ShapesPhoto
//
//  Created by Hemang on 08/11/13.
//  Copyright (c) 2013 Space-O. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    _rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    _pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap11:)];
    [self setMultipleTouchEnabled:YES];
    
    self.panRecognizer.cancelsTouchesInView = NO;
    self.panRecognizer.delegate = self;
    self.rotationRecognizer.cancelsTouchesInView = NO;
    self.rotationRecognizer.delegate = self;
    self.pinchRecognizer.cancelsTouchesInView = NO;
    self.pinchRecognizer.delegate = self;
    self.tapRecognizer.numberOfTapsRequired = 2;
    
    [self addGestureRecognizer:self.panRecognizer];
    //[self addGestureRecognizer:self.rotationRecognizer];
   // [self addGestureRecognizer:self.pinchRecognizer];
     [self addGestureRecognizer:self.tapRecognizer];
    return self;
}
- (void)layoutSubviews {
    // resize your layers based on the view's new bounds
    self.layer.frame = self.bounds;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)handleTap11:(UITapGestureRecognizer*)recognizer{
//    MyLabel *lbl = (MyLabel*)recognizer.view;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetLabel" object:nil];
}

- (IBAction)handlePan:(UIPanGestureRecognizer*)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        CGAffineTransform transform = CGAffineTransformTranslate( recognizer.view.transform, translation.x, translation.y);
        recognizer.view.transform = transform;
        recognizer.view.layer.affineTransform = transform;
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DrawIT" object:nil];
    }
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        if(recognizer.state == UIGestureRecognizerStateBegan){
            self.scaleCenter = self.touchCenter;
        }
        
        
        CGFloat deltaX = self.scaleCenter.x-recognizer.view.bounds.size.width/2.0;
        CGFloat deltaY = self.scaleCenter.y-recognizer.view.bounds.size.height/2.0;
        
        CGAffineTransform transform =  CGAffineTransformTranslate(recognizer.view.transform, deltaX, deltaY);
        transform = CGAffineTransformScale(transform, recognizer.scale, recognizer.scale);
        transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
        self.scale *= recognizer.scale;
        recognizer.view.transform = transform;
        
        recognizer.scale = 1;
        
      [[NSNotificationCenter defaultCenter] postNotificationName:@"DrawIT" object:nil];
    }
}

- (IBAction)handleRotation:(UIRotationGestureRecognizer*)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        if(recognizer.state == UIGestureRecognizerStateBegan){
            self.rotationCenter = self.touchCenter;
        }
        CGFloat deltaX = self.rotationCenter.x-recognizer.view.bounds.size.width/2;
        CGFloat deltaY = self.rotationCenter.y-recognizer.view.bounds.size.height/2;
        
        CGAffineTransform transform =  CGAffineTransformTranslate(recognizer.view.transform,deltaX,deltaY);
        transform = CGAffineTransformRotate(transform, recognizer.rotation);
        transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
        recognizer.view.transform = transform;
        recognizer.view.layer.affineTransform = transform;
        
        recognizer.rotation = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DrawIT" object:nil];
    }
    
}

#pragma mark Touches

- (void)handleTouches:(NSSet*)touches
{
    self.touchCenter = CGPointZero;
    if(touches.count < 2) return;
    
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch*)obj;
        CGPoint touchLocation = [touch locationInView:self];
        self.touchCenter = CGPointMake(self.touchCenter.x + touchLocation.x, self.touchCenter.y +touchLocation.y);
    }];
    self.touchCenter = CGPointMake(self.touchCenter.x/touches.count, self.touchCenter.y/touches.count);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}


#pragma mark Gestures

- (BOOL)handleGestureState:(UIGestureRecognizerState)state
{
    BOOL handle = YES;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            self.gestureCount++;
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            self.gestureCount--;
            handle = NO;
            if(self.gestureCount == 0) {
                CGFloat scale = self.scale;
                if(self.minimumScale != 0 && self.scale < self.minimumScale) {
                    scale = self.minimumScale;
                } else if(self.maximumScale != 0 && self.scale > self.maximumScale) {
                    scale = self.maximumScale;
                }
                if(scale != self.scale) {
                    CGFloat deltaX = self.scaleCenter.x-self.bounds.size.width/2.0;
                    CGFloat deltaY = self.scaleCenter.y-self.bounds.size.height/2.0;
                
                    CGAffineTransform transform =  CGAffineTransformTranslate(self.transform, deltaX, deltaY);
                    transform = CGAffineTransformScale(transform, scale/self.scale , scale/self.scale);
                    transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
                    self.userInteractionEnabled = NO;
                    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        self.transform = transform;
                    } completion:^(BOOL finished) {
                        self.userInteractionEnabled = YES;
                        self.scale = scale;
                    }];
                }
                
            }
        } break;
        default:
            break;
    }
    return handle;
}
@end
