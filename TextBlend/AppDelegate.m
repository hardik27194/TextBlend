//
//  AppDelegate.m
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectImageBackgroundViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize isVertical;
@synthesize navigation_controller;;

-(NSString *)getPlistDocumentDirectoryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistDocumentDirectoryPath=[documentsDirectory stringByAppendingPathComponent:@"Fonts.plist"];
    return plistDocumentDirectoryPath;
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [application setStatusBarHidden:YES];
    [self checkNetwork];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    //if (![[NSFileManager defaultManager]fileExistsAtPath:[self getPlistDocumentDirectoryPath]]) {
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"FontsList" ofType:@"plist"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:plistPath]];
        [data writeToFile:[self getPlistDocumentDirectoryPath] atomically:YES];
        
    //}
    
    SelectInitialImageViewController *select_image_background_vc=[[SelectInitialImageViewController alloc]init];;
//    SelectImageBackgroundViewController *select_image_background_vc=[[SelectImageBackgroundViewController alloc]init];
    self.navigation_controller=[[UINavigationController alloc]initWithRootViewController:select_image_background_vc];
//    select_image_background_vc.view.backgroundColor=[UIColor greenColor];
    self.navigation_controller.navigationBarHidden=YES;
    self.window.rootViewController=self.navigation_controller;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.collectionview.TextBlend" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TextBlend" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TextBlend.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - MBProgress HUD Methods -
-(void)showProgressAnimatedView
{
    if (!progressView) {
        
        progressView=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
        //  progressView.tintColor=[UIColor redColor];
        progressView.labelText=@"Loading";
        //       progressView.detailsLabelText=@"Loading";
        progressView.autoresizingMask=UIViewAutoresizingNone;
        progressView.color=[UIColor blackColor];
        progressView.cornerRadius=10;
        progressView.activityIndicatorColor=[UIColor whiteColor];
        [self.window addSubview:progressView];
        
    }
    
    [progressView show:YES];
    
    
    
    
    
}

-(void)hideProgressAnimatedView
{
    [progressView hide:YES];
}


-(void)removeProgressAnimatedView{
    
    
    progressView=nil;
    [progressView removeFromSuperview];
    
}

#pragma mark - CHeck Network

-(void)checkNetwork{
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            
        }
        else if (status == AFNetworkReachabilityStatusNotReachable){
            
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            
        }
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
}


@end
