//
//  IAPHelper.h
//  Vessel
//
//  Created by Itesh Dutt on 3/3/15.
//  Copyright (c) 2015 vishal pandit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject
{
    SKProduct *selected_sk_product;
    
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler withSelectedIdentifier:(NSMutableSet *)selected_product_identifier;
- (void)buyProduct:(SKProduct *)product;

- (BOOL)productPurchased:(NSString *)productIdentifier;
-(void)removePurchasedProducts;
- (void)restoreCompletedTransactions;
@end
