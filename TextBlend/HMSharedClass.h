//
//  HMSharedClass.h
//  carenga
//
//  Created by Hirak on 19/03/13.
//  Copyright (c) 2013 Hirak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KWLoadingView.h"
#import "KLCPopup.h"

typedef void (^actionAlertBlock) (NSInteger index);
typedef void (^actionFlatBlock) (NSInteger index);

typedef NS_ENUM(NSInteger, ImportType) {
    FacebookImage,
    InstagramImage,
    VideoPreviewType,
    CameraImage,
    GalleryImage
};

@interface HMSharedClass : NSObject
{
    
}

@property (nonatomic, readwrite) ImportType importType;

@property(copy) actionAlertBlock actionAlertBlock;
@property(copy) actionFlatBlock actionFlatBlock;

@property (assign) BOOL isFromNotification;
@property (assign) BOOL isAboutType;
@property(assign) BOOL isOthersProfile;
@property (assign) BOOL isSignUp;
@property(assign) BOOL isFromFacebook;
@property(assign) BOOL isFromEditAccount;
@property (assign) BOOL isForContacts;
@property (assign) BOOL isFromInstagram;
@property (assign) BOOL isFromFlickr;
@property (assign) BOOL isFromTumbler;
@property (assign) BOOL isFrameMode;
@property (assign) BOOL isFromTagged;
@property (assign) BOOL isFromAlbum;
@property (assign) BOOL isFromBackPicture;
@property (assign) BOOL isForTextImage;

//V 2.4 changes

@property (assign) BOOL isGravity;
@property (assign) BOOL isFromCameraVideo;
@property (assign) BOOL isFromInstagramPicture;
@property (assign) BOOL isFromFacebookPicture;
@property (assign) BOOL isFromCameraPicture;

@property (assign) BOOL isFromPortraitRation;

@property (nonatomic,strong) NSString *strNotification;
@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) NSString *strLoginID;
@property (nonatomic,strong) NSString *strOtherID;
@property (nonatomic,strong) NSString *strFriendsID;

@property (nonatomic,strong) UIImage *imageSource;
@property (nonatomic,strong) UIImage *imagePreview;
@property (nonatomic,strong) UIImage *imageMain;
@property (nonatomic,strong) UIImage *imageBackground;
@property (nonatomic,strong) UIImage *imageTextBack;

@property (nonatomic,strong) KWLoadingView *loadingView;

@property (readwrite) int indexValue;

+(HMSharedClass *)sharedInstance;

-(void)showActionAlertWithMultiTitle:(NSString*)title message:(NSString*)message strfirstTitle:(NSString*)strfirstTitle strsecondTitle:(NSString*)strsecondTitle    strThirdTitle:(NSString*)strthirdTitle :(void(^)(NSInteger index))alert;

-(void)showActionAlertWithTitle:(NSString*)title message:(NSString*)message strfirstTitle:(NSString*)strfirstTitle strsecondTitle:(NSString*)strsecondTitle :(void(^)(NSInteger index))alert;
+(NSTimeInterval)timeFromString:(NSString*)timeString;
+(NSString *)convertStringToAddInDatabase:(NSString *)string;
+(NSData*)DicToData:(NSDictionary*)dic;
+(NSDictionary*)DataToDic:(NSData*)data;
+(NSString*)getCurrentDate;
+(int)convertSecondsIntoMinutes:(int)sec;
+(BOOL)isVideoCameraAvailable;
-(BOOL)isNetworkReachable;

-(void)hideLoading;
-(void)hideLoadingQuickly;
-(void)showLoadingWithTextNew:(NSString*)loadingText;
-(void)showLoadingWithText:(NSString*)loadingText;
-(void)showLoadingWithText1:(NSString*)loadingText;
-(void)showActionAlertWithTitleNew:(NSString*)title message:(NSString*)message strfirstTitle:(NSString*)strfirstTitle strsecondTitle:(NSString*)strsecondTitle :(void(^)(NSInteger index))alert;

//V 2.4 Changes

-(void)showInAppAlert:(NSString*)title :(void(^)(NSInteger index))alert;
-(void)showSingleButtonAlertWithTitle:(NSString*)strTitle :(void(^)(NSInteger index))alert;

@end
