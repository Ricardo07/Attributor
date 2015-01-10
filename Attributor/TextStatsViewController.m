//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Ricardo Batista on 1/9/15.
//  Copyright (c) 2015 XdroneStudio. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)setTextToAnalize:(NSAttributedString *)textToAnalize{
    
    _textToAnalize = textToAnalize;
    if (self.view.window)//Only if I am on screen then I update my UI
        [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI{
    
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters",(unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters",(unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

//
-(NSAttributedString *)charactersWithAttribute:(NSString *)attributeName{
    
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    NSUInteger index = 0;
    while( index < [self.textToAnalize length]) {
        NSRange range;
        id value = [self.textToAnalize attribute:attributeName atIndex:index effectiveRange:&range];
        if(value){
            [characters appendAttributedString:[self.textToAnalize attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
    }
    
    return characters;
}



@end
