//
//  Utility.h
//  TextBlend
//
//  Created by Wayne Rooney on 19/12/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//

/*
 Class for genral functions used in the application. It is a sub class of NSObject.
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^alert_completion_block)(UIAlertAction *alert_action,NSString *button_title_string);

@interface Utility : NSObject{
   
}

+(BOOL)isNetworkReachable;

+(void) showErrorAlert:(id)error forViewController:(UIViewController *)selected_view_controller;

+ (UIImage*)resizeImage:(UIImage*)image withWidth:(CGFloat)width withHeight:(CGFloat)height;

+(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;

+ (UIColor *) colorWithHexString: (NSString *) hexString;

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

+(CGSize)sizeOfTextString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize;

+(NSString*)getFormattedNumberStringFor:(int)number ;

+(void)saveUserDetails:(id)object;

+(void)removeUserDetails;

+(void)saveUserSpecificDetail:(NSString *)value forkeyName:(NSString *)key_name;

+(UIImage *)resizeImageForDevice:(UIImage *)image;

+ (NSMutableURLRequest*) makeMultipartDataForParams:(NSDictionary*)paramDict path:(NSString *)service httpMethod:(NSString *)method;

+(void)showAlertForError:(NSError*)error ;

+(NSDate *) getDateFromString:(NSString *)dateString;

+(void) paddingTextField:(UITextField *) textField;

+(void) paddingTextFieldInSearchController:(UITextField *) textField;

+(UIImage* )resizedImage:(UIImage *)inImage rect:(CGRect) thumbRect;

+(void)setGridImage:(UIImage*)image forButton:(UIButton *)button ;

+ (UIView *)loadViewFromNib:(NSString *)nibName forClass:(id)forClass;

+(void)showAlertControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller withButtonTitles:(NSArray *)button_titles_array withAlertCompletionBlock:(alert_completion_block)alert_block;

+(void)showAlertControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller;

+(void)showActionSheetControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller;

+(void)showActionSheetControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller withButtonTitles:(NSArray *)button_titles_array withAlertCompletionBlock:(alert_completion_block)alert_block;

+(void)showToastWithMessage :(NSString *)message onView : (UIView *)view;

+(void)showToastWithMessageWithDuration :(NSString *)message onView : (UIView *)view;

+ (NSString *) getCurrentDate;

+(void) noInternetAlert;

+(void) somethingWentWrongAlert;

+(BOOL) validEmail:(NSString*) emailString ;

+(BOOL) validData:(id) _data;

+(BOOL) emptyString:(NSString*)string;

+(NSString *)getDateFromStringForMessages:(NSString *)str;

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

+(CGFloat)getMaximumWidth:(CGFloat)min_width forKey:(NSString *)key_value forSelectedArray:(NSArray *)selectedArray withFont:(UIFont *)font withMaxSize:(CGSize)selectedSize;

+(NSString *)getFormattedString:(NSNumber *)selected_amount_num;
+(CGGradientRef)getGradientSpaceRef:(UIColor*)startColor andEndColor:(UIColor*)endColor withPercenatgeValue:(int)percentage;;
+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;

//+(void)setGridImage:(UIImage*)image forButton:(UIButton *)button ;
//+(void)loadAudioForURL:(NSString*)sound_url inView:(UIView*)view ;
//+(NSString*)getFormattedNumberStringFor:(int)number ;
//+(NSDate *) getDateFromString:(NSString *) dateString;
//+(NSMutableURLRequest *) makeRequestForservicePath:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL;
//+(NSMutableURLRequest *) makeRequestForservicePath:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//+(void)showAlertWithString:(NSString*)message;
//+(void)showAlertForError:(NSError*)error;
//+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc;
//+(void) paddingTextField:(UITextField *) textField;
//+(UIImage* )resizedImage:(UIImage *)inImage rect:(CGRect) thumbRect;
//+ (NSMutableURLRequest*) makeMultipartDataForParams:(NSDictionary*)paramDict path:(NSString *)service httpMethod:(NSString *)method;
//+ (BOOL)savePic:(UIImage*)image ;
//+(UIImage*)loadImageWithName:(NSString*)file_name;
//+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc source:(UIImagePickerControllerSourceType)source_type;
//+(void)openImagePickerControllerForViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>*)vc source:(UIImagePickerControllerSourceType)source_type overLay:(UIView*)overlayView;
//+(void)setGridImage:(NSString*)urlString forButton:(UIButton*)button changeURL:(BOOL)shouldChange;
//+(void) paddingTextFieldInSearchController:(UITextField *) textField;
//+ (UIView *)loadViewFromNib:(NSString *)nibName forClass:(id)forClass;
//
//+(NSMutableURLRequest *) makeRequestForservicePathArray:(NSString *)service httpMethod:(NSString *)method params:(NSArray*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//+(NSMutableURLRequest *) makeRequestForservicePathString:(NSString *)service httpMethod:(NSString *)method params:(NSString *)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//
//+(NSMutableURLRequest *) makeRequestForservicePathForItunes:(NSString *)service httpMethod:(NSString *)method params:(NSDictionary*)paramDict isSSL:(BOOL)is_SSL withURLParam:(NSString*)param;
//+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
//+(NSString *) getMainCategoryNameFromCategoryID:(NSString *)categoryID;
//+(NSString *) getMainCategoryIDFromCategoryName:(NSString *)categoryName;


@end
