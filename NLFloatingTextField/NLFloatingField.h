//
//  NLFloatingField.h
//  Holidaze
//
//  Created by Novus Logics on 26/05/17.
//  Copyright © 2017 Holidaze Logics. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface NLFloatingField : UITextField
{
    UIView *bottomLineView;
    BOOL showingError;
}

// Change the Bottom line color. Default is Black Color.
@property (nonatomic,strong) IBInspectable UIColor *lineColor;

//Change the Placeholder text color. Default is Light Gray Color.
@property (nonatomic,strong) IBInspectable UIColor *placeHolderColor;

//Change the Placeholder text color when selected.
@property (nonatomic,strong) IBInspectable UIColor *selectedPlaceHolderColor;

//Change the bottom line color when selected.
@property (nonatomic,strong) IBInspectable UIColor *selectedLineColor;

//Change the error label text color. Default is Red Color.
@property (nonatomic,strong) IBInspectable UIColor *errorTextColor;

//Change the error line color. Default is Red Color.
@property (nonatomic,strong) IBInspectable UIColor *errorLineColor;

//Change the error display text.
@property (nonatomic,strong) IBInspectable  NSString  *errorText;

//Shake line when showing error?.
@property (nonatomic) IBInspectable  BOOL disableShakeWithError;

@property (nonatomic) IBInspectable  BOOL disableFloatingLabel;

//Disable to move a placeholder lable
@property (nonatomic) IBInspectable  BOOL fixPosition;

//Set Placeholder text.
@property (nonatomic,strong) IBInspectable  NSString  *placeholderText;

//Set Right Padding View
@property (nonatomic, strong) IBInspectable UIImage *rightImage;

//Set Left Padding View
@property (nonatomic, strong) IBInspectable UIImage *leftImage;

@property (nonatomic,strong) UILabel *labelPlaceholder;
@property (nonatomic,strong) UILabel *labelErrorPlaceholder;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)showError;
- (void)showErrorWithText:(NSString *)errorText;
- (void)updateTextField:(CGRect)frame;

@end
