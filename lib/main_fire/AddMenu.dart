import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tea_select/ad_helper.dart';
import 'package:tea_select/main_fire/TeaModel.dart';

class AddMenuPage extends StatefulWidget {

  final TeaProvider model;

  AddMenuPage(this.model);

  @override
  _AddMenuPageState createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  BannerAd _ad;
  bool isLoading;
  RewardedAd _rewardedAd;

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.largeBanner,
        listener: BannerAdListener(
          onAdLoaded: (_){
            setState(() {
              isLoading = true;
            });
          },
          onAdFailedToLoad: (_,error){
            print('Ad fireled to load with error: $error');
          },
        )
    );
    _ad.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (isLoading == true) {
      return Container(
        child: AdWidget(ad: _ad,),
        width: _ad.size.width.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeaProvider>.value(
      value: widget.model,

      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar:
            PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
                backgroundColor: Colors.white.withOpacity(0),
                foregroundColor: Colors.black,
                elevation: 0,
                title: Text('レシピ追加',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                centerTitle: true,
                actions: [
                  Consumer<TeaProvider>(builder: (context, model, child) {
                    return TextButton(
                      onPressed: () async {
                        model.startLoading();
                        model.add();
                        Navigator.pop(context);
                        model.imageFile = null;
                        model.endLoading();
                      },
                      child: Text(
                        '追加',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  )
                ],
              ),
            ),
            extendBodyBehindAppBar: true,
            body: Consumer<TeaProvider>(builder: (context, model, child,) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 100),
                            child: Text('・レシピのタイトル', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black12,
                            ),
                            height: 50,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            padding: EdgeInsets.all(5),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 50.0,
                              ),
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  child: SizedBox(
                                    height: 45,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '改行禁止　例：紅茶の〇〇'
                                      ),
                                      onChanged: (text) {
                                        model.newTeaTodo = text;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('・作り方', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black12,
                              ),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(5),
                              height: 200.0,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 200.0
                                ),
                                child: Scrollbar(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 190.0,
                                      child: TextField(
                                        maxLines: 100,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '１、〇〇〇'
                                        ),
                                        onChanged: (text) {
                                          model.newTeaText = text;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('・材料', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black12,
                              ),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(5),
                              height: 200.0,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 200.0
                                ),
                                child: Scrollbar(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 190.0,
                                      child: TextField(
                                        maxLines: 100,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '材料：〇〇〇〇',
                                        ),
                                        onChanged: (text) {
                                          model.newTeaItem = text;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text('・作成時間', style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          color: Colors.black12,
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        padding: EdgeInsets.all(5),
                                        height: 50.0,
                                        width: 50.0,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 50.0,
                                              maxWidth: 50.0
                                          ),
                                          child: SizedBox(
                                            height: 45,
                                            width: 45,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '15'
                                              ),
                                              onChanged: (text) {
                                                model.newTeaTime = text;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text('min')
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text('・ニックネーム', style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          color: Colors.black12,
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        padding: EdgeInsets.all(5),
                                        height: 50.0,
                                        width: 80.0,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 50.0,
                                              maxWidth: 80.0
                                          ),
                                          child: SizedBox(
                                            height: 45,
                                            width: 75,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '田中'
                                              ),
                                              onChanged: (text) {
                                                model.newUpername = text;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text('さん'),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('・画像の追加', style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: InkWell(
                                    onTap: () async {
                                      await model.showImagepicker();
                                    },
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.8,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.8 * 0.60,
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: model.imageFile != null
                                                ? FileImage(model.imageFile)
                                                :
                                            AssetImage('images/app image.jpg'),
                                            fit: BoxFit.cover
                                        ),


                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 100,
                      child: checkForAd()),
                ],
              );
            },
            ),
          ),
          Consumer<TeaProvider>(builder: (context, model, child,) {
            return
              model.isLoading ? Container(
                  color: Colors.grey.withOpacity(0.6),
                  child: Center(
                    child: CircularProgressIndicator(),
                  )
              ) : SizedBox();
          }),
        ],
      ),
    );
  }
}
