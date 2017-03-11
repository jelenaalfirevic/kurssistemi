//
//  Bookmark.h
//  Browser
//
//  Created by Djuro Alfirevic on 3/10/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bookmark : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;

- (instancetype)initWithTitle:(NSString *)title andURL:(NSString *)url;
@end
