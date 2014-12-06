//
//  ViewController.h
//  ShakeDial
//
//  Created by Hadaytullah on 21/03/14.
//  Copyright (c) 2014 Hadaytullah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBookUI/AddressBookUI.h"

@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic,retain) IBOutlet UILabel* contactLabel;
@property (nonatomic,retain) IBOutlet UIButton* selectContactButton;

@property (nonatomic,retain) NSMutableString* phoneNumber;

//@property appState* counter;
//@property BOOL isDragInside;
//@property JDFlipNumberView *flipNumberView;

//@property UISwipeGestureRecognizer *swipeGesture;
//@property UISwipeGestureRecognizer *swipeGesture2;
//@property NSString* contactFirstName;

-(IBAction) onTouchSelectContactButton:(id)sender;
//-(IBAction) buttonTouchUp:(id)sender;
//-(IBAction)resetTouchUp:(id)sender;
//-(void)updateCounterUI;
//-(void)setBackgroundImage;

@end
