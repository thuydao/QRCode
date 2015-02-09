//
//  TPBQRCodeViewController.h
//  VPB
//
//  Created by BunLV on 10/21/14.
//  Copyright (c) 2014 BunLV. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@protocol TPBQRCodeViewControllerDelegate;

@interface TPBQRCodeViewController : BaseViewController
{

}

@property (strong, nonatomic) UILabel *lbMessage;

@property (weak, nonatomic) id<TPBQRCodeViewControllerDelegate> delegate;

#pragma mark - View lifecyl

#pragma mark - SVG
#pragma mark + Set
- (void)setViewInfo;

#pragma mark + Get
- (void)getDataByLoadFromServer;

#pragma mark + Fake

#pragma mark + Add

#pragma mark + Remove

#pragma mark + Control Item
- (void)controlItem;

#pragma mark + Scan
- (void)startScanning;
- (void)stopScanning;
- (void)playSound;

#pragma mark - Draw

#pragma mark - Call API

#pragma mark - Action

#pragma mark - Delegate

#pragma mark - Subclass need overwrite

#pragma mark - Overwrite

@end

@protocol TPBQRCodeViewControllerDelegate <NSObject>

- (void)qrCodeViewController:(TPBQRCodeViewController *)viewController didSuccessfullyScan:(NSString *)aScannedValue;

@end
