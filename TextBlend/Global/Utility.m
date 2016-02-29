//
//  Utility.m
//  TextBlend
//
//  Created by Wayne Rooney on 19/12/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.

#import "Utility.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+Toast.h"
@implementation Utility


+(UIImage *)resizeImageForDevice:(UIImage *)image{
    UIImage *scaledImage;
    
    if ([UIScreen mainScreen].scale >2.9) {
        scaledImage = image;
    }
    else if ([UIScreen mainScreen].scale >1.9){
        scaledImage=     [UIImage imageWithCGImage:[image CGImage] scale:(image.scale * 0.66) orientation:(image.imageOrientation)];
    }
    else if ([UIScreen mainScreen].scale >0.9){
        scaledImage=     [UIImage imageWithCGImage:[image CGImage] scale:(image.scale * 0.33) orientation:(image.imageOrientation)];
        
    }
    return scaledImage;
    
}
+(void)saveUserDetails:(id)object{
    
    /*
     if ([self validData:[object valueForKey:kCoverImage]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kCoverImage] forKey:kCoverImage];
     }
     
     if ([self validData:[object valueForKey:kUserBio]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kUserBio] forKey:kUserBio];
     }
     
     if ([self validData:[object valueForKey:kCountry]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kCountry] forKey:kCountry];
     }
     
     if ([self validData:[object valueForKey:kProfileImage]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kProfileImage] forKey:kProfileImage];
     }
     if ([self validData:[object valueForKey:kThumbImage]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kThumbImage] forKey:kThumbImage];
     }
     
     if ([self validData:[object valueForKey:kUserID]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kUserID] forKey:kUserID];
     }
     if ([self validData:[object valueForKey:kUserEmail]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kUserEmail] forKey:kUserEmail];
     }
     if ([self validData:[object valueForKey:kUserStatusLevel]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kUserStatusLevel] forKey:kUserStatusLevel];
     }
     if ([self validData:[object valueForKey:kUserType]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kUserType] forKey:kUserType];
     }
     
     if ([self validData:[object valueForKey:kUserName]]) {
     [USER_DEFAULTS setValue:[object valueForKey:kUserName] forKey:kUserName];
     }
     
     [USER_DEFAULTS synchronize];
     */
}

+(void)saveUserSpecificDetail:(NSString *)value forkeyName:(NSString *)key_name{
    
    if ([self validData:value]) {
        [USER_DEFAULTS setValue:value forKey:key_name];
    }
    
    [USER_DEFAULTS synchronize];
    
}

+(void)removeUserDetails{
    
    
    if ([self validData:[USER_DEFAULTS valueForKey:kUserID]]) {
        [USER_DEFAULTS removeObjectForKey:kUserID];
    }
    
    if ([self validData:[USER_DEFAULTS valueForKey:kUserEmail]]) {
        [USER_DEFAULTS removeObjectForKey:kUserEmail];
    }
    
    if ([self validData:[USER_DEFAULTS valueForKey:kUserStatusLevel]]) {
        [USER_DEFAULTS removeObjectForKey:kUserStatusLevel];
    }
    
    if ([self validData:[USER_DEFAULTS valueForKey:kUserType]]) {
        [USER_DEFAULTS removeObjectForKey:kUserType];
    }
    
    if ([self validData:[USER_DEFAULTS valueForKey:kUserName]]) {
        [USER_DEFAULTS removeObjectForKey:kUserName];
    }
    [USER_DEFAULTS synchronize];
    
}

+(BOOL)isNetworkReachable{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}


+(NSString*)getFormattedNumberStringFor:(int)number {
    
    float float_num = (float)number;
    NSString *formatted_number = @"";
    if(number>1000) {
        float remainder =(float)(number%1000);
        if(remainder>0)
            formatted_number = [NSString stringWithFormat:@"%.1fK", (float_num/1000)];
        else formatted_number = [NSString stringWithFormat:@"%dK", (number/1000)];
        
        
    }
    else if(number>10000){
        float remainder =(float)(number%10000);
        
        if(remainder>0)
            formatted_number = [NSString stringWithFormat:@"%.1fK", float_num/10000];
        else formatted_number = [NSString stringWithFormat:@"%dK", (number/10000)];
        
    }
    else if(number>1000000){
        float remainder =(float)(number%1000000);
        
        if(remainder>0)
            formatted_number = [NSString stringWithFormat:@"%.1fM", float_num/1000000];
        
        else formatted_number = [NSString stringWithFormat:@"%dM", (number/1000000)];
        
    }
    else if(number>10000000){
        
        float remainder =(float)(number%10000000);
        
        if(remainder>0)
            formatted_number = [NSString stringWithFormat:@"%.1fM", float_num/10000000];
        else formatted_number = [NSString stringWithFormat:@"%dM", (number/10000000)];
        
        
    }
    
    else formatted_number = [NSString stringWithFormat:@"%d", number];
    return formatted_number;
}
+(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize
{
    //  UIImage *image = [UIImage imageNamed:@"home_screen"];
    // NSLog(@"%f",image.size.width);
    
    
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
    roundedView.clipsToBounds = YES;
    roundedView.layer.borderColor = [UIColor whiteColor].CGColor;
    roundedView.layer.borderWidth = 1.5;
    
    
    
    
}

+(CGSize)sizeOfTextString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize{
    
    CGSize sizeOfText = [aString boundingRectWithSize: aSize options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes: [NSDictionary dictionaryWithObject:aFont forKey:NSFontAttributeName] context: nil].size;
    
    return sizeOfText;
    
}

+ (NSMutableURLRequest*) makeMultipartDataForParams:(NSDictionary*)paramDict path:(NSString *)service httpMethod:(NSString *)method{
    
    
    NSString *boundary = [NSString stringWithFormat:@"---------------------------44247638221121663601275327610"];
    NSMutableData *body = [NSMutableData data];
    
    for (NSString *key in [paramDict allKeys]) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        if([key isEqualToString:@"recomm_image_url"]){
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"user_pic.png\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[paramDict objectForKey:key] ];
        }
        
        else {
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[paramDict valueForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        
        
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //  [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"submit\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"SUBMIT" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *httpRequest=@"http://";
    
    NSString *servicePath=[NSString stringWithFormat:@"%@%@%@",httpRequest,kServerHostName,service];
    
    servicePath=[servicePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:servicePath];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:method];
    
    [request setHTTPBody:body];
    NSLog(@"%@",request);
    return request;
    //
    //        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //        [body appendData:[@"Content-Disposition: form-data; name= \"user[display_photo]\"; filename=\hulk.jpg\\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //    //    //this appends the image data
    //        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //        [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //        [body appendData:[[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //       // [body appendData:data];
    //       [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //   return body;
}

+(void)showAlertForError:(NSError*)error {
    
    [Utility showAlertWithString:[NSString stringWithFormat:@"Error: %@",error.localizedDescription]];
}

+(void)showAlertWithString:(NSString*)message {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
    
}
+(NSDate *) getDateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-DD HH:mm:ss"];
    //  NSLog(@"%@",[dateFormatter dateFromString:dateString]);
    
    return [dateFormatter dateFromString:dateString];
    
    
}

+(void) paddingTextField:(UITextField *) textField{
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
}

+(void) paddingTextFieldInSearchController:(UITextField *) textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
}

+(UIImage* )resizedImage:(UIImage *)inImage rect:(CGRect) thumbRect{
    CGImageRef	imageRef = [inImage CGImage];
    CGImageAlphaInfo	alphaInfo = CGImageGetAlphaInfo(imageRef);
    // There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
    // see Supported Pixel Formats in the Quartz 2D Programming Guide
    // Creating a Bitmap Graphics Context section
    // only RGB 8 bit images with alpha of kCGImageAlphaNoneSkipFirst, kCGImageAlphaNoneSkipLast, kCGImageAlphaPremultipliedFirst,
    // and kCGImageAlphaPremultipliedLast, with a few other oddball image kinds are supported
    // The images on input here are likely to be png or jpeg files
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    // Build a bitmap context that's the size of the thumbRect
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,	// width
                                                thumbRect.size.height,	// height
                                                CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
                                                4 * thumbRect.size.width,	// rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                alphaInfo
                                                );
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
    UIImage*	result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);	// ok if NULL
    CGImageRelease(ref);
    
    return result;
}

+ (UIImage*)resizeImage:(UIImage*)image withWidth:(CGFloat)width withHeight:(CGFloat)height{
    CGSize newSize = CGSizeMake(width, height);
    CGFloat widthRatio = newSize.width/image.size.width;
    CGFloat heightRatio = newSize.height/image.size.height;
    
    if(widthRatio > heightRatio){
        newSize=CGSizeMake(image.size.width*heightRatio,image.size.height*heightRatio);
    }
    else{
        newSize=CGSizeMake(image.size.width*widthRatio,image.size.height*widthRatio);
    }
    
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(void)setGridImage:(UIImage*)image forButton:(UIButton *)button {
    
    UIImageView *gridImageView;
    gridImageView = (UIImageView*)[button viewWithTag:1];
    
    if(!gridImageView){
        gridImageView = [[UIImageView alloc]init];
        gridImageView.frame = CGRectMake(5, 5, button.frame.size.width-11, button.frame.size.height-11);
        [button addSubview:gridImageView];
        gridImageView.tag = 1;
    }
    gridImageView.hidden = NO;
    gridImageView.image = image;
    
    UIImageView *placeholderImageView;
    placeholderImageView = (UIImageView*)[button viewWithTag:2];
    
    if(!placeholderImageView){
        placeholderImageView = [[UIImageView alloc]init];
        placeholderImageView.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
        [button addSubview:placeholderImageView];
        [button sendSubviewToBack:placeholderImageView];
        placeholderImageView.tag = 2;
        placeholderImageView.image = [UIImage imageNamed:@"thumbnail_placeholder.png"];
    }
    placeholderImageView.hidden = NO;
    UIImageView *playImageView;
    playImageView = (UIImageView*)[button viewWithTag:23];
    
    if(!playImageView){
        playImageView = [[UIImageView alloc]init];
        playImageView.frame = CGRectMake(25, 25, button.frame.size.width/2, button.frame.size.height/2);
        
        [button addSubview:playImageView];
        //  [button sendSubviewToBack:placeholderImageView];
        playImageView.tag = 23;
        playImageView.image = [UIImage imageNamed:@"feed_play_watermark.png"];
        playImageView.hidden = YES;
    }
    
    
}


+ (UIView *)loadViewFromNib:(NSString *)nibName forClass:(id)forClass{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    for(id currentObject in topLevelObjects)
        if([currentObject isKindOfClass:forClass])
        {
            //[currentObject retain];
            // [topLevelObjects release];
            return currentObject ;
        }
    
    return nil;
    
    
}

+(void)showAlertControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller withButtonTitles:(NSArray *)button_titles_array withAlertCompletionBlock:(alert_completion_block)alert_block
{
    
    if (!title || [title isEqualToString:@""])
    {
        title = APP_NAME;
    }
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSString *button_title in button_titles_array) {
        UIAlertAction *alert_action = [UIAlertAction
                                       actionWithTitle:button_title
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           alert_block(action,button_title);
                                       }];
        [alertController addAction:alert_action];
        
    }
    
    [view_controller presentViewController:alertController animated:YES completion:nil];
    
}
+(void)showAlertControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller
{
    
    if (!title || [title isEqualToString:@""])
    {
        title = @"TextBlend";
    }
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert_action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alert_action];
    
    [view_controller presentViewController:alertController animated:YES completion:nil];
    
}


+(void)showActionSheetControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller
{
    
    if (!title || [title isEqualToString:@""])
    {
        title = APP_NAME;
    }
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *alert_action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alert_action];
    
    [view_controller presentViewController:alertController animated:YES completion:nil];
    
}

+(void)showActionSheetControllerWithMessage:(NSString *)message withCustonTitle:(NSString *)title onView:(UIViewController *)view_controller withButtonTitles:(NSArray *)button_titles_array withAlertCompletionBlock:(alert_completion_block)alert_block
{
    
    //    if (!title || [title isEqualToString:@""])
    //    {
    //        title = @"TextBlend";
    //    }
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *button_title in button_titles_array) {
        UIAlertAction *alert_action = [UIAlertAction
                                       actionWithTitle:button_title
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           alert_block(action,button_title);
                                       }];
        [alertController addAction:alert_action];
        
    }
    
    [view_controller presentViewController:alertController animated:YES completion:nil];
    
}

+(void) showErrorAlert:(id)error forViewController:(UIViewController *)selected_view_controller{
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSDictionary *message_dict=[error copy];
        if ([Utility validData:[message_dict valueForKey:@"message"]]) {
            [Utility showAlertControllerWithMessage:[message_dict valueForKey:@"message"] withCustonTitle:nil onView:selected_view_controller];
        }
        else if ([Utility validData:[message_dict valueForKey:@"Error"]]){
            [Utility showAlertControllerWithMessage:[message_dict valueForKey:@"Error"] withCustonTitle:nil onView:selected_view_controller];
            
        }
        else
            [Utility showAlertControllerWithMessage:TRY_LATER withCustonTitle:nil onView:selected_view_controller];
    }
    else
        [Utility showAlertControllerWithMessage:TRY_LATER withCustonTitle:nil onView:selected_view_controller];
}


+(void)showToastWithMessage :(NSString *)message onView : (UIView *)view
{
    [view makeToast:message];
}
+(void)showToastWithMessageWithDuration :(NSString *)message onView : (UIView *)view
{
    [view makeToast:message duration:2 position:nil];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==12345) {
        if (buttonIndex == 0)
        {// Cancel pressed
            //   tabBarController.selectedIndex=3;
        }
        
    }
    [kAppDelegate hideProgressAnimatedView];
}



+ (NSString *) getCurrentDate
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE, MMM dd, yyyy"];
    NSString *dateStr = [df stringFromDate:todayDate];
    return dateStr;
}

+(void) noInternetAlert{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"There is problem with internet connection. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+(void) somethingWentWrongAlert{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:APP_NAME
                                                    message:@"Something went wrong. Please try again."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [kAppDelegate hideProgressAnimatedView];
    [alert show];
}

+(BOOL) validEmail:(NSString*) emailString {
    
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    // NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

+(BOOL) validData:(id) _data
{
    if(_data!=nil)
    {
        if(![_data isKindOfClass:[NSNull class]])
        {
            return YES;
        }
    }
    return NO;
}


+(BOOL) emptyString:(NSString*)string
{
    return ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0);
}



+(NSString *)getDateFromStringForMessages:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:1]];// timeZoneWithAbbreviation:@"UTC"]];
    //[formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:str];
    [formatter setDateFormat:@"EEE, dd MMM yyyy @ hh:mm aa"];
    return [formatter stringFromDate:date];
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference second];
}


+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+(CGFloat)getMaximumWidth:(CGFloat)min_width forKey:(NSString *)key_value forSelectedArray:(NSArray *)selectedArray withFont:(UIFont *)font withMaxSize:(CGSize)selectedSize{
    
    CGFloat maxNameWidth=min_width;
    NSMutableArray *stateArray = [selectedArray valueForKey:key_value];
    [stateArray removeObjectIdenticalTo:[NSNull null]];
    
    if (stateArray.count) {
        NSNumber* maxLength= [stateArray valueForKeyPath: @"@max.length"];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self.length == %@",maxLength];
        NSArray   *filteredArray=[stateArray filteredArrayUsingPredicate:predicate];
        
        if (filteredArray.count) {
            NSString *maxLengthString=[filteredArray objectAtIndex:0];
            CGRect labelRect = [maxLengthString boundingRectWithSize:selectedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{  NSFontAttributeName : font } context:nil];
            if (labelRect.size.width>maxNameWidth) {
                maxNameWidth=labelRect.size.width+10;
            }
        }
        
    }
    return maxNameWidth;
}

+(NSString *)getFormattedString:(NSNumber *)selected_amount_num{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
    
    //  [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMinimumIntegerDigits:1];
    
    NSString *formattedNumberString = [numberFormatter stringFromNumber:selected_amount_num];
    return formattedNumberString;
    
}



+(CGGradientRef)getGradientSpaceRef:(UIColor*)startColor andEndColor:(UIColor*)endColor withPercenatgeValue:(int)percentage{
    CGGradientRef glossGradient;
    
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 9;
    NSLog(@"Percentage %d",percentage);;
    
    CGFloat red_color_1;
    CGFloat green_color_1;
    CGFloat blue_color_1;
    
    CGFloat red_color_2;
    CGFloat green_color_2;
    CGFloat blue_color_2;
    
    CGFloat red_color_3;
    CGFloat green_color_3;
    CGFloat blue_color_3;
    
    CGFloat red_color_4;
    CGFloat green_color_4;
    CGFloat blue_color_4;
    
    CGFloat red_color_5;
    CGFloat green_color_5;
    CGFloat blue_color_5;
    
    CGFloat red_color_6;
    CGFloat green_color_6;
    CGFloat blue_color_6;
    
    
    CGFloat red_color_7;
    CGFloat green_color_7;
    CGFloat blue_color_7;
    
    
    CGFloat red_color_8;
    CGFloat green_color_8;
    CGFloat blue_color_8;
    
    CGFloat red_color_9;
    CGFloat green_color_9;
    CGFloat blue_color_9;
    
    percentage = 10-percentage;
    switch (percentage) {
        case 0:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];

            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];

            
            const CGFloat *componentsStartColor4= CGColorGetComponents(startColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];

            
            const CGFloat *componentsStartColor5= CGColorGetComponents(startColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];

            
            const CGFloat *componentsStartColor6= CGColorGetComponents(startColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];

            
            const CGFloat *componentsStartColor7= CGColorGetComponents(startColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];

            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];

            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];

            
            
            
            
        }
            break;
        case 1:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(startColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(startColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(startColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(startColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 2:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(startColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(startColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(startColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(startColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 3:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(startColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(startColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(startColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 4:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(startColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(startColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(endColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 5:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(startColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(endColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(endColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 6:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(endColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(endColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(endColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 7:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(endColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(endColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(endColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 8:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(endColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(endColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(endColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(endColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 9:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(endColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(endColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(endColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(endColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(endColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
        case 10:
        {
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(endColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(endColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(endColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(endColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(endColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(endColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(endColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(endColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
  
        default:{
            const CGFloat *componentsStartColor1= CGColorGetComponents(startColor.CGColor);
            red_color_1 = componentsStartColor1[0];
            green_color_1= componentsStartColor1[1];
            blue_color_1= componentsStartColor1[2];
            
            const CGFloat *componentsStartColor2= CGColorGetComponents(startColor.CGColor);
            red_color_2 = componentsStartColor2[0];
            green_color_2= componentsStartColor2[1];
            blue_color_2= componentsStartColor2[2];
            
            
            const CGFloat *componentsStartColor3= CGColorGetComponents(startColor.CGColor);
            red_color_3 = componentsStartColor3[0];
            green_color_3= componentsStartColor3[1];
            blue_color_3= componentsStartColor3[2];
            
            
            const CGFloat *componentsStartColor4= CGColorGetComponents(startColor.CGColor);
            red_color_4 = componentsStartColor4[0];
            green_color_4= componentsStartColor4[1];
            blue_color_4= componentsStartColor4[2];
            
            
            const CGFloat *componentsStartColor5= CGColorGetComponents(startColor.CGColor);
            red_color_5 = componentsStartColor5[0];
            green_color_5= componentsStartColor5[1];
            blue_color_5 = componentsStartColor5[2];
            
            
            const CGFloat *componentsStartColor6= CGColorGetComponents(startColor.CGColor);
            red_color_6 = componentsStartColor6[0];
            green_color_6= componentsStartColor6[1];
            blue_color_6= componentsStartColor6[2];
            
            
            const CGFloat *componentsStartColor7= CGColorGetComponents(startColor.CGColor);
            red_color_7 = componentsStartColor7[0];
            green_color_7= componentsStartColor7[1];
            blue_color_7= componentsStartColor7[2];
            
            
            const CGFloat *componentsStartColor8= CGColorGetComponents(startColor.CGColor);
            red_color_8 = componentsStartColor8[0];
            green_color_8= componentsStartColor8[1];
            blue_color_8= componentsStartColor8[2];
            
            
            const CGFloat *componentsStartColor9= CGColorGetComponents(startColor.CGColor);
            red_color_9 = componentsStartColor9[0];
            green_color_9= componentsStartColor9[1];
            blue_color_9= componentsStartColor9[2];
            
            
            
            
            
        }
            break;
    }
    
    
    
    CGFloat locations[11] = { 0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8, 0.9,1.0 };
    CGFloat components[44] = {
        red_color_1, green_color_1, blue_color_1, 1.0,
        red_color_1, green_color_1, blue_color_1, 1.0,
        red_color_2, green_color_2, blue_color_2, 1.0,
        red_color_3, green_color_3, blue_color_3, 1.0,
        red_color_4, green_color_4, blue_color_4, 1.0,
        red_color_5, green_color_5, blue_color_5, 1.0,
        red_color_6, green_color_6, blue_color_6, 1.0,
        red_color_7, green_color_7, blue_color_7, 1.0,
        red_color_8, green_color_8, blue_color_8, 1.0,
        red_color_9, green_color_9, blue_color_9, 1.0,
        red_color_9, green_color_9, blue_color_9, 1.0,

    
    };
    
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    
    CGColorSpaceRelease(rgbColorspace);

    return glossGradient;
    
}

@end
