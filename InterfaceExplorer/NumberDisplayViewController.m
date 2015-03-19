//
//  NumberDisplayViewController.m
//  InterfaceExplorer
//
//  Created by Martin Nash on 1/21/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "NumberDisplayViewController.h"

@interface NumberDisplayViewController ()
@property (weak) IBOutlet NSTextField *numberInputField;
@property (weak) IBOutlet NSTextField *resultOutputLabel;
@property (weak) IBOutlet NSMatrix *formatterStyleChooser;
@property (weak) IBOutlet NSButton *actionButton;
@property (strong, nonatomic) NSNumberFormatter *theNumberFormatter;
@end

@implementation NumberDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.theNumberFormatter = [NSNumberFormatter new];

    NSArray *formatStyles = [self.class numberFormatterStyles];

    // clear all cells out of matrix
    while ([self.formatterStyleChooser numberOfRows] > 0) {
        [self.formatterStyleChooser removeRow:0];
    }
    
    // add new cells to matrix
    for (NSNumber *formatNumber in formatStyles) {
        NSNumberFormatterStyle style = formatNumber.unsignedIntegerValue;

        NSButtonCell *cell = [[NSButtonCell alloc] init];
        [cell setButtonType:NSRadioButton];
        cell.title = [self stringForStyle:style];
    
        [self.formatterStyleChooser addRowWithCells:@[ cell ]];
    }

    
    // setup number formatter and select cell for its style
    self.theNumberFormatter.numberStyle = [self styleForRow:0];
    [self.formatterStyleChooser selectCellAtRow:0 column:0];
    self.numberInputField.stringValue = @"";
}

-(NSNumber*)currentNumberFromInput
{
    return @(self.numberInputField.integerValue);
}

- (IBAction)clickedFormatButton:(id)sender
{
    [self updateInterfaceWithNumber:[self currentNumberFromInput]];
}

- (IBAction)toggledRadioButtons:(id)sender
{
    NSUInteger selectedRow = self.formatterStyleChooser.selectedRow;
    NSNumberFormatterStyle style = [self styleForRow:selectedRow];
    
    NSNumber *savedNumber = [self.theNumberFormatter numberFromString:self.resultOutputLabel.stringValue];
    self.theNumberFormatter.numberStyle = style;
    
    [self updateInterfaceWithNumber:savedNumber];
}

-(void)updateInterfaceWithNumber:(NSNumber*)number
{
    if (number == nil) {
        return;
    }
    
    NSString *formattedString = [self.theNumberFormatter stringFromNumber:number];
    self.resultOutputLabel.stringValue = formattedString;
}

- (IBAction)textFieldSaved:(id)sender
{
    NSLog(@"Thousands separator: \"%@\"", self.theNumberFormatter.thousandSeparator);
}



#pragma mark - Helpers

+(NSArray*)numberFormatterStyles
{
    return @[
         @(NSNumberFormatterNoStyle),
         @(NSNumberFormatterDecimalStyle),
         @(NSNumberFormatterCurrencyStyle),
         @(NSNumberFormatterPercentStyle),
         @(NSNumberFormatterScientificStyle),
         @(NSNumberFormatterSpellOutStyle)
     ];
}

-(NSString*)stringForStyle:(NSNumberFormatterStyle)style
{
    switch (style) {

        case NSNumberFormatterNoStyle:
            return @"No Style";
            
        case NSNumberFormatterDecimalStyle:
            return @"Decimal";

        case NSNumberFormatterCurrencyStyle:
            return @"Currency";
            
        case NSNumberFormatterPercentStyle:
            return @"Percent";
            
        case NSNumberFormatterScientificStyle:
            return @"Scientific";
            
        case NSNumberFormatterSpellOutStyle:
            return @"Spell out";
            
        default:
            return @"";

    }
    
}

-(NSNumberFormatterStyle)styleForRow:(NSUInteger)row
{
    return [[[self.class numberFormatterStyles] objectAtIndex:row] unsignedIntegerValue];
}


@end
