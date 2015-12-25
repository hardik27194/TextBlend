//
//  HMSharedClass.m
//  carenga
//
//  Created by Hirak on 19/03/13.
//  Copyright (c) 2013 Hirak. All rights reserved.
//

#import "HMSharedClass.h"
#import "NetConnection.h"

static HMSharedClass *sharedInstance = nil;

@implementation HMSharedClass

@synthesize actionAlertBlock;
@synthesize isOthersProfile,isFromFacebook,isFromEditAccount,isSignUp,isForContacts,isFromNotification;
@synthesize deviceToken,strLoginID,strOtherID,strFriendsID;
@synthesize loadingView;
@synthesize imagePreview,imageSource,imageMain;
@synthesize isFromInstagram;
@synthesize isFromAlbum,isFromTagged;
@synthesize isFromBackPicture;
@synthesize imageBackground;
@synthesize isForTextImage;
@synthesize imageTextBack;

+(HMSharedClass *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[HMSharedClass alloc] init];
        }
    }
    return sharedInstance;
}

#pragma mark- =========================Alert============================

-(void)showActionAlertWithTitleNew:(NSString*)title message:(NSString*)message strfirstTitle:(NSString*)strfirstTitle strsecondTitle:(NSString*)strsecondTitle :(void(^)(NSInteger index))alert{
    
    self.actionAlertBlock=alert;
  	UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:strfirstTitle,nil];
	alert1.tag=103;
    [alert1 show];
    
}


-(void)showActionAlertWithTitle:(NSString*)title message:(NSString*)message strfirstTitle:(NSString*)strfirstTitle strsecondTitle:(NSString*)strsecondTitle :(void(^)(NSInteger index))alert{
    
    self.actionAlertBlock=alert;
  	UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:strfirstTitle,strsecondTitle,nil];
	alert1.tag=103;
    [alert1 show];
    
}

-(void)showActionAlertWithMultiTitle:(NSString*)title message:(NSString*)message strfirstTitle:(NSString*)strfirstTitle strsecondTitle:(NSString*)strsecondTitle    strThirdTitle:(NSString*)strthirdTitle :(void(^)(NSInteger index))alert{
    
    self.actionAlertBlock=alert;
  	UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:strfirstTitle,strsecondTitle,strthirdTitle,nil];
	alert1.tag=104;
    [alert1 show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //enter text entry
    self.actionAlertBlock(buttonIndex);
    
}

#pragma mark- =========================Conversion============================

+(NSTimeInterval)timeFromString:(NSString*)timeString
{
    NSTimeInterval time = 0.0;
    
    int min = [[[timeString componentsSeparatedByString:@":"] objectAtIndex:0] intValue] * 60;
    int sec = [[[timeString componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
    
    time = min+sec;
    return time;
}

+(NSString *)convertStringToAddInDatabase:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"'"withString:@"''"];
    return string;
}

+(NSData*)DicToData:(NSDictionary*)dic
{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:dic forKey: @"archive"];
    [archiver finishEncoding];
    return data;
}

+(NSDictionary*)DataToDic:(NSData*)data
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
     NSDictionary *dic = [unarchiver decodeObjectForKey:@"archive"];
    [unarchiver finishDecoding];
    return dic;    
}

+(NSString*)getCurrentDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDate = [formatter stringFromDate:date];
    return currentDate;
}

+(int)convertSecondsIntoMinutes:(int)sec
{
    int min = round(sec/60.0);
    return min;
}
+(BOOL) isVideoCameraAvailable
{
	if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
    {
        return NO;
    }
	return YES;
}

#pragma mark- =========================Indicator============================

-(void)showLoadingWithTextNew:(NSString*)loadingText
{
    [self setupLoadingIndicator:loadingText didError:NO];
}

-(void)showLoadingWithText1:(NSString*)loadingText{
    [self setupLoadingIndicator:loadingText didError:NO];
}

-(void)showLoadingWithText:(NSString*)loadingText
{
    enableTouch(NO);
    [self setupLoadingIndicator:loadingText didError:NO];
}

-(void)setupLoadingIndicator:(NSString*)loadingText didError:(BOOL)error {
    
    if (!loadingView) {
        
        loadingView = [[KWLoadingView alloc]initWithFrame: CGRectMake((WINDOW_WIDTH/2)-65, (WINDOW_HEIGHT/2)-65, 130, 131)];
        
    }
    
    [loadingView indicatorText:loadingText didError:error];
    
    BOOL doesContain = [AppDel.window.subviews containsObject:loadingView];
    
    if (!doesContain) {
        [AppDel.window addSubview:loadingView];
    }else{
        [loadingView removeFromSuperview];
        [AppDel.window addSubview:loadingView];
        
    }
    //[AppDel.window addSubview:loadingView];
}

-(void)hideLoading
{
    enableTouch(YES);
    [loadingView hideSelf:YES];
}

-(void)hideLoadingQuickly
{
    enableTouch(YES);
    [loadingView quickHide];
}

#pragma mark- =========================Network============================

-(BOOL)isNetworkReachable
{
	[[NetConnection sharedReachability] setHostName:@"www.google.com"];
	NetworkStatus remoteHostStatus = [[NetConnection sharedReachability] internetConnectionStatus];
	if (remoteHostStatus == NotReachable)
		return NO;
	else if (remoteHostStatus == ReachableViaCarrierDataNetwork || remoteHostStatus == ReachableViaWiFiNetwork)
		return YES;
	return NO;
}

#pragma mark Flat Style Alerts

-(void)showSingleButtonAlertWithTitle:(NSString*)strTitle :(void(^)(NSInteger index))alert{
    
    self.actionFlatBlock=alert;
    
    UIView *galleryView = [UIView new];
    galleryView.frame = CGRectMake(0, 0, 255, 160);
    galleryView.backgroundColor = [UIColor colorWithRed:48/255.0 green:98/255.0 blue:124/255.0 alpha:1.0];
    
    galleryView.layer.cornerRadius = 10.0;
    galleryView.clipsToBounds = YES;
    
    UILabel *lblTitle = [UILabel new];
    lblTitle.frame = CGRectMake(0, 10, 255, 40);
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = AppName;
    lblTitle.font = [UIFont fontWithName:@"Avenir" size:18];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    [galleryView addSubview:lblTitle];
    
    
    UILabel *lblDesc = [UILabel new];
    lblDesc.frame = CGRectMake(0, 45, 255, 60);
    lblDesc.text = strTitle;
    lblDesc.numberOfLines = 0;
    lblDesc.textAlignment = NSTextAlignmentCenter;
    lblDesc.font = [UIFont fontWithName:@"Avenir" size:14];
    lblDesc.textColor = [UIColor whiteColor];
    lblDesc.backgroundColor = [UIColor clearColor];
    [galleryView addSubview:lblDesc];
    
    
    UILabel *lblSep = [UILabel new];
    lblSep.backgroundColor = [UIColor colorWithRed:125/255.0 green:136/255.0 blue:155/255.0 alpha:1.0];
    lblSep.frame = CGRectMake(0, 110, 255, 1);
    [galleryView addSubview:lblSep];
    
    
    UIButton *btnOK = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOK setTitle:@"OK" forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(btnOkClicked) forControlEvents:UIControlEventTouchUpInside];
    btnOK.frame = CGRectMake(0, 114, 255, 40);
    btnOK.titleLabel.textColor = [UIColor whiteColor];
    [galleryView addSubview:btnOK];
    
    
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, (SCREENSIZE == 568)?KLCPopupVerticalLayoutCenter:KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:galleryView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}
-(void)btnOkClicked{
    [KLCPopup dismissAllPopups];
    self.actionFlatBlock(0);
}

-(void)showInAppAlert:(NSString*)title :(void(^)(NSInteger index))alert{
    self.actionFlatBlock=alert;
    
    UIView *galleryView = [UIView new];
    galleryView.frame = CGRectMake(0, 0, 255, 400);
    galleryView.backgroundColor = [UIColor colorWithRed:48/255.0 green:98/255.0 blue:124/255.0 alpha:1.0];
    
    galleryView.layer.cornerRadius = 10.0;
    galleryView.clipsToBounds = YES;
    
    UILabel *lblTitle = [UILabel new];
    lblTitle.frame = CGRectMake(0, 10, 255, 30);
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"In App Upgrade";
    lblTitle.font = [UIFont fontWithName:@"Avenir" size:15];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    [galleryView addSubview:lblTitle];
    
    
    UILabel *lblDesc = [UILabel new];
    lblDesc.frame = CGRectMake(0, 45, 255, 300);
    lblDesc.text = title;
    lblDesc.numberOfLines = 0;
    lblDesc.textAlignment = NSTextAlignmentCenter;
    lblDesc.font = [UIFont fontWithName:@"Avenir" size:14];
    lblDesc.textColor = [UIColor colorWithWhite:1.0 alpha:8.0];
    lblDesc.backgroundColor = [UIColor clearColor];
    [galleryView addSubview:lblDesc];
    
    
    UILabel *lblSep = [UILabel new];
    lblSep.backgroundColor = [UIColor colorWithRed:125/255.0 green:136/255.0 blue:155/255.0 alpha:1.0];
    lblSep.frame = CGRectMake(0, 350, 255, 1);
    [galleryView addSubview:lblSep];
    
    UILabel *lblVSep = [UILabel new];
    lblVSep.backgroundColor = [UIColor colorWithRed:125/255.0 green:136/255.0 blue:155/255.0 alpha:1.0];
    lblVSep.frame = CGRectMake(127, 352, 1, 48);
    [galleryView addSubview:lblVSep];
    
    UIButton *btnYes = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnYes setTitle:@"No thanks" forState:UIControlStateNormal];
    [btnYes addTarget:self action:@selector(btnNoThanksClicked) forControlEvents:UIControlEventTouchUpInside];
    btnYes.frame = CGRectMake(0, 354, 127, 40);
    btnYes.titleLabel.textColor = [UIColor whiteColor];
    [galleryView addSubview:btnYes];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitle:@"Upgrade" forState:UIControlStateNormal];
    btnCancel.frame = CGRectMake(127, 354, 127, 40);
    [btnCancel addTarget:self action:@selector(btnUpgradeClicked) forControlEvents:UIControlEventTouchUpInside];
    btnCancel.titleLabel.textColor = [UIColor whiteColor];
    [galleryView addSubview:btnCancel];
    
    
    
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, (SCREENSIZE >= 568)?KLCPopupVerticalLayoutCenter:KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:galleryView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}
#pragma mark InApp Methods

-(void)btnNoThanksClicked{
    [KLCPopup dismissAllPopups];
    self.actionFlatBlock(0);
}

-(void)btnUpgradeClicked{
    [KLCPopup dismissAllPopups];
    self.actionFlatBlock(1);
}

@end
