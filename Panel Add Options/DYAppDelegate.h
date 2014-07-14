//
//  DYAppDelegate.h
//  Open And Save Panels
//
//  Created by danny on 2014/7/9.
//  Copyright (c) 2014年 Danny. All rights reserved.
//  Website:http://cms.35g.tw/coding

#import <Cocoa/Cocoa.h>

@interface DYAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
- (IBAction)buttonSavePanelsAssociateCustomView:(id)sender;

@property (weak) IBOutlet NSTextField *textSavePanelsPath;
//
@property (assign) IBOutlet NSView     *accessoryView;
@property (assign) IBOutlet NSPopUpButton *popupButton;

@end
