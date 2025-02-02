//
//  EYBannerAdGroup.m
//  EyuLibrary-ios
//
//  Created by eric on 2020/11/7.
//

#import <Foundation/Foundation.h>
#import "EYBannerAdGroup.h"
#import "EYBannerAdAdapter.h"
#import "EYAdKey.h"
#import "EYEventUtils.h"
#import "EYAdManager.h"

@interface EYBannerAdGroup()<IBannerAdDelegate>

@property(nonatomic,strong)NSDictionary<NSString*, Class> *adapterClassDict;
@property(nonatomic,strong)NSMutableArray<EYBannerAdAdapter*> *adapterArray;
@property(nonatomic,copy)NSString *adPlaceId;
@property(nonatomic,assign)int  maxTryLoadAd;
//@property(nonatomic,assign)int tryLoadAdCounter;
//@property(nonatomic,assign)int curLoadingIndex;
@property(nonatomic,assign)bool reportEvent;

@end

@implementation EYBannerAdGroup
@synthesize adGroup = _adGroup;
@synthesize adapterArray = _adapterArray;
@synthesize adapterClassDict = _adapterClassDict;
@synthesize maxTryLoadAd = _maxTryLoadAd;
//@synthesize curLoadingIndex = _curLoadingIndex;
//@synthesize tryLoadAdCounter = _tryLoadAdCounter;
@synthesize reportEvent = _reportEvent;

- (EYBannerAdGroup *)initWithGroup:(EYAdGroup *)adGroup adConfig:(EYAdConfig *)adConfig {
    self = [super init];
    if (self) {
        self.adapterClassDict = [[NSDictionary alloc] initWithObjectsAndKeys:
#ifdef FB_ADS_ENABLED
            NSClassFromString(@"EYFBBannerAdapter"), ADNetworkFacebook,
#endif
                                 
#ifdef ADMOB_ADS_ENABLED
            NSClassFromString(@"EYAdmobBannerAdapter"), ADNetworkAdmob,
#endif
                                 
#ifdef ANYTHINK_ENABLED
            NSClassFromString(@"EYATBannerAdAdapter"), ADNetworkAnyThink,
#endif
#ifdef TRADPLUS_ENABLED
            NSClassFromString(@"EYTPBannerAdAdapter"), ADNetworkTradPlus,
#endif
        nil];
        self.adGroup = adGroup;
        self.adapterArray = [[NSMutableArray alloc] init];

//        self.curLoadingIndex = -1;
//        self.tryLoadAdCounter = 0;
        self.reportEvent = adConfig.reportEvent;
        NSMutableArray<EYAdKey*>* keyList = self.adGroup.keyArray;
        for(EYAdKey* adKey in keyList)
        {
            if(adKey){
                EYBannerAdAdapter *adapter = [self createAdAdapterWithKey:adKey adGroup:self.adGroup];
                if(adapter){
                    [self.adapterArray addObject:adapter];
                }
            }
        }
        self.maxTryLoadAd = 3;
    }
    return self;
}

-(void) loadAd:(NSString*)placeId 
{
    self.adPlaceId = placeId;
    if(self.adapterArray.count == 0) return;
    EYBannerAdAdapter* adapter = self.adapterArray[0];
    [adapter loadAd];
    if (self.adapterArray.count > 1 && self.adGroup.isAutoLoad) {
        [self.adapterArray[1] loadAd];
    }
//    self.curLoadingIndex = 0;
//    self.tryLoadAdCounter = 1;

}

- (bool)showAdGroup:(UIView *)viewGroup{
    NSLog(@"showBannerAd placeId = %@", self.adPlaceId);
    EYBannerAdAdapter* loadAdapter = [self getAvailableAdapter];
    if (loadAdapter) {
        [loadAdapter showAdGroup:viewGroup];
        return true;
    }
    return false;
}

-(EYBannerAdAdapter*) getAvailableAdapter
{
    EYBannerAdAdapter* loadAdapter = NULL;
    int index = 0;
    for (int i = 0; i < self.adapterArray.count; i++) {
        EYBannerAdAdapter* adapter = self.adapterArray[i];
        if([adapter isAdLoaded] && loadAdapter == NULL)
        {
            loadAdapter = adapter;
            index = i;
        } else {
            if (self.adGroup.isAutoLoad && !adapter.isAdLoaded && !adapter.isLoading) {
                [adapter loadAd];
            }
        }
    }
    if(loadAdapter != NULL)
    {
        [self.adapterArray removeObject:loadAdapter];
        EYAdKey* adKey = loadAdapter.adKey;
        EYBannerAdAdapter* newAdapter = [self createAdAdapterWithKey:adKey adGroup:self.adGroup];
        if(newAdapter && self.adGroup.isAutoLoad)
        {
            [newAdapter loadAd];
        }
        [self.adapterArray insertObject:newAdapter atIndex:index];
    }
    return loadAdapter;
}

-(EYBannerAdAdapter*) createAdAdapterWithKey:(EYAdKey*)adKey adGroup:(EYAdGroup*)group
{
    EYBannerAdAdapter* adapter = NULL;
    NSString* network = adKey.network;
    Class adapterClass = self.adapterClassDict[network];
    if(adapterClass!= NULL){
        adapter = [[adapterClass alloc] initWithAdKey:adKey adGroup:group];
    }
    if(adapter != NULL)
    {
        adapter.delegate = self;
    }
    return adapter;
}

-(bool) isCacheAvailable
{
    for(EYBannerAdAdapter* adapter in self.adapterArray)
    {
        if([adapter isAdLoaded])
        {
            return true;
        }
    }
    return false;
}

- (void)onAdLoaded:(EYBannerAdAdapter *)adapter {
//    if(self.curLoadingIndex>=0 && self.adapterArray[self.curLoadingIndex] == adapter)
//    {
//        self.curLoadingIndex = -1;
//    }
    if(self.delegate)
    {
        [self.delegate onAdLoaded:self.adPlaceId type:ADTypeBanner];
    }
//    if(self.reportEvent){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:adapter.adKey.keyId forKey:@"type"];
        [EYEventUtils logEvent:[self.adGroup.groupId stringByAppendingString:EVENT_LOAD_SUCCESS]  parameters:dic];
//    }
}

- (void)onAdLoadFailed:(EYBannerAdAdapter *)adapter withError:(int)errorCode {
    EYAdKey* adKey = adapter.adKey;
    NSLog(@"onAdLoadFailed adKey = %@, errorCode = %d", adKey.keyId, errorCode);
    
    if(self.reportEvent){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[[NSString alloc] initWithFormat:@"%d",errorCode] forKey:@"code"];
        [dic setObject:adKey.keyId forKey:@"type"];
        [EYEventUtils logEvent:[self.adGroup.groupId stringByAppendingString:EVENT_LOAD_FAILED]  parameters:dic];
    }
    if(adapter.tryLoadAdCount >= self.maxTryLoadAd){
        
    }else{
        adapter.tryLoadAdCount++;
        [adapter loadAd];
        if(self.reportEvent){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:adapter.adKey.keyId forKey:@"type"];
            [EYEventUtils logEvent:[self.adGroup.groupId stringByAppendingString:EVENT_LOADING]  parameters:dic];
        }
    }
    if(self.delegate)
    {
        [self.delegate onAdLoadFailed:self.adPlaceId key:adKey.keyId code:errorCode];
    }
}

- (void)onAdShowed:(EYBannerAdAdapter *)adapter {
    if(self.delegate)
    {
        [self.delegate onAdClicked:self.adPlaceId type:ADTypeBanner];
    }
    if(self.reportEvent){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:adapter.adKey.keyId forKey:@"type"];
        [EYEventUtils logEvent:[self.adGroup.groupId stringByAppendingString:EVENT_CLICKED]  parameters:dic];
    }
}

- (void)onAdClicked:(EYBannerAdAdapter *)adapter {
    if(self.delegate)
    {
        [self.delegate onAdClicked:self.adPlaceId type:ADTypeBanner];
    }
    if(self.reportEvent){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:adapter.adKey.keyId forKey:@"type"];
        [EYEventUtils logEvent:[self.adGroup.groupId stringByAppendingString:EVENT_CLICKED]  parameters:dic];
    }
}

- (void)onAdImpression:(EYBannerAdAdapter *)adapter {
    if(self.delegate)
    {
        [self.delegate onAdImpression:self.adPlaceId type:ADTypeBanner];
    }
    EYAdKey *adKey = adapter.adKey;
    if(adKey){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:adKey.network forKey:@"network"];
        [dic setObject:adKey.key forKey:@"unit"];
        [dic setObject:ADTypeBanner forKey:@"type"];
        [dic setObject:adKey.keyId forKey:@"keyId"];
        [EYEventUtils logEvent:EVENT_AD_IMPRESSION  parameters:dic];
    }
}
@end
