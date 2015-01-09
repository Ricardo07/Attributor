//
//  AttributorViewController.m
//  Attributor
//
//  Created by Ricardo Batista on 1/5/15.
//  Copyright (c) 2015 XdroneStudio. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlinedButton;
@end

@implementation AttributorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc] initWithString:self.outlinedButton.currentTitle];
    
    [title setAttributes:@{ NSStrokeWidthAttributeName : @3,
                            NSStrokeColorAttributeName : self.outlinedButton.tintColor}
                   range:NSMakeRange(0, [title length])];
    
    [self.outlinedButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)preferredFontsChanged:(NSNotification *)notification{
    [self usePreferredFonts];
}

- (void)usePreferredFonts{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)changeBodySelectionToMatchBackgroundOfButton:(UIButton *)sender {
    
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}



- (IBAction)outlineBodySelection:(id)sender {
   [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                                           NSStrokeColorAttributeName : [UIColor blackColor] }
                                  range:self.body.selectedRange];
}


- (IBAction)unoutlineBodySelection:(id)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}





@end
