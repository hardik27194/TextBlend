//
//  ZDStickerView.h
//
//  Created by Seonghyun Kim on 5/29/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGripViewBorderView.h"
#import "AppDelegate.h"
#import "BCMeshTransformView.h"

typedef enum {
    ZDSTICKERVIEW_BUTTON_NULL,
    ZDSTICKERVIEW_BUTTON_DEL,
    ZDSTICKERVIEW_BUTTON_RESIZE,
    ZDSTICKERVIEW_BUTTON_CUSTOM,
    ZDSTICKERVIEW_BUTTON_MAX
} ZDSTICKERVIEW_BUTTONS;

@protocol ZDStickerViewDelegate;

@interface ZDStickerView : BCMeshTransformView
{
    SPGripViewBorderView *borderView;
    AppDelegate *appDelegate;
}
@property (nonatomic) float deltaAngle;
@property (assign, nonatomic) UIView *contentView1;
@property (nonatomic) BOOL preventsPositionOutsideSuperview; //default = YES
@property (nonatomic) BOOL preventsResizing; //default = NO
@property (nonatomic) BOOL preventsDeleting; //default = NO
@property (nonatomic) BOOL preventsCustomButton; //default = YES
@property (nonatomic) CGFloat minWidth;
@property (nonatomic) CGFloat minHeight;
@property (nonatomic)BOOL stickerDeleted;

@property (strong, nonatomic) id <ZDStickerViewDelegate> delegate;
//custom variables

//Rotate 3D View slider values
@property(nonatomic, assign) CGFloat rotate_3d_x_coordinate_slider_value;
@property(nonatomic, assign) CGFloat rotate_3d_y_coordinate_slider_value;
@property(nonatomic, assign) CGFloat rotate_3d_z_coordinate_slider_value;

- (void)hideDelHandle;
- (void)showDelHandle;
- (void)hideEditingHandles;
- (void)showEditingHandles;
- (void)showCustmomHandle;
- (void)hideCustomHandle;
-(void)deleteStickerHandle;
- (void)setButton:(ZDSTICKERVIEW_BUTTONS)type image:(UIImage*)image;

@end

@protocol ZDStickerViewDelegate <NSObject>
@required
@optional
- (void)stickerViewDidBeginEditing:(ZDStickerView *)sticker;
- (void)stickerViewDidEndEditing:(ZDStickerView *)sticker;
- (void)stickerViewDidCancelEditing:(ZDStickerView *)sticker;
- (void)stickerViewDidClose:(ZDStickerView *)sticker;
#ifdef ZDSTICKERVIEW_LONGPRESS
- (void)stickerViewDidLongPressed:(ZDStickerView *)sticker;
#endif
- (void)stickerViewDidCustomButtonTap:(ZDStickerView *)sticker;
@end


