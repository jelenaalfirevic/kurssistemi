//
//  TaskViewController.m
//  ToDo
//
//  Created by Kurs on 2/22/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "TaskViewController.h"
#import <MapKit/MapKit.h>

@interface TaskViewController () <UITextFieldDelegate, DataManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *groupTextField;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectorImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (weak, nonatomic) IBOutlet UIView *greenView;
//@property (weak, nonatomic) IBOutlet UIView *purpleView;
//@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsArray;
@property (nonatomic) NSInteger group;
@end
@implementation TaskViewController

#pragma mark - Properties

- (void)setGroup:(NSInteger)group {
    _group = group;
    
    // Move selector to approriate group
    for (UIView *view in self.viewsArray) {
        if (view.tag == group) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.selectorImageView.center = view.center;
            }];
        }
    }

}


#pragma mark - Actions

- (IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButton:(UIButton *)sender {
    if ([self validationPassed]) {
        if (self.task) {
            self.task.heading = self.titleTextField.text;
            self.task.desc = self.descriptionTextField.text;
            self.task.group = self.group;
            self.task.latitude = DATA_MANAGER.userLocation.coordinate.latitude;
            self.task.longitude = DATA_MANAGER.userLocation.coordinate.longitude;
            
            [DATA_MANAGER updateObject:self.task];
        } else {
        [DATA_MANAGER saveTaskWithTitle:self.titleTextField.text
                                           description:self.descriptionTextField.text
                                                 group:self.group];
         }
        
        [self backButtonTapped:nil];
    }
}

- (IBAction)groupButtonTapped:(UIButton *)sender {
    self.group = sender.tag;
//
//    switch (sender.tag) {
//        case TaskGroupCompleted:
//            center = self.greenView.center;
//            break;
//        case TaskGroupNotCompleted:
//            center = self.orangeView.center;
//            break;
//        case TaskGroupInProgress:
//            center = self.purpleView.center;
//            break;
//    }
    
}

#pragma mark - Private API

- (BOOL)validationPassed {
    if (self.titleTextField.text.length == 0) {
        [self showAlertWithTitle:@"Error"
                      andMessage:@"Please enter task title"];
        return NO;
    }
    if (self.descriptionTextField.text.length == 0) {
        [self showAlertWithTitle:@"Error"
                      andMessage:@"Please enter task description"];
        return NO;
    }
    
    return YES;
}

- (void)configureUI {
    self.locationTextField.text = DATA_MANAGER.userLocality;
    
    if (self.task) {
        self.titleTextField.text = self.task.heading;
        self.descriptionTextField.text = self.task.desc;
        self.group = self.task.group;
        [self.mapView addAnnotation:self.task];
        
        [self zoomToCoordinate:self.task.coordinate];
        
    } else {
        self.group = TaskGroupNotCompleted;
        
        self.mapView.showsUserLocation = YES;
        [self zoomToCoordinate:DATA_MANAGER.userLocation.coordinate];
    }
}

- (void)zoomToCoordinate:(CLLocationCoordinate2D)coordinate {
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.5, 0.5));
    [self.mapView setRegion:region animated:YES];
    

}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    
    // Via delegate
    DataManager *dataManager = DATA_MANAGER;
    dataManager.delegate = self;
    
    // Via notification
    [[NSNotificationCenter defaultCenter] addObserverForName:LOCALITY_UPDATED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.locationTextField.text = DATA_MANAGER.userLocality;
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - DataManagerDelegate

- (void)dataManagerDidUpdateLocality {
    self.locationTextField.text = DATA_MANAGER.userLocality;
}

@end
