//
//  UrlConstructor.m
//  Linker
//
//  Created by KUBO on 11/25/15.
//  Copyright © 2015 KUBO. All rights reserved.
//

#import "UrlConstructor.h"

static NSString *domain = @"http://jsonplaceholder.typicode.com/";

@implementation UrlConstructor

+(NSString *)userList{
    
    NSString *url = [NSString stringWithFormat:@"%@users",domain];
    
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)albumList:(NSString *)userId{
    
    NSString *url = [NSString stringWithFormat:@"%@albums?userId=%@",domain,userId];
    
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)photoList:(NSString *)albumId{
    
    NSString *url = [NSString stringWithFormat:@"%@photos?albumId=%@",domain,albumId];
    
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)postList:(NSString *)userId{
    
    NSString *url = [NSString stringWithFormat:@"%@posts?userId=%@",domain,userId];
    
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)commentList:(NSString *)postId{
    
    NSString *url = [NSString stringWithFormat:@"%@comments?postId=%@",domain,postId];
    
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
