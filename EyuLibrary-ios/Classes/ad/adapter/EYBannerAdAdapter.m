//
//  EYBannerAdAdapter.m
//  EyuLibrary-ios
//
//  Created by eric on 2020/11/7.
//

#import "EYBannerAdAdapter.h"

@implementation EYBannerAdAdapter
@synthesize delegate = _delegate;
@synthesize adKey = _adKey;
@synthesize adGroup = _adGroup;
@synthesize isLoading = _isLoading;

-(instancetype) initWithAdKey:(EYAdKey*)adKey adGroup:(EYAdGroup*) group
{
    self = [super init];
    if(self)
    {
        self.adKey = adKey;
        self.adGroup = group;
        self.isLoading = false;
    }
    return self;
}

-(void) loadAd:(UIViewController *)controller
{
    NSAssert(true, @"子类中实现");
}

-(bool) isAdLoaded
{
    NSAssert(true, @"子类中实现");
    return false;
}

- (bool)showAdGroup:(UIView *)viewGroup {
    NSAssert(true, @"子类中实现");
    return false;
}

- (UIView *)getBannerView {
    NSAssert(true, @"子类中实现");
    return NULL;
}

-(void) notifyOnAdLoaded
{
    self.isLoading = false;
    if(self.delegate!=NULL)
    {
        [self.delegate onAdLoaded:self];
    }
}

-(void) notifyOnAdLoadFailedWithError:(int)errorCode;
{
    self.isLoading = false;
    if(self.delegate!=NULL)
    {
        [self.delegate onAdLoadFailed:self withError:errorCode];
    }
}

-(void) notifyOnAdShowed
{
    if(self.delegate!=NULL)
    {
        [self.delegate onAdShowed:self];
    }
}

-(void) notifyOnAdClicked
{
    if(self.delegate!=NULL)
    {
        [self.delegate onAdClicked:self];
    }
}

-(void) notifyOnAdRewarded
{
    if(self.delegate!=NULL)
    {
        [self.delegate onAdRewarded:self];
    }
}

-(void) notifyOnAdClosed
{
    self.isLoading = false;
    if(self.delegate!=NULL)
    {
        [self.delegate onAdClosed:self];
    }
}

-(void) notifyOnAdImpression
{
    if(self.delegate!=NULL)
    {
        [self.delegate onAdImpression:self];
    }
}

- (void)dealloc
{
    self.delegate = NULL;
    self.adKey = NULL;
    self.adGroup = NULL;
}
@end
