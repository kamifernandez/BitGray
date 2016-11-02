//
//  UrlConstructor.h
//  Linker
//
//  Created by KUBO on 11/25/15.
//  Copyright © 2015 KUBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlConstructor : NSObject

+(NSString *)userList;
+(NSString *)albumList:(NSString *)userId;
+(NSString *)photoList:(NSString *)albumId;
+(NSString *)postList:(NSString *)userId;
+(NSString *)commentList:(NSString *)postId;

@end
