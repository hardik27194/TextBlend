//
//  TextBlendIAPHelper.m
//  TextBlend
//
//  Created by Itesh Dutt on 14/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "TextBlendIAPHelper.h"
//Live Bundle Id Products

static NSString *brushedFont       = @"com.nayeem.brushedFont";
static NSString *chalkboardFont       = @"com.nayeem.chalkboardFont";
static NSString *christmasfonts       = @"com.nayeem.christmasFont";
static NSString *comicfonts       = @"com.nayeem.comicFont";
static NSString *graffitifonts       = @"com.nayeem.graffitiFont";
static NSString *greetingsfonts       = @"com.nayeem.greetingFont";
static NSString *halloweenFonts       = @"com.nayeem.halloweenFont";
static NSString *handwrittenfonts       = @"com.nayeem.handwrittenFont";
static NSString *main_shop_page       = @"com.nayeem.unlockAll";
static NSString *moviefonts       = @"com.nayeem.movieFont";
static NSString *musicFonts       = @"com.nayeem.musicFont";
static NSString *oldNewspaperFont       = @"com.nayeem.oldNewspaperFont";
static NSString *retroFonts       = @"com.nayeem.retroFont";
static NSString *sportsFonts       = @"com.nayeem.sportsFont";
static NSString *tattooFonts       = @"com.nayeem.tattooFont";
static NSString *typewriterFonts       = @"com.nayeem.typewriterFont";
static NSString *weddingFonts       = @"com.nayeem.weddingFont";
@implementation TextBlendIAPHelper
+ (TextBlendIAPHelper *)sharedInstance {
    
    static TextBlendIAPHelper *sharedInstance;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        NSSet *productIdentifiers = [NSSet setWithObjects:brushedFont,christmasfonts,comicfonts,graffitifonts,greetingsfonts,halloweenFonts,handwrittenfonts,main_shop_page,moviefonts,musicFonts,oldNewspaperFont,retroFonts,sportsFonts,tattooFonts,typewriterFonts,weddingFonts  ,nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
        
    });
    
    return sharedInstance;
    
}


@end
