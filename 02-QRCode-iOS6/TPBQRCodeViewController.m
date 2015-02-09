//
//  TPBQRCodeViewController.m
//  VPB
//
//  Created by BunLV on 10/21/14.
//  Copyright (c) 2014 BunLV. All rights reserved.
//

#import "TPBQRCodeViewController.h"
#import "ZBarSDK.h"

@interface TPBQRCodeViewController ()
{
    ZBarReaderView *reader;
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation TPBQRCodeViewController

#pragma mark - View lifecyl
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    // Need call super
    [super viewDidLoad];
    
    // Begin code here
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ( ![self isCameraAvailable] )
    {
        [self setupNoCameraView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - SVG
#pragma mark + Set
- (void)setViewInfo
{
    // Need call super
    
    // Begin code here
    if ( [self isCameraAvailable] )
    {
        [self setupScanner];
    }
}

- (void)setupScanner
{
    ZBarImageScanner *scanner = [ZBarImageScanner new];
    [scanner setSymbology:ZBAR_PARTIAL config:0 to:0];
    
    CGFloat x = 0.0, y = 0.0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    reader = [[ZBarReaderView alloc] initWithImageScanner:scanner];
    reader.frame = CGRectMake(x, y, w, h);
    reader.backgroundColor = [UIColor blackColor];
    reader.readerDelegate = (id )self;
    
    [self.view addSubview:reader];
    
    [self drawLabelMessage];
    
    [self loadBeepSound];
}

- (void)setupNoCameraView
{
    UILabel *labelNoCam = [[UILabel alloc] init];
    labelNoCam.text = @"No Camera available";
    labelNoCam.textColor = [UIColor blackColor];
    [self.view addSubview:labelNoCam];
    [labelNoCam sizeToFit];
    labelNoCam.center = self.view.center;
}

- (void)loadBeepSound
{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    
    if ( error )
    {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else
    {
        // If the audio player was successfully initialized then load it in memory.
        [self.audioPlayer prepareToPlay];
    }
}

#pragma mark + Get
- (void)getDataByLoadFromServer
{
}

- (BOOL)isCameraAvailable
{
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    return isCamera;
}

#pragma mark + Fake

#pragma mark + Add

#pragma mark + Remove

#pragma mark + Control Item

#pragma mark + Scan
- (void)startScanning
{
    [reader start];
}

- (void)stopScanning
{
    [reader stop];
}

- (void)playSound
{
    if ( self.audioPlayer )
    {
        [self.audioPlayer play];
    }
}

#pragma mark - Draw
- (void)drawLabelMessage
{
    CGFloat offSetX = 0.0;
    CGFloat w = self.view.frame.size.width - offSetX * 2, h = 50;
    self.lbMessage = [[UILabel alloc] init];
    [self.lbMessage setFrame:CGRectMake(offSetX, self.view.frame.size.height - h, w, h)];
    [self.lbMessage setBackgroundColor:[UIColor clearColor]];
    [self.lbMessage setTextAlignment:NSTextAlignmentCenter];
    [self.lbMessage setFont:[UIFont systemFontOfSize:13.0]];
    [self.lbMessage setTextColor:[UIColor blackColor]];
    [self.lbMessage setText:@""];
    [self.view addSubview:self.lbMessage];
}

#pragma mark - Call API

#pragma mark - Action

#pragma mark - Delegate
#pragma mark + ZBarReaderView
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
    {
        if ( self.delegate )
        {
            if ( [self.delegate respondsToSelector:@selector(qrCodeViewController:didSuccessfullyScan:)] )
            {
                NSString *aScannedValue = s.data;
                
                [self.delegate qrCodeViewController:self didSuccessfullyScan:aScannedValue];
            }
        }
    }
}

#pragma mark - Subclass need overwrite

#pragma mark - Overwrite

@end
