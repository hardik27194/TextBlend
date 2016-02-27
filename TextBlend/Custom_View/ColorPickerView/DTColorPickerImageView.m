//
//  DTColorPickerImageView.m
//  ColorPicker
//
//  Created by Darktt on 2015/3/19.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

#import "DTColorPickerImageView.h"
#import "UIImage+ColorPicker.h"

@interface DTColorPickerImageView()
{
    DTColorPickerHandler _handler;
}

@end

@implementation DTColorPickerImageView

+ (instancetype)colorPickerWithFrame:(CGRect)frame
{
    DTColorPickerImageView *colorPicker = [[DTColorPickerImageView alloc] initWithFrame:frame];
    
    return [colorPicker autorelease];
}

+ (instancetype)colorPickerWithImage:(UIImage *)image
{
    DTColorPickerImageView *colorPicker = [[DTColorPickerImageView alloc] initWithImage:image];
    
    return [colorPicker autorelease];
}

#pragma mark - Instance Methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUserInteractionEnabled:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    [self setUserInteractionEnabled:YES];
    [self addColorSelectionView];
    return self;
}
-(void)addColorSelectionView{
    if (!circular_color_view) {
        circular_color_view = [[UIImageView alloc]initWithFrame:CGRectMake(self.self.frame.size.width/2, self.frame.size.height/2, 20, 20)];
        circular_color_view.clipsToBounds=YES;
        circular_color_view.layer.borderColor = [UIColor whiteColor].CGColor;
        circular_color_view.layer.borderWidth = 1;
        circular_color_view.layer.cornerRadius = 10;
        circular_color_view.userInteractionEnabled=YES;
        [self addSubview:circular_color_view];
    }
}
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self == nil) return nil;
    
    [self setUserInteractionEnabled:YES];
    
    return self;
}

- (void)dealloc
{
    if (_handler != nil) {
        Block_release(_handler);
    }
    
    [super dealloc];
}

- (void)handlesDidPickColor:(DTColorPickerHandler)handler
{
    if (_handler != nil) {
        Block_release(_handler);
    }
    
    _handler = Block_copy(handler);
}
-(void)updateFrames:(CGPoint)location{
    
    CGRect circularFrame = circular_color_view.frame;
    circularFrame.origin.x = location.x - (circularFrame.size.width/2);
    circularFrame.origin.y = location.y - (circularFrame.size.height/2);
    circular_color_view.frame = circularFrame;
    [UIView animateWithDuration:0.2 animations:^{
     
    }];
    
    
}
#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    [self pickerColorAtPoint:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    // Respondes when point in self bounds.
    if (!CGRectContainsPoint(self.bounds, location)) {
        return;
    }
    
    [self pickerColorAtPoint:location];
}

- (void)pickerColorAtPoint:(CGPoint)point
{
    [self updateFrames:point];

    CGPoint convertPoint = [self.image convertPoint:point fromImageView:self];
    
    UIColor *color = [self.image pickColorWithPoint:convertPoint];
    
    if (_handler != nil) {
        _handler(color);
        
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(imageView:didPickColorWithColor:)]) {
        [self.delegate imageView:self didPickColorWithColor:color];
    }
}

@end
