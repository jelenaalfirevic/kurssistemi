//
//  AppDelegate.m
//  ToDo
//
//  Created by Jelena Alfirevic on 12/14/16.
//  Copyright © 2016 Jelena Alfirevic. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate () <CLLocationManagerDelegate>
@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation AppDelegate

#pragma mark - Properties

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (!_persistentContainer) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ToDo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error) {
                    NSLog(@"UNresolved error %@, %@" , error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return  _persistentContainer;
}

#pragma mark - Public API

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Private API

- (void)configureLocationManager {
    if (![CLLocationManager locationServicesEnabled]) return;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLocationManager];
    
    // If user is logged in, we should present HomeViewController
    if ([Helpers isLoggedIn]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
        navigationController.navigationBarHidden = YES;
        
        self.window.rootViewController = navigationController;
    }
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count >0) {
        DataManager *dataManager = [DataManager sharedManager];
        dataManager.userLocation = [locations lastObject];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location Manager: %@", error.localizedDescription);
}
















@end
