//
//  MyLabel.h
//  ShapesPhoto
//
//  Created by Hemang on 08/11/13.
//  Copyright (c) 2013 Space-O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OHAttributedLabel.h"

#import "MyView.h"

@class MyView;

@interface MyLabel : OHAttributedLabel <UIGestureRecognizerDelegate>{
    MyView *objView;
    CGPoint startLocation;
}

@property (retain, nonatomic) IBOutlet UIPanGestureRecognizer *panRecognizer;
@property (retain, nonatomic) IBOutlet UIRotationGestureRecognizer *rotationRecognizer;
@property (retain, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchRecognizer;
@property (retain, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

@property(nonatomic,assign) NSUInteger gestureCount;
@property(nonatomic,assign) CGPoint touchCenter;
@property(nonatomic,assign) CGPoint rotationCenter;
@property(nonatomic,assign) CGPoint scaleCenter;
@property(nonatomic,assign) CGFloat scale;

@property(nonatomic,assign) CGSize cropSize;
@property(nonatomic,assign) CGFloat outputWidth;
@property(nonatomic,assign) CGFloat minimumScale;
@property(nonatomic,assign) CGFloat maximumScale;

@end
