import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kadai09_kudogo/main.dart';

class WatchVideoPage extends StatefulWidget {
  const WatchVideoPage({super.key});

  @override
  State<WatchVideoPage> createState() => _WatchVideoPageState();
}

class _WatchVideoPageState extends State<WatchVideoPage> {
  late RewardedAd rewardedAd;
  late RewardedAd rewardMultiply;
  bool isLoaded = false;

  void initAd(){

    // ５ポイント獲得用の広告用意
    RewardedAd.load(
      adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdShowedFullScreenContent.');
            },
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('$ad failed to show full screen content with error $error.');
              ad.dispose();
            },
          );
          rewardedAd = ad;
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );


    // 獲得ポイントが2倍に！用の広告を用意
    RewardedAd.load(
      adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdShowedFullScreenContent.');
            },
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('$ad failed to show full screen content with error $error.');
              ad.dispose();
            },
          );
          rewardMultiply = ad;
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ポイ活アプリ'),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            child: Text('$totalPoint',
            style: const TextStyle(
              fontSize: 20
            ),),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('５ポイント獲得',
            style: TextStyle(
              fontSize: 20
            ),),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () async{
                    if(isLoaded == true){
                      await rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
                        totalPoint = totalPoint + 5;
                      });

                      // ５ポイント獲得用の広告用意
                      RewardedAd.load(
                        adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/5224354917'
                            : 'ca-app-pub-3940256099942544/1712485313',
                        request: const AdRequest(),
                        rewardedAdLoadCallback: RewardedAdLoadCallback(
                          onAdLoaded: (RewardedAd ad) {
                            ad.fullScreenContentCallback = FullScreenContentCallback(
                              onAdShowedFullScreenContent: (RewardedAd ad) {
                                print('$ad onAdShowedFullScreenContent.');
                              },
                              onAdDismissedFullScreenContent: (RewardedAd ad) {
                                print('$ad onAdDismissedFullScreenContent.');
                                ad.dispose();
                              },
                              onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
                                print('$ad failed to show full screen content with error $error.');
                                ad.dispose();
                              },
                            );
                            rewardedAd = ad;
                            setState(() {
                              isLoaded = true;
                            });
                          },
                          onAdFailedToLoad: (LoadAdError error) {
                            print('RewardedAd failed to load: $error');
                          },
                        ),
                      );



                    }
              }, child: const Text('動画を視聴',
                  style: TextStyle(
                      fontSize: 20
                  ))),
            ),
            const Padding(padding: EdgeInsets.all(50)),
            const Text('獲得ポイントを2倍に！',
                style: TextStyle(
                    fontSize: 20
                )),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () async{
                if(isLoaded == true){
                  await rewardMultiply.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
                    isMultiply = true;
                  });

                  // 獲得ポイントが2倍に！用の広告を用意
                  RewardedAd.load(
                    adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/5224354917'
                        : 'ca-app-pub-3940256099942544/1712485313',
                    request: const AdRequest(),
                    rewardedAdLoadCallback: RewardedAdLoadCallback(
                      onAdLoaded: (RewardedAd ad) {
                        ad.fullScreenContentCallback = FullScreenContentCallback(
                          onAdShowedFullScreenContent: (RewardedAd ad) {
                            print('$ad onAdShowedFullScreenContent.');
                          },
                          onAdDismissedFullScreenContent: (RewardedAd ad) {
                            print('$ad onAdDismissedFullScreenContent.');
                            ad.dispose();
                          },
                          onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
                            print('$ad failed to show full screen content with error $error.');
                            ad.dispose();
                          },
                        );
                        rewardMultiply = ad;
                        setState(() {
                          isLoaded = true;
                        });
                      },
                      onAdFailedToLoad: (LoadAdError error) {
                        print('RewardedAd failed to load: $error');
                      },
                    ),
                  );



                }
              }, child: const Text('動画を視聴',
                  style: TextStyle(
                      fontSize: 20
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}



// RewardedAd.load(
//     adUnitId:  defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/5224354917'
//         : 'ca-app-pub-3940256099942544/1712485313',
//     request: const AdRequest(),
//     rewardedAdLoadCallback: RewardedAdLoadCallback(
//       onAdLoaded: (RewardedAd ad) {
//         // Keep a reference to the ad so you can show it later.
//         rewardedAd = ad;
//       },
//       onAdFailedToLoad: (LoadAdError error) {
//         print('InterstitialAd failed to load: $error');
//       },
//     ));
//

// rewardedAd = RewardedAd(
//   adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/5224354917'
//     : 'ca-app-pub-3940256099942544/1712485313',
//   request: AdRequest(),
//   listener: AdListener(
//     onAdLoaded:(Ad ad) {
//       setState(() {
//         isLoaded = true;
//       });
//     },
//     onRewardedAdUserEarnedReward:(ad,item){
//       setState(() {
//         totalPoint = totalPoint + 5;
//       });
//     }
//   ),
// )..load();