//
//  EYFBBannerAdapter.m
//  EyuLibrary-ios
//
//  Created by eric on 2020/11/9.
//

#ifdef FB_ADS_ENABLED
#include "EYFBBannerAdapter.h"

@implementation EYFBBannerAdapter
@synthesize bannerView = _bannerView;
bool _adLoaded = false;

-(void) loadAd:(UIViewController *)controller {
    NSLog(@"lwq, fb bannerAd");
    if([self isAdLoaded])
    {
        [self notifyOnAdLoaded];
        return;
    }
    if (self.bannerView == NULL) {
        self.bannerView = [[FBAdView alloc] initWithPlacementID:self.adKey.key adSize:kFBAdSizeHeight50Banner rootViewController:controller];
        self.bannerView.delegate = self;
        [self.bannerView loadAd];
    }
}

- (bool)showAdGroup:(UIView *)viewGroup {
    if (self.bannerView == NULL) {
        return false;
    }
    [self.bannerView removeFromSuperview];
    CGRect bounds = CGRectMake(0,0, self.bannerView.frame.size.width, self.bannerView.frame.size.height);
    NSLog(@"lwq, bannerAdView witdh = %f, height = %f ", bounds.size.width, bounds.size.height);
    self.bannerView.frame = bounds;
    [viewGroup addSubview:self.bannerView];
    return true;
}

- (UIView *)getBannerView {
    return  self.bannerView;
}

-(bool) isAdLoaded
{
    return _adLoaded;
}

- (void)adViewDidLoad:(FBAdView *)adView {
    NSLog(@"lwq fbbanner ad didLoad");
    self.isLoading = false;
    _adLoaded = true;
    [self notifyOnAdLoaded];
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error {
    NSLog(@"lwq,fb banner ad failed to load with error: %@", error);
    self.isLoading = false;
    _adLoaded = false;
    [self notifyOnAdLoadFailedWithError:(int)error.code];
}

- (void)adViewWillLogImpression:(FBAdView *)adView {
    NSLog(@"lwq fbbanner ad willLogImpression");
    [self notifyOnAdShowed];
    [self notifyOnAdImpression];
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView {
    NSLog(@"lwq,fb bannerad didFinishHandlingClick");
}

- (void)adViewDidClick:(FBAdView *)adView {
    NSLog(@"lwq,fb bannerad didClick");
    [self notifyOnAdClicked];
}
@end
#endif /*FB_ADS_ENABLED*/
