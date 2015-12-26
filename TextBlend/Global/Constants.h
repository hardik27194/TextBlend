//
//  Constants.h
//  APP_NAME
//
//  Created by Wayne Rooney on 22/08/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//

#import "HMSharedClass.h"

#ifndef budz_Constants_h
#define budz_Constants_h


#pragma mark - Application Constants -

#define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication]delegate])
#define kServerHostName @"http://adwordmedia.info/massroots/app/"
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define kStoryboard [UIStoryboard storyboardWithName:@"Main" bundle:nil]


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define GREEN_COLOR [UIColor colorWithRed:0.7529 green:1 blue:0.0666 alpha:1]
#define HOME_POSTS_BACKGROUNDCOLOR [UIColor colorWithRed:0.8862 green:0.9215 blue:0.8392 alpha:1]



#define CUSTOM_LIGHT_FONT [UIFont fontWithName:@"OpenSans-Light" size:7]
#define CUSTOM_REGULAR_FONT [UIFont fontWithName:@"OpenSans" size:7]
#define CUSTOM_SEMIBOLD_FONT [UIFont fontWithName:@"OpenSans-Semibold" size:7]
#define CUSTOM_LIGHT_FONT_SIZE(X) [UIFont fontWithName:@"OpenSans-Light" size:X]
#define CUSTOM_REGULAR_FONT_SIZE(X) [UIFont fontWithName:@"OpenSans" size:X]
#define CUSTOM_SEMIBOLD_FONT_SIZE(X) [UIFont fontWithName:@"OpenSans-Semibold" size:X]

#define kNavBarHeight 64
#define kDefaultDistance 10

#define ITUNES_APP_URL_IOS7 @"itms-apps://itunes.apple.com/app/id353372460"
#define SETTINGS_MENU_WIDTH SCREEN_WIDTH

#define APP_NAME @"TextBlend"
#define kUserID @"user_id"
#define kUserType @"type"
#define kUserEmail @"email"
#define kUserStatusLevel @"status_level"
#define kUserName @"user_name"
#define kCoverImage @"cover_image"
#define kUserBio @"user_bio"
#define kCountry @"user_country"
#define kProfileImage @"user_profile_image"
#define kThumbImage @"user_thumb_image"
#define NO_RECORDS_FOUND @"No records found"

#define LIKE_NORMAL_IMAGE [UIImage imageNamed:@"home_like_icon_normal.png"]
#define LIKE_SELECTED_IMAGE [UIImage imageNamed:@"home_like_icon.png"]
#define COMMENT_NORMAL_IMAGE [UIImage imageNamed:@"home_comment_icon.png"]
#define COMMENT_SELECTED_IMAGE [UIImage imageNamed:@"home_comment_icon.png"]
#define NO_IMAGE [UIImage imageNamed:@"no_image.png"]
#define PLAY_ICON_IMAGE [UIImage imageNamed:@"video_play_icon.png"]
#define COMMENT_BLACK_IMAGE [UIImage imageNamed:@"home_comment_icon_black.png"]
#define EDITING_BACKGROUND_COLOR [UIColor colorWithRed:0.7254 green:0.7254 blue:0.7254 alpha:1]



#pragma mark - KEYS -

//#define FTP_SERVER_PATH @"adwordmedia.info/home2/adwordm1/public_html/massroots/app/imgupload"
#define FTP_SERVER_PATH @"adwordmedia.info"

#define FTP_USERNAME @"massroot@adwordmedia.info"
#define FTP_PASSOWRD @"123456"
#define ftp_explicit_port 21


#pragma mark - Text 
#define OFFLINE_INTERNET @"Internet Connection appears to be offline. Please try again later."
#define TRY_LATER @"Please try agin later."

#define DARK_GRAY_COLOR [UIColor colorWithRed:0.1019 green:0.1019 blue:0.1019 alpha:1]



#pragma mark - Derived Constants 
#define SharedObj             [HMSharedClass sharedInstance]
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define UPDATE_MESSAGE_TEXT_NOTIFICATION @"UPDATE_MESSAGE_TEXT_NOTIFICATION"


#endif
