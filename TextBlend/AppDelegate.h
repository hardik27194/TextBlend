//
//  AppDelegate.h
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MBProgressHUD.h"
#import "SelectInitialImageViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MBProgressHUD  *progressView;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,assign) BOOL isVertical;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)hideProgressAnimatedView;
-(void)showProgressAnimatedView;
-(void)removeProgressAnimatedView;

//extern NSString *const FBSessionStateChangedNotification;

@property (readwrite) NSInteger gloabalSelectedTag;
@property (readwrite) NSInteger mainLabelTag;

@property(readwrite) CGFloat colorAlpha;
@property (readwrite) CGFloat R_background;
@property (readwrite) CGFloat G_background;
@property (readwrite) CGFloat B_background;
@property (nonatomic, assign) CGSize selectedSize;
@property (nonatomic, strong) NSMutableArray *selectedItems;



@end

