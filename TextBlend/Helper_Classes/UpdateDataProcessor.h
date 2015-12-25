//
//  UpdateDataProcessor.h
//  HeyApp
//
//  Created by Kurt on 7/28/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Appdelegate.h"

@interface UpdateDataProcessor : NSObject{
    
}
+(id) sharedProcessor;
//@property(strong, nonatomic) UserInfo *currentUserInfo;
//-(void) saveUserDetails:(NSDictionary *)userDict ;
//-(void)updateUserDetails:(NSDictionary *)userDict;
//-(NSArray *) fetchMultipleEntitiesByName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
//- (void) deleteAllObjects: (NSString *) entityDescription;
//-(void)updateUserStatus:(NSString *)current_status forUserDict:(NSDictionary *)userDict;
//-(void)updateUseProfileImageURL:(NSString *)updated_url forUserDict:(NSDictionary *)userDict;

//-(void) checkAndSave:(NSManagedObject *) managedObject;
//-(NSManagedObject *) fetchEntityByName:(NSString *) entityName forAttribute:(NSString *) attribute Value:(NSString *) value;
//-(NSArray *) fetchMultipleEntitiesByName:(NSString *) entityName withPredicate:(NSPredicate *) predicate;
//-(NSArray *) fetchMultipleEntitiesByName:(NSString *) entityName;
//+(NSManagedObjectContext *) newManagedOBjectContext;
//-(void) saveUserDetails:(NSDictionary *)userDict;
//- (void) deleteAllObjects: (NSString *) entityDescription ;
//-(void)saveMainCategoriesDetails:(NSArray *)categoryDict;



@property(strong,nonatomic) NSManagedObjectContext *dataContext;

//@property(strong, nonatomic) UserInfo *currentUserInfo;







@end
