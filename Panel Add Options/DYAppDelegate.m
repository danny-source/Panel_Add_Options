//
//  DYAppDelegate.m
//  Open And Save Panels
//
//  Created by danny on 2014/7/9.
//  Copyright (c) 2014年 Danny. All rights reserved.
//  Website:http://cms.35g.tw/coding

#import "DYAppDelegate.h"

@implementation DYAppDelegate
{
    NSSavePanel *_savePanel;
}


- (void)awakeFromNib
{

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}


- (IBAction)buttonSavePanelsAssociateCustomView:(id)sender
{
    NSSavePanel*    panel = [NSSavePanel savePanel];
    _savePanel = panel;
    //屬性設置
    [panel setCanHide:YES];//能否看見隱藏檔
    [panel setMessage:@"Message-ADD"];//功能說明
    [panel setTitle:@"Title-Add"];//標題
    
    [panel setExtensionHidden:NO];
    [panel setPrompt:@"OK"];//變更原本Save按鍵的名稱
    [panel setNameFieldStringValue:@"test"];
    [panel setAllowedFileTypes:@[@"png",@"jpg"]];//限定檔案類型
    [panel setAllowsOtherFileTypes:NO];

    NSNib *accessoryNib = [[NSNib alloc] initWithNibNamed:@"PanelExtra" bundle:nil];//讀取Layout nib
    NSArray *arrayOfViews;
    [accessoryNib instantiateWithOwner:self topLevelObjects:&arrayOfViews];//取得nib檔上的所有的view到陣例
    
    NSUInteger viewIndex = [arrayOfViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isKindOfClass:[NSView class]];//取得nib內容上的view，因在Layout上只有一個view
    }];

    
    self.accessoryView = [arrayOfViews objectAtIndex:viewIndex];//取得view中的所有元件
    
    NSUInteger poputButtonIndex = [self.accessoryView.subviews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isKindOfClass:[NSPopUpButton class]];//取得view中為NSPopUpButton元件(layout上只有1個，所以直接找到後回傳物件位址)
    }];
    
    
    self.popupButton = [self.accessoryView.subviews objectAtIndex:poputButtonIndex];
    //設定NSPopUpButton的事項
    self.popupButton.target = self;
    self.popupButton.action = @selector(fileTypeChanged:);//選擇改變後執行fileTypeChanged
    [self.popupButton removeAllItems];
    [self.popupButton addItemsWithTitles:@[@"*.png",@"*.jpg"]];//指定PopUpButton 項目
    
    [panel setAccessoryView:self.accessoryView];//將取得的view指定至Panel，它會在顯示區域將View顯示
    
    
    [panel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL*  theFile = [panel URL];
            _textSavePanelsPath.stringValue = [theFile relativeString];
            
        }
    }];
}

- (void)fileTypeChanged:(id)sender
{
    //選項變更後進行副檔的處理，選擇副檔後將原本的副檔名取代
    NSString *nameWithoutExtension = [[_savePanel nameFieldStringValue] stringByDeletingPathExtension];
    switch ([self.popupButton indexOfSelectedItem]) {
        case 0:
        {
            _savePanel.allowedFileTypes = @[@"png"];
            
            [_savePanel setNameFieldStringValue:[nameWithoutExtension stringByAppendingPathExtension:@"png"]];
            NSLog(@"0");
            
            break;
        }
        case 1:
        {
            _savePanel.allowedFileTypes = @[@"jpg"];
            [_savePanel setNameFieldStringValue:[nameWithoutExtension stringByAppendingPathExtension:@"jpg"]];
            NSLog(@"1");
            break;
        }
    }
    

}

@end
