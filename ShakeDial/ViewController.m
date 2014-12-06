//
//  ViewController.m
//  ShakeDial
//
//  Created by Hadaytullah on 21/03/14.
//  Copyright (c) 2014 Hadaytullah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)onTouchSelectContactButton:(id)sender{
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    //[self presentViewController:picker animated:YES];
    
    
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil] ;//]ViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    //[self displayPerson:person];
    //[self dismissModalViewControllerAnimated:YES];
    
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (void)displayPerson:(ABRecordRef)person
{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    self.contactLabel.text = name;
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    self.phoneNumber = [NSMutableString stringWithString:phone];//phone;
    CFRelease(phoneNumbers);
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}


-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motionEnded");
    if (motion== UIEventSubtypeMotionShake) {
        NSLog(@"Shake");
        if (self.phoneNumber) {
            NSLog(@"number exists");
            if (self.phoneNumber.length>0) {
                NSLog(@"number length is not zero.");
                [self callPhoneNumber:self.phoneNumber];
            }
            
        }
        
    }
    
}

-(BOOL)callPhoneNumber:(NSString*)number {
    NSLog(@"callPhoneNumber invoked");
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * urlNumber=[NSString stringWithFormat:@"tel:%@",number];
    NSLog(urlNumber);
    
    BOOL response =[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlNumber]];
    NSLog(@"%@",response?@"YES":@"NO");
    
    return response;
}

-(BOOL) canBecomeFirstResponder{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self becomeFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}
-(void) viewDidDisappear:(BOOL)animated{
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
