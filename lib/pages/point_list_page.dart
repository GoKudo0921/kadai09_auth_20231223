// import 'dart:html';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kadai09_kudogo/main.dart';
import 'package:kadai09_kudogo/model/contents.dart';

class PointListPage extends StatefulWidget {
  const PointListPage({super.key});

  @override
  State<PointListPage> createState() => _PointListPageState();
}

class _PointListPageState extends State<PointListPage> {
  List<BannerAd> bannerAds = [];
  late InterstitialAd interstitialAd;
  int tapCount = 0;

  bool isLoaded = false;
  List<Contents> contentsList = [
    Contents(title: 'ポイント獲得', imagePath: 'assets/logo.png', point: 1),
    Contents(title: 'ポイントゲット', imagePath: 'assets/logo2.png', point: 2),
    Contents(title: 'お得です', imagePath: 'assets/logo3.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo4.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo2.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo3.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo4.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo2.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
  ];

  void initAd(){
    for(int i = 0; i < contentsList.length ~/ 4; i++){
      //   広告を作成
      BannerAd bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/6300978111'
              : 'ca-app-pub-3940256099942544/2934735716',
          listener: BannerAdListener(
              onAdLoaded: (Ad ad){
                setState(() {
                  isLoaded = true;
                });
              }
          ),
          request: const AdRequest())..load();
      bannerAds.add(bannerAd);
    }
    InterstitialAd.load(
        adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/8691691433'
            : 'ca-app-pub-3940256099942544/5135589807',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
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
      body: SingleChildScrollView(child: Column(
        children: [
          isMultiply ? Container(
            width: 300,
            height: 50,
            color: Colors.orange,
            alignment: Alignment.center,
            child: const Text('ポイント倍増中',style: TextStyle(fontSize: 20,color: Colors.white),),
          ) : Container(),
          buildList(),
        ],
      )),
    );
  }

  Widget buildList(){
    List<Widget> rowChildren = [];
    List<Widget> columnChildren = [];

    for(int i = 0; i < contentsList.length; i++){
     rowChildren.add(Expanded(
         child: InkWell(
           onTap: () async{
              setState(() {
                if(isMultiply == true){
                  totalPoint = totalPoint + contentsList[i].point * 2;
                }else {
                  totalPoint = totalPoint + contentsList[i].point;
                }
              });
              if(tapCount < 2){
                tapCount = tapCount + 1;
              }else{
                isMultiply = false;
                
                await interstitialAd.show();
                InterstitialAd.load(
                    adUnitId: defaultTargetPlatform == TargetPlatform.android ? 'ca-app-pub-3940256099942544/8691691433'
                        : 'ca-app-pub-3940256099942544/5135589807',
                    request: const AdRequest(),
                    adLoadCallback: InterstitialAdLoadCallback(
                      onAdLoaded: (InterstitialAd ad) {
                        // Keep a reference to the ad so you can show it later.
                        interstitialAd = ad;
                      },
                      onAdFailedToLoad: (LoadAdError error) {
                        print('InterstitialAd failed to load: $error');
                      },
                    ));
                tapCount = 0;
              }
           },
           child: Card(
            child: Column(
              children: [
                Image.asset(contentsList[i].imagePath),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(contentsList[i].title),
                      Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber
                        ),
                        child: Text('${contentsList[i].point}'),
                      )
                    ],
                  ),
                )
              ],
            ),
                ),
         )
     )
     );

     if(i % 2 == 1){
       columnChildren.add(Row(children: rowChildren,));
       rowChildren = [];
     }else if(i == contentsList.length - 1){ //最後のコンテンツのケース
      rowChildren.add(Expanded(child: Container()));
      columnChildren.add(Row(children: rowChildren,));
      rowChildren = [];
     }
     if(i % 4 == 3){
       columnChildren.add(Container(
         width: bannerAds[i ~/ 4].size.width.toDouble(),
         height: bannerAds[i ~/ 4].size.height.toDouble(),
         child: isLoaded ? AdWidget(ad: bannerAds[i ~/ 4])
             : Container(),
       ));
     }
    }

    return Column(
      children: columnChildren,
    );
  }
}
