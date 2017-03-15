//
//  DataManager.h
//  ToDo
//
//  Created by Djuro Alfirevic on 2/25/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>

@protocol DataManagerDelegate <NSObject>
@optional
- (void)dataManagerDidUpdateLocality;
@end

@interface DataManager : NSObject
@property (strong,nonatomic) CLLocation *userLocation;
@property (strong,nonatomic) NSString *userLocality;
@property (weak,nonatomic) id <DataManagerDelegate> delegate;

+ (instancetype)sharedManager;
- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey;
- (void)deleteObject:(NSManagedObject *)object;
- (void)updateObject:(NSManagedObject *)object;
- (void)logObject:(NSManagedObject *)object;
- (NSInteger)numberOfTasksPerTaskGroup:(TaskGroup)group;
- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group;
@end
