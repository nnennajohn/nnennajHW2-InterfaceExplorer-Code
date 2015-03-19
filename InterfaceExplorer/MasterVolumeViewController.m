//
//  MasterVolumeViewController.m
//  InterfaceExplorer
//
//  Created by Martin Nash on 1/21/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "MasterVolumeViewController.h"

@interface MasterVolumeViewController ()
@property (weak) IBOutlet NSTextField *volumeDisplayLabel;
@property (weak) IBOutlet NSSlider *volumeSlider;
@property (nonatomic, assign) NSUInteger volume;
@end

@implementation MasterVolumeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.volume = 2;
    [self updateInterface];
}

-(void)updateInterface
{
    self.volumeSlider.integerValue = self.volume;
    self.volumeDisplayLabel.stringValue = @(self.volume).stringValue;
}

- (IBAction)volumeSliderValueChanged:(id)sender
{
    self.volume = self.volumeSlider.integerValue;
    [self updateInterface];
    
}

@end
