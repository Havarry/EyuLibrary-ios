# EyuLibrary-ios

[![CI Status](https://img.shields.io/travis/WeiqiangLuo/EyuLibrary-ios.svg?style=flat)](https://travis-ci.org/WeiqiangLuo/EyuLibrary-ios)
[![Version](https://img.shields.io/cocoapods/v/EyuLibrary-ios.svg?style=flat)](https://cocoapods.org/pods/EyuLibrary-ios)
[![License](https://img.shields.io/cocoapods/l/EyuLibrary-ios.svg?style=flat)](https://cocoapods.org/pods/EyuLibrary-ios)
[![Platform](https://img.shields.io/cocoapods/p/EyuLibrary-ios.svg?style=flat)](https://cocoapods.org/pods/EyuLibrary-ios)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EyuLibrary-ios is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:


## 本SDK所有第三方sdk均可以模块形式集成
```pod
模块：易娱 sdk          :'Core'
    穿山甲SDK          :'byte_dance_ads_sdk'    BYTE_DANCE_ADS_ENABLED
    广点通广告          :'gdt_ads_sdk'           GDT_ADS_ENABLED
    mtg广告            :'mtg_ads_sdk'           MTG_ADS_ENABLED
    FB广告             :'fb_ads_sdk'            FACEBOOK_ENABLED FB_ADS_ENABLED
    unity广告          :'unity_ads_sdk'         UNITY_ADS_ENABLED
    Vungle广告         :'vungle_ads_sdk'        VUNGLE_ADS_ENABLED
    applovin广告       :'applovin_ads_sdk'      APPLOVIN_ADS_ENABLED
    ironsource广告     :'iron_ads_sdk'          IRON_ADS_ENABLED
    firebase          :'firebase_sdk'          FIREBASE_ENABLED
    crashlytics       :'crashlytics_sdk'
    友盟               :'um_sdk'                UM_ENABLED
    AppsFlyer         :'af_sdk'                 AF_ENABLED
    广点通买量          :'gdt_action'             GDT_ACTION_ENABLED
    FB登录             :'fb_login_sdk'          FACEBOOK_ENABLED FACEBOOK_LOGIN_ENABLED 
    热云               :'ReYunTracking'         TRACKING_ENABLED
    ADMOB             :'admob_sdk'             ADMOB_ADS_ENABLED
    applovin MAX      :'applovin_max_sdk'      APPLOVIN_MAX_ENABLED
    AnyThink          :'anythink_sdk'          ANYTHINK_ENABLED
    AdmobMediation    :'admob_mediation_sdk'   ADMOB_MEDIATION_ENABLED ADMOB_ADS_ENABLED
    
    数数(Thinking)     :'thinking_sdk'          THINKING_ENABLED
    sigmob            :'sigmob_ads_sdk'
    TradPlus          :'tradplus_sdk'          TRADPLUS_ENABLED
    
注意：引入的模块的预编译宏在debug和release下均需添加
```

### 1、修改项目的Podfile文件，例如
```pod
pod 'EyuLibrary-ios',:subspecs => ['Core','byte_dance_ads_sdk','um_sdk', 'af_sdk', 'gdt_action','gdt_ads_sdk', 'mtg_ads_sdk', 'fb_ads_sdk', 'unity_ads_sdk', 'vungle_ads_sdk', 'applovin_ads_sdk', 'iron_ads_sdk', 'firebase_sdk', 'crashlytics_sdk','fb_login_sdk'], :git => 'https://github.com/EyugameQy/EyuLibrary-ios.git',:tag =>'1.3.66'
    （以上模块可以根据项目需要进行删减）
```
### 2、在终端里运行 pod install或者pod update，并留意执行是否有警告或者报错

### 3、执行成功后，用xcode打开当前项目目录下的$YOUR_PROJECT_NAME.xcworkspace文件

### 4、根据项目需要修改编译配置，及编写初始化代码
```sh
HEADER_SEARCH_PATHS 加上 $(inherited)
LIBRARY_SEARCH_PATHS 加上 $(inherited)
OTHER_LDFLAGS 加上 $(inherited)
```
### 5、穿山甲SDK 
```txt
在GCC_PREPROCESSOR_DEFINITIONS 加上 BYTE_DANCE_ADS_ENABLED
adConfig.wmAppKey = @"XXXXXX";//代码里设置穿山甲sdk app key
```

### 6、广点通广告
```txt
广点通广告 需要在GCC_PREPROCESSOR_DEFINITIONS 加上 GDT_ADS_ENABLED
adConfig.gdtAppId = @"xxxxxxxxxx";//代码里设置广点通广告sdk app id
```

### 7、mtg广告
```txt
mtg广告 需要在GCC_PREPROCESSOR_DEFINITIONS 加上 MTG_ADS_ENABLED
adConfig.mtgAppId = @"xxxxxx";//代码里设置mtg广告sdk app id 及app key
adConfig.mtgAppKey = @"xxxxxxxxxxxxxxxxx";
```

### 8、FB广告
FB广告 需要在GCC_PREPROCESSOR_DEFINITIONS 加上 FB_ADS_ENABLED 及FACEBOOK_ENABLED
请参考https://developers.facebook.com/docs/app-events/getting-started-app-events-ios
在app 对应的生命周期函数里加上
```oc
[EYSdkUtils initFacebookSdkWithApplication:application options:launchOptions];
[EYSdkUtils application:app openURL:url options:options];
```
在Info.plist文件里加上
```xml
    <key>FacebookAppID</key>
    <string>xxxxxx</string>
    <key>FacebookDisplayName</key>
    <string>xxxxxx</string>
```
### 9、unity广告
```txt
unity广告 需要在GCC_PREPROCESSOR_DEFINITIONS 加上 UNITY_ADS_ENABLED
adConfig.unityClientId = @"xxxxxxx";
```
### 10、Vungle广告
```txt
Vungle广告 需要在GCC_PREPROCESSOR_DEFINITIONS 加上 VUNGLE_ADS_ENABLED
adConfig.vungleClientId = @"xxxxxxxxxxx";
```

### 11、applovin广告
```txt
applovin广告 需要在GCC_PREPROCESSOR_DEFINITIONS 加上 APPLOVIN_ADS_ENABLED
AppLovin需要在info.plist里设置AppLovinSdkKey
```

### 12、ironsource广告
```txt
ironsource广告 需要在GCC_PREPROCESSOR_DEFINITIONS 加上 IRON_ADS_ENABLED
adConfig.ironSourceAppKey = @"xxxxxxxx";
```

### 13、firebase 及 crashlytics 以及ADMOB
#### firebase
```txt
参考资料：https://firebase.google.com/docs/ios/setup?authuser=0
从firebase下载 GoogleService-Info.plist 并放到xcode的根目录
在GCC_PREPROCESSOR_DEFINITIONS 加上 FIREBASE_ENABLED 
[EYSdkUtils initFirebaseSdk];
```

#### admob
```txt
admob可以通过"firebase_sdk"模块或者"admob_sdk"模块来引入，海外使用firebase_sdk，国内使用admob_sdk
在GCC_PREPROCESSOR_DEFINITIONS 加上 ADMOB_ADS_ENABLED
```
Info.plist 加上以下内容
```xml
<key>GADIsAdManagerApp</key>
<true/>
```
配置admob client id
```oc
adConfig.admobClientId = @"ca-app-pub-7585239226773233~4631740346";
```
### 14、友盟
```txt
需要在GCC_PREPROCESSOR_DEFINITIONS 加上 UM_ENABLED
[EYSdkUtils initUMMobSdk:@"XXXXXXXXXXXXXXXXXX" channel:@"channel"];
```
### 15、AppsFlyer
```txt
需要在GCC_PREPROCESSOR_DEFINITIONS 加上 AF_ENABLED
[EYSdkUtils initAppFlyer:@"XXXXXXXXXXXXXXXXX" appId:@"XXXXXXXXXXXXX"];
```

### 16、广点通买量
```txt
需要在GCC_PREPROCESSOR_DEFINITIONS 加上 GDT_ACTION_ENABLED
[EYSdkUtils initGDTActionSdk:@"XXXXXX" secretkey:@"XXXXXXXXX"];
并在- (void)applicationDidBecomeActive:(UIApplication *)application中调用[EYSdkUtils doGDTSDKActionStartApp];
```

### 17、FB登录
```txt
需要在GCC_PREPROCESSOR_DEFINITIONS 加上 FACEBOOK_LOGIN_ENABLED
```
### 18、热云
```txt
热云  需要在GCC_PREPROCESSOR_DEFINITIONS 加上 TRACKING_ENABLED
[EYSdkUtils initTrackingWithAppKey:appKey];
```
### 19、applovin MAX
```txt
max  需要在GCC_PREPROCESSOR_DEFINITIONS 加上 APPLOVIN_MAX_ENABLED
在info.plist里设置AppLovinSdkKey
```
### 20、AnyThink
```txt
AnyThink  需要在GCC_PREPROCESSOR_DEFINITIONS 加上 ANYTHINK_ENABLED
并集成需要用到的广告模块，比如用到了admob广告则需要额外添加"admob_sdk"模块，或者自己额外集成admob对应版本的的SDK
[EYSdkUtils initAnyThinkWithAppID:appid AppKey:appKey];
```

### 20、AdmobMediation
```txt
AdmobMediation  需要在GCC_PREPROCESSOR_DEFINITIONS 加上 ADMOB_MEDIATION_ENABLED ADMOB_ADS_ENABLED
配置并初始化admob 
如果有vungle广告需要配置 [EYAdManager sharedInstance].vunglePlacementIds = [placepentId1, placepentId2...];
```

### 21、Thinking
```txt
Thinking  需要在GCC_PREPROCESSOR_DEFINITIONS 加上 THINKING_ENABLED 

//默认使用云服务，服务器地址: https://receiver.ta.thinkingdata.cn 
[EYSdkUtils initThinkWithAppID:APP_ID]; 

//如果您使用的是私有化部署的版本请传入自己的url地址 
[EYSdkUtils initThinkWithAppID:APP_ID Url:SERVER_URL]; 

完成初始化后，您可以按以下方式来使用SDK: 
#import <ThinkingSDK/ThinkingAnalyticsSDK.h>
[[ThinkingAnalyticsSDK sharedInstanceWithAppid:APP_ID] track:@"event_name" properties:eventProperties]; 
更多功能请参考数数SDK文档: https://docs.thinkingdata.cn/ta-manual/latest/installation/installation_menu/client_sdk/ios_sdk_installation/ios_sdk_installation.html
```

### 22、TradPlus
```txt
TradPlus  需要在GCC_PREPROCESSOR_DEFINITIONS 加上 TRADPLUS_ENABLED 
Admob要求  Info.plist 添加 GADApplicationIdentifier
```

### 初始化FB， Firebase， UMMobSdk， AppFlyer， GDTActionSdk，及firebase 远程配置
```oc
[EYSdkUtils initFirebaseSdk];
[EYSdkUtils initUMMobSdk:@"XXXXXXXXXXXXXXXXXX" channel:@"channel"];
[EYSdkUtils initAppFlyer:@"XXXXXXXXXXXXXXXXX" appId:@"XXXXXXXXXXXXX"];
[EYSdkUtils initGDTActionSdk:@"XXXXXX" secretkey:@"XXXXXXXXX"];

firebase 配置和初始化
https://firebase.google.com/docs/ios/setup?authuser=0
下载 GoogleService-Info.plist 并放到xcode的根目录

firebase 远程配置初始化
NSDictionary* dict = [[NSDictionary alloc] init];
[[EYRemoteConfigHelper sharedInstance] setupWithDefault:dict];

//初始化广告sdk
EYAdConfig* adConfig = [[EYAdConfig alloc] init];
adConfig.adKeyData =  [EYSdkUtils readFileWithName:@"ios_ad_key_setting"];
adConfig.adGroupData = [EYSdkUtils readFileWithName:@"ios_ad_cache_setting"];
adConfig.adPlaceData = [EYSdkUtils readFileWithName:@"ios_ad_setting"];
adConfig.unityClientId = @"XXXXXX";
adConfig.vungleClientId = @"XXXXXXXXXXXXXXX";
adConfig.ironSourceAppKey = @"XXXXXXX";
adConfig.wmAppKey = @"XXXXXX";

//如果有banner广告需要设置根控制器
[[EYAdManager sharedInstance] setRootViewController:window.rootViewController];
//如果集成了AdmobMediation且配置了vungle广告
[EYAdManager sharedInstance].vunglePlacementIds = @[placepentId1, placepentId2...];

[[EYAdManager sharedInstance] setupWithConfig:adConfig];
[[EYAdManager sharedInstance] setDelegate:self];

//展示激励视频 reward_ad为广告位id，对应ios_ad_setting.json配置
[[EYAdManager sharedInstance] showRewardVideoAd:@"reward_ad" withViewController:self];

//展示插屏 inter_ad为广告位id，对应ios_ad_setting.json配置
[[EYAdManager sharedInstance] showInterstitialAd:@"inter_ad" withViewController:self];

//展示原生广告 native_ad为广告位id，对应ios_ad_setting.json配置
[[EYAdManager sharedInstance] showNativeAd:@"native_ad" withViewController:self viewGroup:self.nativeRootView];

//展示Banner广告 banner_ad为广告位id，对应ios_ad_setting.json配置
bool isSuccess = [[EYAdManager sharedInstance] showBannerAd:@"banner_ad" viewGroup:self.bannerRootView];

//广告回掉EYAdDelegate
-(void) onAdLoaded:(NSString*) adPlaceId type:(NSString*)type
{
NSLog(@"广告加载完成 onAdLoaded adPlaceId = %@, type = %@", adPlaceId, type);
}
-(void) onAdReward:(NSString*) adPlaceId  type:(NSString*)type
{
NSLog(@"激励视频观看完成 onAdReward adPlaceId = %@, type = %@", adPlaceId, type);

}
-(void) onAdShowed:(NSString*) adPlaceId  type:(NSString*)type
{
NSLog(@"广告展示 onAdShowed adPlaceId = %@, type = %@", adPlaceId, type);

}
-(void) onAdClosed:(NSString*) adPlaceId  type:(NSString*)type
{
NSLog(@"广告关闭 onAdClosed adPlaceId = %@, type = %@", adPlaceId, type);

}
-(void) onAdClicked:(NSString*) adPlaceId  type:(NSString*)type
{
NSLog(@"广告点击 onAdClicked adPlaceId = %@, type = %@", adPlaceId, type);

}

- (void)onAdLoadFailed:(nonnull NSString *)adPlaceId key:(nonnull NSString *)key code:(int)code 
{
    NSLog(@"广告加载失败 onAdLoadFailed adPlaceId = %@, key = %@, code = %d", adPlaceId, key, code);
}


- (void)onDefaultNativeAdClicked {
NSLog(@"默认原生广告点击 onDefaultNativeAdClicked");
}

-(void) onAdImpression:(NSString*) adPlaceId  type:(NSString*)type
{
NSLog(@"lwq, onAdImpression adPlaceId = %@, type = %@", adPlaceId, type);
}

事件上报
#import "EYEventUtils.h"
NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
[dic setObject:@"testValue" forKey:@"testKey"];
[EYEventUtils logEvent:@"EVENT_NAME"  parameters:dic];
```

### IOS 14适配
skadnetwork说明文档
https://developer.apple.com/documentation/storekit/skadnetwork

admob关于ios14的建议
https://support.google.com/admob/answer/9997589?hl=zh-Hans

1.在info.plist文件里添加跟踪权限请求描述说明
```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```

2.获取App Tracking Transparency权限  
```oc
#import <AppTrackingTransparency/AppTrackingTransparency.h>
//建议在请求权限后再请求广告（如果配置文件的isAutoLoad为true,setupWithConfig方法会自动加载广告）
if (@available(iOS 14, *)) {
    //iOS 14
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        //to do something，like preloading
        dispatch_async(dispatch_get_main_queue(), ^{
            [[EYAdManager sharedInstance] setupWithConfig:adConfig];
        }
    }];
} else {
    [[EYAdManager sharedInstance] setupWithConfig:adConfig];
}
```
注意：该权限只有Xcode 12及以上版本才有，需要更新Xcode 12版本来进行测试使用。

3.使用S​​KAdNetwork跟踪转化  
使用Apple的转化跟踪SKAdNetwork，这意味着即使IDFA不可用，广告平台也可以通过这个获取应用安装归因。请参阅Apple的SKAdNetwork文档，以了解更多信息。  
要启用此功能，您需要在info.plist中添加SKAdNetworkItems，下面例举几个常用的SDK平台需要添加的内容，其他请参考对应官方文档

 Google Admob
 ```xml
 <key>SKAdNetworkItems</key>
 <array>
     <dict>
       <key>SKAdNetworkIdentifier</key>
       <string>cstr6suwn9.skadnetwork</string>
     </dict>
 </array>
 ```
 
 穿山甲(Pangle)
 ``` xml
 <key>SKAdNetworkItems</key>
 <array>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>238da6jt44.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>22mmun2rn5.skadnetwork</string>
     </dict>
 </array>
 ```
 
 UnityAds
 ```xml
 <key>SKAdNetworkItems</key>
 <array>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>4DZT52R2T5.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>bvpn9ufa9b.skadnetwork</string>
     </dict>
 </array>
 ```
 
 Mintegral
 ```xml
 <key>SKAdNetworkItems</key>
 <array>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>KBD757YWX3.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>wg4vff78zm.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>737z793b9f.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>ydx93a7ass.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>prcb7njmu6.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>7UG5ZH24HU.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>44jx6755aq.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>2U9PT9HC89.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>W9Q455WK68.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>YCLNXRL5PM.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>TL55SBB4FM.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>8s468mfl3y.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>GLQZH8VGBY.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>c6k4g5qg8m.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>mlmmfzh3r3.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>4PFYVQ9L8R.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>av6w8kgt66.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>6xzpu9s2p8.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>hs6bdukanm.skadnetwork</string>
     </dict>
 </array>
 ```
 
 Facebook
 ```xml
 <key>SKAdNetworkItems</key>
 <array>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>v9wttpbfk9.skadnetwork</string>
     </dict>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>n38lu8286q.skadnetwork</string>
     </dict>
 </array>
 ```
 
 Sigmob
 ```xml
 <key>SKAdNetworkItems</key>
 <array>
     <dict>
         <key>SKAdNetworkIdentifier</key>
         <string>58922NB4GD.skadnetwork</string>
     </dict>
 </array>
 ```

MAX
```xml
<key>SKAdNetworkItems</key>
 <array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2u9pt9hc89.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4fzdc2evr5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7ug5zh24hu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9rd848q2bz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9t245vhmpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f38h382jlk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbd757ywx3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ludvb6z3bs.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m8dbw4sv7c.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mlmmfzh3r3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>tl55sbb4fm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wzmmz9fp6w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>yclnxrl5pm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ydx93a7ass.skadnetwork</string>
    </dict>
</array>
```

## 常见问题

```txt
1.为什么banner首次加载不出来？ 
答：可能是因为banner广告还没加载完成就调用了show方法，显示广告前请注意判断广告是否已经加载完成。

2.测试的时候max广告怎么显示不出来？ 
答：目前max广告建议VPN连美国的节点测试，请更换VPN节点后再试试。

3.SDK崩溃 reason: '-[EYAdConfig setXXXAppId:]: unrecognized selector sent to instance 
答：请注意按文档只设置使用到的广告模块的appid或者appkey，注意只添加使用到的模块对应的预编译宏。
```

## Author

WeiqiangLuo, weiqiangluo@qianyuan.tv

## License

EyuLibrary-ios is available under the MIT license. See the LICENSE file for more info.
