//
//  IAPHelper.m
//  Vessel
//
//  Created by Itesh Dutt on 3/3/15.
//  Copyright (c) 2015 vishal pandit. All rights reserved.
//

#import "IAPHelper.h"

NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";
@interface IAPHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation IAPHelper{
    SKProductsRequest *_productsRequest;
    // You also keep track of the completion handler for the outstanding products request, ...
    RequestProductsCompletionHandler _completionHandler;
    // ... the list of product identifiers passed in, ...
    NSSet *_productIdentifiers;
    // ... and the list of product identifiers that have been previously purchased.
    NSMutableSet * _purchasedProductIdentifiers;
    
}


- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers

{
    self = [super init];
    if (self) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        // Check for previously purchased products
        //_purchasedProductIdentifiers = [NSMutableSet set];
        _purchasedProductIdentifiers = [[NSMutableSet set]mutableCopy];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
                
            } else {
                
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        
                [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
    }
    return self;
    
}


- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler

{
   
    // a copy of the completion handler block inside the instance variable
    _completionHandler = [completionHandler copy];
    // Create a new instance of SKProductsRequest, which is the Apple-written class that contains the code to pull the info from iTunes Connect
    [_productsRequest cancel];
        _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];

}
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler withSelectedIdentifier:(NSMutableSet *)selected_product_identifier

{
    
    // a copy of the completion handler block inside the instance variable
    _completionHandler = [completionHandler copy];
    // Create a new instance of SKProductsRequest, which is the Apple-written class that contains the code to pull the info from iTunes Connect
    [_productsRequest cancel];
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:selected_product_identifier];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response

{
        _productsRequest = nil;
    NSArray * skProducts = response.products;
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error

{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Failed to load list of products."  message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [message show];
    
    NSLog(@"Failed to load list of products.");
    
    _productsRequest = nil;
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}

- (BOOL)productPurchased:(NSString *)productIdentifier

{
    BOOL isPurchase=NO;
    if (productIdentifier && _purchasedProductIdentifiers.count) {
        isPurchase= [_purchasedProductIdentifiers containsObject:productIdentifier];

    }
    return isPurchase;
    
}


-(void)removePurchasedProducts
{
    [_purchasedProductIdentifiers removeAllObjects];
}

- (void)buyProduct:(SKProduct *)product

{
    
    NSLog(@"Buying %@...", product.productIdentifier);
    selected_sk_product=product;
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}


#pragma mark -
#pragma mark In App Purchase Methods


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowProgress" object:nil];
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchased:
                
                [self completeTransaction:transaction];
                
                break;
                
            case SKPaymentTransactionStateFailed:
                
                [self failedTransaction:transaction];
                
                break;
                
            case SKPaymentTransactionStateRestored:
                
                [self restoreTransaction:transaction];
                
            default:
                
                break;
                
        }
        
    };
    
}

// called when the transaction was successful

- (void)completeTransaction:(SKPaymentTransaction *)transaction

{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HideProgress" object:nil];    
    [self provideContentForProductIdentifier:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:transaction.payment.productIdentifier];
    
}

// called when a transaction has been restored and successfully completed

- (void)restoreTransaction:(SKPaymentTransaction *)transaction

{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HideProgress" object:nil];

    NSLog(@"restoreTransaction...");
//    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Restored successfully!" message:@"Enjoy!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [message show];
     //[self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [self provideContentForProductIdentifier:transaction];

    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
}



// called when a transaction has failed

- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HideProgress" object:nil];
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled) {
        
     //   UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertTitle message:transaction.error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      //  [message show];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)provideContentForProductIdentifier:(SKPaymentTransaction  *)payment_transaction {
    
    NSLog(@"provideContentForProductIdentifier");
    if (![_purchasedProductIdentifiers containsObject:payment_transaction.payment.productIdentifier]) {
        [_purchasedProductIdentifiers addObject:payment_transaction.payment.productIdentifier];
        
    }
    
    if (selected_sk_product) {
                
        if ([[NSFileManager defaultManager]fileExistsAtPath:[kAppDelegate getPlistDocumentDirectoryPath]]) {
//            NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"FontsList" ofType:@"plist"];
            NSString* plistPath =[kAppDelegate getPlistDocumentDirectoryPath];//[[NSBundle mainBundle] pathForResource:@"FontsList" ofType:@"plist"];
            NSMutableArray *fonts_plist_array = [[NSArray arrayWithContentsOfFile:plistPath] mutableCopy];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"ProductIdentifier == %@",selected_sk_product.productIdentifier];;
            NSArray *filteredArray=[fonts_plist_array filteredArrayUsingPredicate:predicate];
            if (filteredArray.count) {
                NSMutableDictionary *selected_font_dict=[[filteredArray lastObject]mutableCopy];
                NSInteger selectedIndex=[fonts_plist_array indexOfObject:selected_font_dict];
                [selected_font_dict setValue:[NSNumber numberWithBool:YES] forKey:@"IsAlreadyBought"];
                [fonts_plist_array replaceObjectAtIndex:selectedIndex withObject:selected_font_dict];
                [fonts_plist_array writeToFile:[kAppDelegate getPlistDocumentDirectoryPath] atomically:YES];

            }
            
           // [data writeToFile:[kAppDelegate getPlistDocumentDirectoryPath] atomically:YES];
            
        }
        
        
        NSMutableDictionary *product_detail_dict=[[NSMutableDictionary alloc]init];
        [product_detail_dict setValue:selected_sk_product.price forKey:@"price"];
        [product_detail_dict setValue:selected_sk_product.productIdentifier forKey:@"identifier"];

        [product_detail_dict setValue:payment_transaction.transactionIdentifier forKey:@"productIdentifier"];
        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:payment_transaction.payment.productIdentifier];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchasedNotification object:nil userInfo:product_detail_dict];
    }
    
    
}
- (void)restoreCompletedTransactions {
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}


@end
