//
//  EYBannerAdAdapter.h
//  EyuLibrary-ios
//
//  Created by eric on 2020/11/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EYAdKey.h"
#import "EYAdGroup.h"
#include "EYAdConstants.h"

@protocol IBannerAdDelegate;
@interface EYBannerAdAdapter : NSObject

@property(nonatomic,weak)id<IBannerAdDelegate> delegate;
@property(nonatomic,strong)EYAdKey *adKey;
@property(nonatomic,strong)EYAdGroup *adGroup;
@property(nonatomic,assign)bool isLoading;
@property(nonatomic,assign)bool isShowing;

-(instancetype) initWithAdKey:(EYAdKey*)adKey adGroup:(EYAdGroup*) group;

-(void) loadAd;
-(bool) showAdWithController:(UIViewController*) controller;
-(bool) isAdLoaded;

-(void) notifyOnAdLoaded;
-(void) notifyOnAdLoadFailedWithError:(int)errorCode;
-(void) notifyOnAdShowed;
-(void) notifyOnAdClicked;
-(void) notifyOnAdRewarded;
-(void) notifyOnAdClosed;
-(void) notifyOnAdImpression;
@end

@protocol IBannerAdDelegate <NSObject>

@optional
-(void) onAdLoaded:(EYBannerAdAdapter *)adapter;
-(void) onAdLoadFailed:(EYBannerAdAdapter *)adapter withError:(int)errorCode;
-(void) onAdShowed:(EYBannerAdAdapter *)adapter;
-(void) onAdClicked:(EYBannerAdAdapter *)adapter;
-(void) onAdClosed:(EYBannerAdAdapter *)adapter;
-(void) onAdRewarded:(EYBannerAdAdapter *)adapter;
-(void) onAdImpression:(EYBannerAdAdapter *)adapter;
@end
