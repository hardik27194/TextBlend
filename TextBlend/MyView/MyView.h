//
//  MyView.h
//  LabelDemo
//
//  Created by Hemang on 09/11/13.
//  Copyright (c) 2013 Space-O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "OHAttributedLabel.h"
#import "MyLabel.h"
#import "ZDStickerView.h"
#import "UIImage+FX.h"

@interface MyView : UIView{
    
    BOOL checkBack;
}

@property (nonatomic,strong) UIImageView *imgBack;

@property (nonatomic, strong) NSMutableArray *arrAdded;

@property (readwrite) CGRect textRect;

@end
