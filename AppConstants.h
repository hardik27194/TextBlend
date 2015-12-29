//
//  AppConstant.h
//  Christmas
//
//  Created by Hirak on 25/02/13.
//  Copyright (c) 2012 Hirak. All rights reserved.
//Test Commit

#import "SIAlertView.h"

#define enableTouch(enable)   [[UIApplication sharedApplication].keyWindow setUserInteractionEnabled:enable];

#define NET_MSG               @"No Internet Connection"
#define AppDel                ((AppDelegate *)[UIApplication sharedApplication].delegate)

#warning TODO: Prevent exclused the iPad code. The app currently not suppotted iPad.
//#define isPad                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPad                 NO

#define SharedObj             [HMSharedClass sharedInstance]

#define imageName(imageName)  [UIImage imageNamed:imageName]

#define UserDefault           [NSUserDefaults standardUserDefaults]

#define NotificationCenter    [NSNotificationCenter defaultCenter]

#define enableTouch(enable)   [[UIApplication sharedApplication].keyWindow setUserInteractionEnabled:enable];

#define RGBCOLOR(r,g,b)       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kFontAvenirBlack      @"Avenir-Black"
#define kFontAvenirMedium     @"Avenir-Medium"
#define kFontAvenirRoman      @"Avenir-Roman"
#define kFontArial            @"ArialMT"
#define kFontCooperBlack      @"CooperBlackStd"
#define kFontImpact           @"Impact"
#define kFontAppleCasual      @"AppleCasual" 


#define  kDeviceName          [[UIDevice currentDevice] name]
#define  kLocalizedModel      [[UIDevice currentDevice] localizedModel]
#define  kSystemVersion       [[UIDevice currentDevice] systemVersion]
#define  kSystemName          [[UIDevice currentDevice] systemName]
#define  kModel               [[UIDevice currentDevice] model]
#define CScreenRect                          [[UIScreen mainScreen] bounds]
#define CScreenWidth                        [UIScreen mainScreen].bounds.size.width
#define CScreenHeight                       [UIScreen mainScreen].bounds.size.height
#define CScreenWidthLandscape               [UIScreen mainScreen].bounds.size.height
#define CScreenHeightLandscape              [UIScreen mainScreen].bounds.size.width
#define CScreenCenter                       CGPointMake(CScreenWidth/2,CScreenHeight/2)
#define CScreenCenterForLandscape           CGPointMake(CScreenHeight/2,CScreenWidth/2)
#define AppName               @"BlendPhotosAndVideo"
#define AppURL                @"http://goo.gl/jhqLS7"
#define AppID                 @"972943815"
#define PurchaseAppProductIdentifier @"purchase.app.blendphotosandvideo"
#define kViewedTutorial @"ViewedTutorial"
#define kViewedTutorialForMoveAndScale @"ViewedTutorialForMoveAndScale"

#define NumberOfItemsCanChooseWithoutPurchase 2
#define NumberOfItemsCanChooseWithPurchase 5


float static SCALE_1_1_WIDTH = 280.0f;
float static SCALE_1_1_HEIGHT = 280.0f;
float static SCALE_3_4_WIDTH = 280.0f;
float static SCALE_3_4_HEIGHT = 350.0f;
float static HEIGHT_DIFF = 36.0f;

#define kErrorHeader          @"Error"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//Messages...
#define kMsgAlertLoading      @"Please Wait..."
#define kMsgErrorMessage      @"Error: Please try later"
#define NEW_LABEL_DEFAULT_TEXT @"DOUBLE TAP TO EDIT TEXT"


#define strtoint(str) [str intValue]
#define strtofloat(str) [str floatValue]
#define inttostr(intval) [NSString stringWithFormat:@"%d", intval]
#define floattostr(floatval) [NSString stringWithFormat:@"%0.2f", floatval]
#define floattostrformat(floatval, format) [NSString stringWithFormat:format, floatval]

#define trim(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
#define isempty(str) trim(str).length == 0
#define isinvalidamount(str) trim(str).intValue <= 0

// UI Helpers:

#define initview(viewclass, var) \
NSString *nibname = NSStringFromClass([viewclass class]); \
viewclass *var = [[viewclass alloc] initWithNibName:nibname bundle:nil]

#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define    IsPortrait               UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation)
#define    IsLandscape              UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)

#define    WINDOW_WIDTH             [UIScreen mainScreen].applicationFrame.size.width    ///< i.e. for iPhone it is 320 for portrait and 300 for landscape orientation
#define    WINDOW_HEIGHT            [UIScreen mainScreen].applicationFrame.size.height   ///< i.e. for iPhone it is 460 for portrait and 480 for landscape orientation
#define    WINDOW_WIDTH_ORIENTED    (IsPortrait ? WINDOW_WIDTH : WINDOW_HEIGHT)          ///< i.e. 320 for portrait and 480 for landscape orientation
#define    WINDOW_HEIGHT_ORIENTED   (IsPortrait ? WINDOW_HEIGHT : WINDOW_WIDTH)          ///< i.e. 460 for portrait and 320 for landscape orientation


#define    SCREEN_WIDTH_ORIENTED    (IsPortrait ? SCREEN_WIDTH : SCREEN_HEIGHT)
#define    SCREEN_HEIGHT_ORIENTED   (IsPortrait ? SCREEN_HEIGHT : SCREEN_WIDTH)
#define    NAVBAR_HEIGHT            44.
#define    TOOLBAR_HEIGHT           44.
#define    TABBAR_HEIGHT            49.

#define     STATUSBAR_FRAME         [[UIApplication sharedApplication] statusBarFrame]


#define    KEYBOARD_SIZE_PORTRAIT   (IsIPhone ? CGSizeMake(320, 216) : CGSizeMake(768, 264))
#define    KEYBOARD_SIZE_LANDSCAPE  (IsIPhone ? CGSizeMake(480, 162) : CGSizeMake(1024, 352))
#define    KEYBOARD_SIZE            (IsPortrait ? KEYBOARD_SIZE_PORTRAIT : KEYBOARD_SIZE_LANDSCAPE)

#define    AUTORESIZE_CENTER        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
#define    AUTORESIZE_STRETCH       UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
////// NSLOG
#define   SHOW_LOGS             YES
#define   SHOW_TEXTURES_LOGS    NO
#define   Log(format, ...)      if (SHOW_LOGS) NSLog(@"%s: %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:format, ## __VA_ARGS__]);
#define   TexLog(format, ...)   if (SHOW_LOGS && SHOW_TEXTURES_LOGS) NSLog(@"%s: %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:format, ## __VA_ARGS__]);
#define   Error(format, ...)    if (SHOW_LOGS) NSLog(@"ERROR: %@", [NSString stringWithFormat:format, ## __VA_ARGS__]);
#define   Mark                  if (SHOW_LOGS) NSLog(@"Start %s", __PRETTY_FUNCTION__);
#define   MarkEnd                  if (SHOW_LOGS) NSLog(@"End %s", __PRETTY_FUNCTION__);

// user defaults
#define XDEL_OBJECT(k) [[NSUserDefaults standardUserDefaults] removeObjectForKey:k];
#define XGET_OBJECT(v) [[NSUserDefaults standardUserDefaults] objectForKey:v]
#define XSET_OBJECT(k,v) [[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
#define XGET_STRING(v) [[NSUserDefaults standardUserDefaults] stringForKey:v]
#define XSET_STRING(k,v) [[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
#define XGET_FLOAT(v) [[NSUserDefaults standardUserDefaults] floatForKey:v]
#define XSET_FLOAT(k,v) [[NSUserDefaults standardUserDefaults] setFloat:v forKey:k];
#define XGET_BOOL(v) [[NSUserDefaults standardUserDefaults] boolForKey:v]
#define XSET_BOOL(k,v) [[NSUserDefaults standardUserDefaults] setBool:v forKey:k];
#define XGET_INT(v) [[NSUserDefaults standardUserDefaults] integerForKey:v]
#define XSET_INT(k,v) [[NSUserDefaults standardUserDefaults] setInteger:v forKey:k];
#define XSYNC [[NSUserDefaults standardUserDefaults] synchronize];

// notification center
#define XNC [NSNotificationCenter defaultCenter]
#define XNCADD(n,sel) [[NSNotificationCenter defaultCenter] addObserver:self selector:sel name:n object:nil];
#define XNCREMOVE [[NSNotificationCenter defaultCenter] removeObserver:self];
#define XNCPOST(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:self];

// collection shortcuts
#define XDEFAULT(_value, _default) ([[NSNull null] isEqual:(_value)] ? (_default) : (_value))
#define XFMT(...) [NSString stringWithFormat: __VA_ARGS__]
#define XARRAY(...) [NSArray arrayWithObjects: __VA_ARGS__, nil]
#define XDICT(...) [NSDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]
#define XMARRAY(...) [NSMutableArray arrayWithObjects: __VA_ARGS__, nil]
#define XMDICT(...) [NSMutableDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]

#define XMCOPY(_obj) [_obj mutableCopy]
#define xcopy(_obj) [_obj copy]


// UIAlertView methods

//alert with only message
#define DisplayAlert(msg) { SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:msg]; [alertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDestructive handler:nil]; alertView.transitionStyle = SIAlertViewTransitionStyleBounce; [alertView show]; }
//alert with message and title
#define DisplayAlertWithTitle(msg,title) { SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:msg]; [alertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDestructive handler:nil]; alertView.transitionStyle = SIAlertViewTransitionStyleBounce; [alertView show]; }


// Paths:
#pragma mark - Paths

#define   BundlePath                    [[NSBundle mainBundle] resourcePath]
#define   PathToResource(resourceName)  [BundlePath stringByAppendingPathComponent:resourceName]

#define   DocumentsPath                 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define   LibraryPath                   [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define   SharedDataPath                DocumentsPath

#define   CachedDataPath                [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define   TemporaryDataPath             [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPHONE_SIMULATOR TARGET_IPHONE_SIMULATOR
#define IS_IPOD   ([[[UIDevice currentDevice] model] rangeOfString:@"iPod"].location!=NSNotFound)
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height == 568.0f
#define IS_HEIGHT_LTE_568 [[UIScreen mainScreen ] bounds].size.height < 568.0f
#define IS_IPHONE_4 (( IS_IPHONE || IS_IPOD) && IS_HEIGHT_LTE_568 && IS_RETINA)
#define IS_IPHONE_3 (( IS_IPHONE || IS_IPOD) && IS_HEIGHT_LTE_568 && !IS_RETINA)

#define IS_IPAD_2 (IS_IPAD && !IS_RETINA)
#define IS_IPAD_3 (IS_IPAD && IS_RETINA)

#define SCREENSIZE [[UIScreen mainScreen] bounds].size.height

#define CSelfViewHeight                      self.view.bounds.size.height
#define CSelfViewWidth                       self.view.bounds.size.width
#define CViewWidth(v)                        v.frame.size.width
#define CViewHeight(v)                       v.frame.size.height
#define CViewX(v)                            v.frame.origin.x
#define CViewY(v)                            v.frame.origin.y
#define CRectX(f)                            f.origin.x
#define CRectY(f)                            f.origin.y
#define CRectWidth(f)                        f.size.width
#define CRectHeight(f)                       f.size.height

#define CViewSetWidth(v, w)                  [v setFrame:CGRectMake(CViewX(v), CViewY(v), w, CViewHeight(v))]
#define CViewSetHeight(v, h)                 [v setFrame:CGRectMake(CViewX(v), CViewY(v), CViewWidth(v), h)]
#define CViewSetX(v, x)                      [v setFrame:CGRectMake(x, CViewY(v), CViewWidth(v), CViewHeight(v))]
#define CViewSetY(v, y)                      [v setFrame:CGRectMake(CViewX(v), y, CViewWidth(v), CViewHeight(v))]
#define CViewSetSize(v, w, h)                [v setFrame:CGRectMake(CViewX(v), CViewY(v), w, h)]
#define CViewSetOrigin(v, x, y)              [v setFrame:CGRectMake(x, y, CViewWidth(v), CViewHeight(v))]
#define CViewSetXnWidth(v, x, w)             [v setFrame:CGRectMake(x, CViewY(v), w, CViewHeight(v))]
#define CViewSetYnHeight(v, y, h)            [v setFrame:CGRectMake(CViewX(v), y, CViewWidth(v), h)]


#define CRectSetWidth(f, w)                  CGRectMake(CRectX(f), CRectY(f), w, CRectHeight(f))
#define CRectSetHeight(f, h)                 CGRectMake(CRectX(f), CRectY(f), CRectWidth(f), h)
#define CRectSetX(f, x)                      CGRectMake(x, CRectY(f), CRectWidth(f), CRectHeight(f))
#define CRectSetY(f, y)                      CGRectMake(CRectX(f), y, CRectWidth(f), CRectHeight(f))
#define CRectSetSize(f, w, h)                CGRectMake(CRectX(f), CRectY(f), w, h)
#define CRectSetOrigin(f, x, y)              CGRectMake(x, y, CRectWidth(f), CRectHeight(f))


#define GCDBackgroundThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define GCDBackgroundThreadHighPriority dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
#define GCDBackgroundThreadLowPriority dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
#define GCDMainThread dispatch_get_main_queue()
             