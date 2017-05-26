//
//  ViewController.m
//  NLFloatingTextField
//
//  Created by Novus Logics on 26/05/17.
//  Copyright © 2017 Novus Logics. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 1) {
        NLFloatingField *textNL = (NLFloatingField *)textField;
        [textNL showErrorWithText:@"Enter Email Adresss"];
    }

    return YES;
}

@end
