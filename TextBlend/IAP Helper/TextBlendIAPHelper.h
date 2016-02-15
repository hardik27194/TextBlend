//
//  TextBlendIAPHelper.h
//  TextBlend
//
//  Created by Itesh Dutt on 14/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "IAPHelper.h"

@interface TextBlendIAPHelper : IAPHelper
+ (TextBlendIAPHelper *)sharedInstance;
+ (TextBlendIAPHelper *)sharedInstanceWithSelectedIdentifier:(NSString *)selected_identifier ;
@end
