//
//  UpdateDataProcessor.h
//  TextBlend
//
//  Created by Wayne Rooney on 19/12/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//

/*
 Class for genral functions specifically for saving and retrieving the data.It is used using a singleton shared instance. It is a sub class of NSObject.
 */
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
