//
//  LoginViewController.h
//  ToDo
//
//  Created by Jelena Alfirevic on 12/14/16.
//  Copyright © 2016 Jelena Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmButtonLeadingConstraint;
@property (strong,nonatomic) NSDictionary *attributes;
- (void)configurePlaceholders;
- (void)configureTextField:(UITextField *)textField;
@end
