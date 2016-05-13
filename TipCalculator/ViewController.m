//
//  ViewController.m
//  TipCalculator
//
//  Created by Anton Moiseev on 2016-05-13.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;

@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;

@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;

@property (weak, nonatomic) IBOutlet UILabel *message;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOne;

@property (nonatomic) CGFloat bottomConstraintConstant;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpTextFields];
    
    self.billAmountTextField.delegate = self;
    self.tipPercentageTextField.delegate = self;
    
    self.bottomConstraintConstant = self.bottomConstraintOne.constant;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calculateTip:(id)sender {
    
    [self.tipAmountLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.message setAdjustsFontSizeToFitWidth:YES];
    
    [self.message setTextAlignment:NSTextAlignmentCenter];
    
    float billAmount = [self.billAmountTextField.text floatValue];
    
    float tipAmount;
    
    float tipPercentage;
    
    if ([self.tipPercentageTextField.text length] == 0) {
        
        tipPercentage = 0.15;
        
        tipAmount = billAmount * tipPercentage;
        
        self.message.text = @"You didn't specify tip percentage, so it's 15% by default!";
        
    } else {
        
        tipPercentage = [self.tipPercentageTextField.text floatValue]/100;
        
        tipAmount = billAmount * tipPercentage;
        
        self.message.text = [NSString stringWithFormat:@"Tip percentage you spedified is about %.1f%%", tipPercentage * 100];
        
    }
    
    self.tipAmountLabel.text = [[NSString alloc] initWithFormat:@"Your tip amount is $%.2f", tipAmount];
    
    
}

// setting up the billAmountTextField

- (void)setUpTextFields {
    
    self.billAmountTextField.placeholder = @"Enter your bill amount!";
    self.billAmountTextField.textColor = [UIColor lightGrayColor];
    [self.billAmountTextField setTextAlignment:NSTextAlignmentCenter];
    
    self.tipPercentageTextField.placeholder = @"Enter tip percentage!";
    self.tipPercentageTextField.textColor = [UIColor lightGrayColor];
    [self.tipPercentageTextField setTextAlignment:NSTextAlignmentCenter];
}

// methods that are called when notifications are received by the view controller

- (void)keyboardShow:(NSNotification *)notification {
    
    NSValue *value = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect rect = [value CGRectValue];
    CGFloat keyboardHeight = rect.size.height;
    self.bottomConstraintOne.constant = keyboardHeight + self.bottomConstraintConstant;
    
}

- (void)keyboardHide:(NSNotification *) notification {
    
    self.bottomConstraintOne.constant = self.bottomConstraintConstant;
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
