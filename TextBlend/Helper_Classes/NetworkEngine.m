//
//  NetworkEngine.m
//  HeyApp
//
//  Created by Kurt on 7/28/14.
//  Copyright (c) 2014 Kurt. All rights reserved.
//

#import "NetworkEngine.h"
#import "UpdateDataProcessor.h"
#import <Foundation/Foundation.h>
#pragma mark - Webservice URL Constants -


#define kLoginUser @"signin.php"
#define kSignUpUser @"signup.php"
#define kForgotPassword @"forgot.php"
#define kCreatePosts @"create-post.php"
#define kGetLocalPosts @"show_local_posts.php"
#define kGetFriendsPosts @"friend_posts.php"
#define kGetGlobalPosts @"show_posts.php"
#define kLikePost @"like_post.php"
#define kUnlikePost @"unlike_post.php"
#define kCommentPost @"comment.php"
#define kGetLikesForAPost @"alluser_like.php"
#define kAddFriend @"friend_request.php"
#define kRemoveFriend @"un_friend.php"
#define kGetAllComments @"comment_post.php"
#define kReportPost @"report_abusepost.php"
#define kGetUserProfile @"get_userprofile.php"
#define kGetOtherUserProfile @"other_userprofile.php"

#define kUploadProfileImage @"user_profile_img.php"
#define kUploadCoverImage @"user_profile_cover.php"
#define kCreatePostUploadImage @"post_img.php"
#define kCreatePostUploadVideo @"post_video.php"
#define kGetUserCreatedPosts @"showall_user_posts.php"
#define kGetHashTagPopular @"search_get_hashtag.php"
#define kSearchHashTag @"search_hashtag.php"
#define kGetHashTagByDate @"search_hashtag_bydate.php"
#define kGetHashTagByPopularity @"search_hashtag_bydate.php"

static NetworkEngine *sharedNetworkEngine=nil;


@implementation NetworkEngine
@synthesize httpManager;



-(id)init {
    
    self = [super init];
    
    if(self) {
        self.httpManager = [AFHTTPRequestOperationManager manager];
        self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"application/x-www-form-urlencoded",@"text/html", nil];
        
    }
    
    return self;
}

+(id) sharedNetworkEngine{
    @synchronized(self) {
        
        if (sharedNetworkEngine==nil)
            sharedNetworkEngine=[[self alloc]init];
      
        
    }
    return sharedNetworkEngine;
    
}

-(void)login_user:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string
    //?email=test121@gmail.com&password=12345"
{
        
    //NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kLoginUser];
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kLoginUser,params_string];

        [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //  NSLog(@"JSON: %@", responseObject);
                NSHTTPURLResponse *response=operation.response;
                if (response.statusCode == 200 ) {
                    if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                        NSNumber *status_num=[responseObject valueForKey:@"status"];
                        if (!status_num.boolValue) {
                            completionBlock(responseObject);
                        }
                        else{
                            errorBlock(responseObject);
                            
                        }
                        
                    }
                    else{
                        errorBlock(responseObject);
                    }
                }
                else{
                    errorBlock(nil);
                }
                
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            id errorResponseObject= operation.responseObject;
            errorBlock(errorResponseObject);
        }];
}


-(void)sign_up_user:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string//?email=test121@gmail.com&password=12345"
{
    
   // NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kSignUpUser];
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kSignUpUser,params_string];

    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  NSLog(@"JSON: %@", responseObject);
        NSHTTPURLResponse *response=operation.response;
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *response_array=[responseObject copy];
                
                if (response_array.count) {
                    NSDictionary *response_dict=[response_array objectAtIndex:0];
                    completionBlock(response_dict);
                }
                else{
                    errorBlock(nil);
                }
            }
            else{
                errorBlock(responseObject);
            }
            
           
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
    
    //[self.httpManager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)  failure:^(AFHTTPRequestOperation *operation, NSError *error) ];
    
}

-(void)forgot_password:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string//?email=test121@gmail.com&password=12345"
{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kForgotPassword,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                
                NSNumber *status_num=[responseObject valueForKey:@"status"];
                if (status_num.boolValue) {
                    completionBlock(responseObject);
                }
                else{
                    errorBlock(responseObject);
                }
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

//-(void)create_post:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string//?email=test121@gmail.com&password=12345"

-(void)create_post:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSDictionary *)params_string//?email=test121@gmail.com&password=12345"
{
    
    //NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kCreatePosts,params_string];
NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kCreatePosts];
 //   NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kCreatePosts,params_string];

    [self.httpManager POST:urlString parameters:params_string success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                
                NSNumber *status_num=[responseObject valueForKey:@"status"];
                if (!status_num.boolValue) {
                    completionBlock(responseObject);
                }
                else{
                    errorBlock(responseObject);
                }
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

-(void)getLocalPostsOfUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string//?email=test121@gmail.com&password=12345"
{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetLocalPosts,params_string];
  //  urlString=@"http://adwordmedia.info/massroots/app/show_posts.php?page=1&show_per_page=5";
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);

            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

-(void)getGlobalPostsOfUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetGlobalPosts,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

-(void)getCommentsOfSelectedPost:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetAllComments,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

-(void)getFriendsPosts:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetFriendsPosts,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

#pragma mark - Likes and Comments -

-(void)like_post:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSDictionary *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kLikePost];
    
    [self.httpManager POST:urlString parameters:params_string success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                
                NSNumber *status_num=[responseObject valueForKey:@"status"];
                if (!status_num.boolValue) {
                    completionBlock(responseObject);
                }
                else{
                    errorBlock(responseObject);
                }
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}



-(void)comment_on_post:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSDictionary *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kCommentPost];
   // errorBlock(nil);
    [self.httpManager POST:urlString parameters:params_string success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                
                NSNumber *status_num=[responseObject valueForKey:@"status"];
                if (!status_num.boolValue) {
                    completionBlock(responseObject);
                }
                else{
                    errorBlock(responseObject);
                }
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

-(void)getLikesForSelectedPost:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetLikesForAPost,params_string];
    NSLog(@"Get likes for post %@",urlString);
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

#pragma mark - Friend And Unfriend MEthods -
-(void)addFriend:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kAddFriend,params_string];
    NSLog(@"Add friend %@",urlString);

    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                
                NSNumber *status_num=[responseObject valueForKey:@"status"];
                if (status_num.intValue==1) {
                    completionBlock(responseObject);
                }
                else{
                    errorBlock(responseObject);
                }
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}
-(void)removeFriend:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kRemoveFriend,params_string];
    NSLog(@"Remove friend %@",urlString);
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                
                NSNumber *status_num=[responseObject valueForKey:@"status"];
                if (!status_num.boolValue) {
                    completionBlock(responseObject);
                }
                else{
                    errorBlock(responseObject);
                }
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

#pragma mark - Profile Details -
-(void)getProfileDetails:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetUserProfile,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}
-(void)getProfileDetailsOtherUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetOtherUserProfile,params_string];
    NSLog(@"Other user profile %@",urlString);
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}


-(void)uploadProfileImage:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string withURL:(NSURL *)url{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kServerHostName,kUploadProfileImage];

    [self.httpManager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileURL:url name:@"profileimage" error:nil];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
  
    }];
}


-(void)getMediaFromUser:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetUserCreatedPosts,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

#pragma mark - Hash Tags API - 


-(void)getPopularHashTags:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetHashTagPopular,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}



-(void)searchHashTags:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kSearchHashTag,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}


-(void)getSelectedHashTagsByDate:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetHashTagByDate,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}


-(void)getSelectedHashTagsByPopularity:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kGetHashTagByPopularity,params_string];
    
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                completionBlock(responseObject);
                
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}



#pragma mark - Misc API -
-(void)reportPost:(completion_block)completionBlock onError:(error_block)errorBlock forParams:(NSString *)params_string{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@?%@",kServerHostName,kReportPost,params_string];
    //post_id=9&user_id=2&report_status=1
    [self.httpManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSHTTPURLResponse *response=operation.response;
        
        if (response.statusCode == 200 ) {
            
            if ([Utility validData:[responseObject valueForKey:@"status"]] ) {
                
                NSNumber *status_num=[responseObject valueForKey:@"status"];
                if (!status_num.boolValue) {
                    completionBlock(responseObject);
                }
                else{
                    errorBlock(responseObject);
                }
            }
            else{
                errorBlock(responseObject);
            }
        }
        else{
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id errorResponseObject= operation.responseObject;
        errorBlock(errorResponseObject);
    }];
}

-(void)uploadBase64ImageForCreatePostWithCompletionBlock:(completion_block)completionBlock withErrorBlock:(error_block)errorBlock selectedData :(NSData *)data_upload isProfileImage:(BOOL)is_profile_image{
        NSString *base64String=[data_upload base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];;
        NSURL *url;
        if (is_profile_image) {
            url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServerHostName,kCreatePostUploadImage]];
            
        }
        else{
            url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServerHostName,kCreatePostUploadVideo	]];
        }
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        NSMutableData *postBody = [NSMutableData data];
        if (is_profile_image) {
            base64String=[NSString stringWithFormat:@"post_image=%@",base64String];
        }
        else{
            base64String=[NSString stringWithFormat:@"post_video=%@",base64String];
        }
        [postBody appendData:[base64String dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:postBody];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        
        operation.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            id responseObj=json;
            NSLog(@"%@",json);
            if ([Utility validData:[json valueForKey:@"status"]]) {
                NSNumber *status_num=[json valueForKey:@"status"];
                
                if (!status_num.boolValue) {
                    completionBlock(json);
                    
                }
                else{
                    errorBlock(responseObj);
                    
                }
            }
            else{
                errorBlock(responseObj);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *image_upload_error) {
            errorBlock(image_upload_error);
            
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
        
}
    
    
-(void)uploadBase64ImageWithCompletionBlock:(completion_block)completionBlock withErrorBlock:(error_block)errorBlock selectedData :(NSData *)data_upload isProfileImage:(BOOL)is_profile_image{
    NSString *base64String=[data_upload base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];;
    NSURL *url;
    if (is_profile_image) {
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServerHostName,kUploadProfileImage]];
   
    }
    else{
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServerHostName,kUploadCoverImage]];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    NSMutableData *postBody = [NSMutableData data];
    if (is_profile_image) {
        base64String=[NSString stringWithFormat:@"user_id=%@&profileimage=%@",[USER_DEFAULTS valueForKey:kUserID],base64String];
    }
    else{
        base64String=[NSString stringWithFormat:@"user_id=%@&coverimage=%@",[USER_DEFAULTS valueForKey:kUserID],base64String];
    }
    [postBody appendData:[base64String dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        id responseObj=json;
        NSLog(@"%@",json);
        if ([Utility validData:[json valueForKey:@"status"]]) {
            NSNumber *status_num=[json valueForKey:@"status"];
            
            if (!status_num.boolValue) {
                completionBlock(json);

            }
            else{
                errorBlock(responseObj);
 
            }
        }
        else{
            errorBlock(responseObj);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *image_upload_error) {
        errorBlock(image_upload_error);
        
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
    
}


@end
