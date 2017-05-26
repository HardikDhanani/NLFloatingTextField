//
//  NLFloatingField.m
//  Holidaze
//
//  Created by Novus Logics on 26/05/17.
//  Copyright © 2017 Holidaze Logics. All rights reserved.
//

#import "NLFloatingField.h"

@implementation NLFloatingField

#pragma mark :- Drawing Methods
-(void)drawRect:(CGRect)rect {
    [self updateTextField:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(rect), CGRectGetHeight(rect))];
}

#pragma mark :- Loading From NIB
-(void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
}

#pragma mark :- Initialization Methods
-(instancetype)init {
    if (self) {
        self = [super init];
        [self initialization];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self initialization];
    }
    return self;
}

#pragma mark :- Drawing Text Rect
- (CGRect)textRectForBounds:(CGRect)bounds {
    if (_leftImage && _rightImage)
       return CGRectMake(30, 7, bounds.size.width - 60, bounds.size.height);
    else if (_leftImage)
       return CGRectMake(30, 7, bounds.size.width - 30, bounds.size.height);
    else if (_rightImage)
       return CGRectMake(0, 7, bounds.size.width - 30, bounds.size.height);
    
    return CGRectMake(0, 7, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (_leftImage && _rightImage)
        return CGRectMake(30, 7, bounds.size.width - 60, bounds.size.height);
    else if (_leftImage)
       return CGRectMake(30, 7, bounds.size.width - 30, bounds.size.height);
    else if (_rightImage)
        return CGRectMake(0, 7, bounds.size.width - 30, bounds.size.height);
    
    return CGRectMake(0, 7, bounds.size.width, bounds.size.height);
}

#pragma mark  Override Set text
-(void)setText:(NSString *)text {
    [super setText:text];
    if (text) {
        [self floatTheLabel];
    }
    if (showingError) {
        [self hideErrorPlaceHolder];
    }
}

#pragma mark  Set Placeholder Text On Label
-(void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if (![placeholder isEqualToString:@""]) {
        self.labelPlaceholder.text = placeholder;
    }
    
}

#pragma mark  Set Error Text On Label
-(void)setErrorText:(NSString *)errorText {
    _errorText = errorText;
    self.labelErrorPlaceholder.text = errorText;
}


-(void)initialization{
    
    self.clipsToBounds = true;
    if (!self.fixPosition)
        self.clipsToBounds = false;
    
    //VARIABLE INITIALIZATIONS
    
    //1. Placeholder Color.
    if (_placeHolderColor == nil){
        _placeHolderColor = [UIColor lightGrayColor];
    }
    
    //2. Placeholder Color When Selected.
    if (_selectedPlaceHolderColor==nil) {
        _selectedPlaceHolderColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
    }
    
    //3. Bottom line Color.
    if (_lineColor==nil) {
        _lineColor = [UIColor blackColor];
    }
    
    //4. Bottom line Color When Selected.
    if (_selectedLineColor==nil) {
        _selectedLineColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
    }
    
    //5. Bottom line error Color.
    if (_errorLineColor==nil) {
        _errorLineColor = [UIColor redColor];
    }
    
    //6. Bottom place Color When show error.
    if (_errorTextColor==nil) {
        _errorTextColor = [UIColor redColor];
    }
    
    /// Adding Bottom Line View.
    [self addBottomLineView];
    
    /// Adding Right & Left Padding View
    [self addRightAndLeftView];
    
    /// Adding Placeholder Label.
    [self addPlaceholderLabel];
    
    [self setValue:self.placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    /// Placeholder Label Configuration.
    if (![self.text isEqualToString:@""]) {
        [self floatTheLabel];
    }
    
}

#pragma mark :- Private Methods

-(void)addBottomLineView{
    
    [bottomLineView removeFromSuperview];
    bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 2)];
    bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    bottomLineView.backgroundColor = _lineColor;
    [self addSubview:bottomLineView];
}

-(void)addRightAndLeftView
{
    if (_rightImage)
        [self setRightImage:_rightImage withSize:CGSizeMake(25, CGRectGetHeight(self.frame))];
    
    if (_leftImage)
        [self setLeftImage:_leftImage withSize:CGSizeMake(25, CGRectGetHeight(self.frame))];
    
}

-(void)addPlaceholderLabel{
    
    [_labelPlaceholder removeFromSuperview];
    CGFloat X = 0;
    if (_leftImage)
        X = 30;
    
    if (![self.placeholder isEqualToString:@""]&&self.placeholder!=nil) {
        _labelPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(X, 0, self.frame.size.width-5, CGRectGetHeight(self.frame))];
        _labelPlaceholder.text = self.placeholder;
        _labelPlaceholder.hidden = YES;
        _labelPlaceholder.font = self.font;
    }else if (_placeholderText.length > 0) {
        _labelPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(X, 0, self.frame.size.width-5, 20)];
        _labelPlaceholder.text = _placeholderText;
        _labelPlaceholder.hidden = NO;
        _labelPlaceholder.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize - 3];;
    }
    
    NSString *placeHolderText = _labelPlaceholder.text;
    _labelPlaceholder.text = placeHolderText;
    _labelPlaceholder.textAlignment = self.textAlignment;
    _labelPlaceholder.textColor = _placeHolderColor;
    
    [self addSubview:_labelPlaceholder];
    
}

#pragma mark  Adding Error Label in textfield.

-(void)addErrorPlaceholderLabel{
    
    [self.labelErrorPlaceholder removeFromSuperview];
    
    self.labelErrorPlaceholder = [[UILabel alloc] init];
    self.labelErrorPlaceholder.text = self.errorText;
    self.labelErrorPlaceholder.textAlignment = self.textAlignment;
    self.labelErrorPlaceholder.textColor = self.errorTextColor;
    self.labelErrorPlaceholder.font = [UIFont fontWithName:self.font.fontName size:12];
    [self.labelErrorPlaceholder sizeToFit];
    self.labelErrorPlaceholder.hidden = YES;
    [self addSubview:self.labelErrorPlaceholder];
    
    CGRect frameError = self.labelErrorPlaceholder.frame;
    frameError.origin.x = CGRectGetMaxX(self.bounds) - CGRectGetWidth(self.labelErrorPlaceholder.frame);
    self.labelErrorPlaceholder.frame = frameError;
    
}

#pragma mark  Method to show Error Label.
-(void)showErrorPlaceHolder{
    
    CGRect bottmLineFrame = bottomLineView.frame;
    bottmLineFrame.origin.y = self.frame.size.height-2;
    
    if (self.errorText != nil && ![self.errorText isEqualToString:@""]) {
        
        [self addErrorPlaceholderLabel];
        self.labelErrorPlaceholder.hidden = NO;
        
        CGRect frame = self.labelErrorPlaceholder.frame;
        frame.origin.y -= (frame.size.height);
        self.labelErrorPlaceholder.frame = frame;
        
        [UIView animateWithDuration:0.2 animations:^{
            bottomLineView.frame  =  bottmLineFrame;
            bottomLineView.backgroundColor = _errorLineColor;
            CGRect labelFrame = self.labelErrorPlaceholder.frame;
            labelFrame.origin.y = 0;
            self.labelErrorPlaceholder.frame = labelFrame;
        }];
        
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            bottomLineView.frame  =  bottmLineFrame;
            bottomLineView.backgroundColor = _errorLineColor;
        }];
        
    }
    if (!self.disableShakeWithError) {
        [self shakeView:bottomLineView];
    }
}

#pragma mark  Method to Hide Error Label.
-(void)hideErrorPlaceHolder{
    showingError = NO;
    
    if (self.errorText == nil || [self.errorText isEqualToString:@""]) {
        return;
    }
    
    CGRect labelErrorFrame = _labelErrorPlaceholder.frame;
    labelErrorFrame.origin.y -= (labelErrorFrame.size.height);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.
        labelErrorPlaceholder.frame = labelErrorFrame;
    } completion:^(BOOL finished) {
        [self.labelErrorPlaceholder removeFromSuperview];
    }];
}

#pragma mark  Update and Manage Subviews
-(void)updateTextField:(CGRect )frame {
    
    self.frame = frame;
    [self initialization];
}

#pragma mark  Float UITextfield Placeholder Label.

-(void)floatPlaceHolder:(BOOL)selected {
    
    if (self.fixPosition)
    {
        self.labelPlaceholder.hidden = NO;
        CGRect bottmLineFrame = bottomLineView.frame;
        
        if (selected)
        {
            bottomLineView.backgroundColor = self.selectedLineColor;
            self.labelPlaceholder.textColor = self.selectedPlaceHolderColor;
            bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-2;
            [self setValue:self.selectedPlaceHolderColor forKeyPath:@"_placeholderLabel.textColor"];
        }else {
            
            bottomLineView.backgroundColor = self.lineColor;
            self.labelPlaceholder.textColor = self.placeHolderColor;
            bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-1;
            [self setValue:self.placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
        }
        
        if (self.disableFloatingLabel) {
            
            _labelPlaceholder.hidden = YES;
            [UIView animateWithDuration:0.2 animations:^{
                bottomLineView.frame  =  bottmLineFrame;
            }];
            
            return;
        }
        
        CGRect frame = self.labelPlaceholder.frame;
        frame.size.height = 12;
        
        [UIView animateWithDuration:0.2 animations:^{
            _labelPlaceholder.frame = frame;
            _labelPlaceholder.font = [UIFont fontWithName:self.font.fontName size:12];
            bottomLineView.frame  =  bottmLineFrame;
        }];
    }
    
}

-(void)resignPlaceholder {
    
    if (self.fixPosition)
    {
        [self setValue:self.placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
        
        bottomLineView.backgroundColor = self.lineColor;
        
        CGRect bottmLineFrame = bottomLineView.frame;
        bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-1;
        
        if (self.disableFloatingLabel) {
            
            self.labelPlaceholder.hidden = YES;
            self.labelPlaceholder.textColor = self.placeHolderColor;
            [UIView animateWithDuration:0.2 animations:^{
                bottomLineView.frame  =  bottmLineFrame;
            }];
            
            return;
        }
        
        CGRect frame = CGRectMake(0, 0, self.frame.size.width-5, self.frame.size.height);
        
        [UIView animateWithDuration:0.3 animations:^{
            _labelPlaceholder.frame = frame;
            _labelPlaceholder.font = self.font;
            _labelPlaceholder.textColor = _placeHolderColor;
            bottomLineView.frame  =  bottmLineFrame;
        } completion:^(BOOL finished) {
            self.labelPlaceholder.hidden = YES;
            self.placeholder = self.labelPlaceholder.text;
        }];
    }
}

#pragma mark  UITextField Begin Editing.

-(void)textFieldDidBeginEditing {
    if (self.fixPosition) {
        if (showingError) {
            [self hideErrorPlaceHolder];
        }
        if (!self.disableFloatingLabel) {
            self.placeholder = @"";
        }
        
        [self floatTheLabel];
        [self layoutSubviews];
    }
}

#pragma mark  UITextField End Editing.
-(void)textFieldDidEndEditing {
    if (self.fixPosition)
        [self floatTheLabel];
}

#pragma mark  Float & Resign

-(void)floatTheLabel {
    
    if ([self.text isEqualToString:@""] && self.isFirstResponder) {
        
        [self floatPlaceHolder:YES];
        
    }else if ([self.text isEqualToString:@""] && !self.isFirstResponder) {
        
        [self resignPlaceholder];
        
    }else if (![self.text isEqualToString:@""] && !self.isFirstResponder) {
        
        [self floatPlaceHolder:NO];
        
    }else if (![self.text isEqualToString:@""] && self.isFirstResponder) {
        
        [self floatPlaceHolder:YES];
    }
    
}
#pragma mark  Shake Animation
-(void)shakeView:(UIView*)view{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[@(-20.0), @20.0, @(-20.0), @20.0, @(-10.0), @10.0, @(-5.0), @(5.0), @(0.0) ];
    [view.layer addAnimation:animation forKey:@"shake"];
    
}
#pragma mark  Set Placeholder Text On Error Labels
-(void)showError {
    showingError = YES;
    [self showErrorPlaceHolder];
}
-(void)showErrorWithText:(NSString *)errorText {
    _errorText = errorText;
    showingError = YES;
    [self showErrorPlaceHolder];
}

#pragma mark  UITextField Responder Overide
-(BOOL)becomeFirstResponder {
    
    BOOL result = [super becomeFirstResponder];
    [self textFieldDidBeginEditing];
    return result;
}

-(BOOL)resignFirstResponder {
    
    BOOL result = [super resignFirstResponder];
    [self textFieldDidEndEditing];
    return result;
}

-(void)setLeftImage:(UIImage *)img withSize:(CGSize)sizeImg
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.masksToBounds = false;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeImg.width, sizeImg.height)];
    [paddingView addSubview:imgView];
    imgView.center = paddingView.center;
    
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void)setRightImage:(UIImage *)img withSize:(CGSize)sizeImg
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.masksToBounds = false;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeImg.width, sizeImg.height)];
    [paddingView addSubview:imgView];
    imgView.center = paddingView.center;
    
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
}

@end