//
//  DataManager.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/25/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"

@interface DataManager ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation DataManager

#pragma mark - Properties

- (void)setUserLocation:(CLLocation *)userLocation {
    _userLocation = userLocation;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        if (error) {
            NSLog(@"CLGeocoder error: %@", error.localizedDescription);
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark =[placemarks firstObject];
            
            self.userLocality = placemark.locality;
            
            NSLog(@"ISOCountryCode: %@", placemark.ISOcountryCode);
            NSLog(@"Country: %@", placemark.country);
            NSLog(@"Postal code: %@", placemark.postalCode);
            NSLog(@"Administrative area: %@", placemark.administrativeArea);
            NSLog(@"Locality: %@", placemark.locality);
            NSLog(@"Sub locality: %@", placemark.subLocality);

        }
        
    }];
}

- (void)setUserLocality:(NSString *)userLocality {
    _userLocality = userLocality;
    
    // Via delegate
    if (self.delegate) {
        [self.delegate dataManagerDidUpdateLocality];
    }
    
    // Via notification
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCALITY_UPDATED_NOTIFICATION object:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.persistentContainer.viewContext;
    }
    
    return _managedObjectContext;
}

#pragma mark - Designted Initializer

+ (instancetype)sharedManager {
    static DataManager *shared;
    
    @synchronized (self) {
        if (shared == nil) {
            shared = [[DataManager alloc] init];
        }
    }
    
    return shared;
}

#pragma mark - Public API

- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    // Sorting
    if (sortKey) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
    }
    
    // Filtering
    if (filter) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
        [fetchRequest setPredicate:predicate];
    }
    
    // Execute fetch request
    NSError *error;
    NSArray *resultsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error fetching: %@" , error.localizedDescription);
    }
    
    return [resultsArray mutableCopy];
}

- (void)deleteObject:(NSManagedObject *)object {
    [self.managedObjectContext deleteObject:object];
    [self.managedObjectContext save:nil];
}

- (void)updateObject:(NSManagedObject *)object {
    [object.managedObjectContext save:nil];
}

- (void)logObject:(NSManagedObject *)object {
    NSEntityDescription *description = object.entity;
    NSDictionary *attributes = [description attributesByName];
    
    for (NSString *attribute in attributes) {
        NSLog(@"%@ = %@," , attribute, [object valueForKey:attribute]);
    }
}

- (NSInteger)numberOfTasksPerTaskGroup:(TaskGroup)group {
    NSString *filter = [NSString stringWithFormat:@"group = %ld" , group];

    NSArray *tasksArray = [self fetchEntity:NSStringFromClass([DBTask class])
                                 withFilter:filter
                                withSortAsc:NO
                                     forKey:nil];
    
    return tasksArray.count;
}

- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group {
    DBTask *task = (DBTask *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([DBTask class]) inManagedObjectContext:self.managedObjectContext];
    
    task.heading = title;
    task.desc = description;
    
    if (self.userLocation) {
        task.latitude = self.userLocation.coordinate.latitude;
        task.longitude = self.userLocation.coordinate.longitude;
    }
    
    // Date
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = DATE_FORMAT;
    task.date = [dateFormater stringFromDate:[NSDate date]];
    
    task.group = group;
    
    // Save
    [task.managedObjectContext save:nil];
    
}

@end
