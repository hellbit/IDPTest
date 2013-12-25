//
//  IDPViewController.m
//  IDPTest
//
//  Created by HeLLBiT on 11/7/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "IDPViewController.h"
#import "IDPTestModel.h"

@interface IDPViewController ()

@end

@implementation IDPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    IDPTestModel *model = [IDPTestModel new];
    [model load];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
