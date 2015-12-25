//
//  NetworkEngine.h
//  HeyApp
//
//  Created by Kurt on 7/28/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//
/*
 Class used for declaring webservices. It is a sub class of NSObject.
 */
#import <Accounts/Accounts.h>
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//#import <AFNetworking/AFNetworking.h>


typedef void (^completion_block)(id object);
typedef void (^error_block)(NSError *error);
typedef void (^upload_completeBlock)(NSString *url);
//static NSString * const kGoogleClientId = @"27209247905.apps.googleusercontent.com";

@interface NetworkEngine : NSObject{
    

}
@property(nonatomic,strong) AFHTTPRequestOperationManager *httpManager;

-(id)init;
+ (id)sharedNetworkEngine;
//@property(nonatomic,strong) AFHTTPRequestOperationManager *httpManager;
-(void)login_user:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)sign_up_user:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)forgot_password:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)create_post:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSDictionary *)params_string;
-(void)getLocalPostsOfUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getGlobalPostsOfUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getFriendsPosts:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)like_post:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSDictionary *)params_string;
-(void)comment_on_post:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSDictionary *)params_string;
-(void)getLikesForSelectedPost:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)addFriend:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)removeFriend:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getCommentsOfSelectedPost:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)reportPost:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getProfileDetails:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)uploadBase64ImageWithCompletionBlock:(completion_block)completionBlock withErrorBlock:(error_block)errorBlock selectedData :(NSData *)data_upload isProfileImage:(BOOL)is_profile_image;
-(void)uploadBase64ImageForCreatePostWithCompletionBlock:(completion_block)completionBlock withErrorBlock:(error_block)errorBlock selectedData :(NSData *)data_upload isProfileImage:(BOOL)is_profile_image;
-(void)getMediaFromUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getProfileDetailsOtherUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getPopularHashTags:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)searchHashTags:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getSelectedHashTagsByDate:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;
-(void)getSelectedHashTagsByPopularity:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string;

@end
