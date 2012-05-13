//
//  TBViewController.m
//  TinyBrowser
//
//  Created by Tatsuya Tobioka on 12/05/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TBViewController.h"

@interface TBViewController ()

@end

@implementation TBViewController
@synthesize webView;
@synthesize urlField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.toolbarHidden = NO;
    
    self.navigationItem.titleView = urlField;
    
    urlField.text = @"http://google.com/";
    [self textFieldShouldReturn:urlField];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setUrlField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [webView release];
    [urlField release];
    [super dealloc];
}

- (void)loadRequest:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *urlString = urlField.text;
    if (urlString.length > 0) {
        [self loadRequest:urlString];
    }
    [textField resignFirstResponder];
    return YES;
}

@end
