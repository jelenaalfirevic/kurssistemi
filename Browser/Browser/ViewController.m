//
//  ViewController.m
//  Browser
//
//  Created by Djuro Alfirevic on 3/10/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "Bookmark.h"

static NSString *const HOMEPAGE = @"www.google.com"; // in Constants.h

@interface ViewController () <UITextFieldDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSMutableArray *bookmarksArray;

@end

@implementation ViewController

#pragma mark - Properties

- (NSMutableArray *)bookmarksArray {
    if (!_bookmarksArray) {
        _bookmarksArray = [[NSMutableArray alloc] init];
    }
    return _bookmarksArray;
}

#pragma mark - Actions
- (IBAction)backBarButtontapped:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)forwardBarButtontapped:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (IBAction)shareBarButtontapped:(UIBarButtonItem *)sender {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Check out this cool link!\n", self.urlTextField.text] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}
- (IBAction)bookmarksBarButtontapped:(UIBarButtonItem *)sender {
    
}

- (IBAction)addBarButtontapped:(UIBarButtonItem *)sender {
    Bookmark *bookmark = [[Bookmark alloc] init];
    bookmark.title = @"Title from text field...";
    bookmark.url = self.urlTextField.text;
    [self.bookmarksArray addObject:bookmark];
}

#pragma mark - Private API

/**
 Loads homepage into our web view. If homepage needs to be changed, please update HOMEPAGE constant.
 */
- (void)loadHomepage {
    [self openURL:HOMEPAGE];
}

/**
 Loads url into our web view.

 @param urlString The URL to open.
 */
- (void)openURL:(NSString *)urlString {
    NSString *httpString = [NSString stringWithFormat:@"http://%@", urlString];
    
    NSURL *url = [NSURL URLWithString:httpString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadHomepage];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Hide keyboard
    [textField resignFirstResponder];
    
    [self openURL:textField.text];
    
    return YES;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}





@end
