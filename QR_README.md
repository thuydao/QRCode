# QRCode

================ SAMPLE =========================

#define LastiOS7 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) ?1 :0

UIViewController *vc;

if (LastiOS7) {
vc = AMScanViewController;
((AMScanViewController*)vc).delegate = (id)self;
}
else
{
vc = TPBQRCodeViewController;
((TPBQRCodeViewController*)vc).delegate = (id)self;
}

[self presentViewController:vc animated:YES completion:^{
[vc performSelector:@selector(startScanning)];
}];