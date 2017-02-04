//
//  Article.h
//  Vesti
//
//  Created by Djuro Alfirevic on 2/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *portal;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *region;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
