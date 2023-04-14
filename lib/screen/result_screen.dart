import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:social_share/social_share.dart';
import 'package:wollu/screen/allstat_screen.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:wollu/util/db_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wollu/util/shareManager.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../entity/User.dart';
import 'finish_screen.dart';

class ResultScreen extends StatefulWidget {
  User currentUser;
  ResultScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class CategoryData {
  String name;
  String image;
  int color;
  int time;

  CategoryData(
      this.name,
      this.image,
      this.color,
      this.time
      );
}

class _ResultScreenState extends State<ResultScreen> {
  ShareManager share = ShareManager();
  DBHelper helper = DBHelper();
  int total = 1;
  int barRate = 0;
  List<CategoryData> categories = [
    CategoryData('없무 없음', 'assets/nothing.svg', 0xFF58D2DA, 0),
    CategoryData('커피/간식 먹기', 'assets/coffee.svg', 0xFF0017B3, 0),
    CategoryData('화장실 가기', 'assets/toilet.svg', 0xFF9CDC15, 0),
    CategoryData('바깥바람쐬기', 'assets/wind.svg', 0xFFF3BC1F, 0),
    CategoryData('인터넷 서핑하기', 'assets/internet.svg', 0xFFEE9492, 0),
    CategoryData('담배 피우기', 'assets/smoke.svg', 0xFF935DDD, 0),
    CategoryData('딴짓하기', 'assets/dosomething.svg', 0xFF00D19F, 0),
    CategoryData('이직준비', 'assets/prepare.svg', 0xFFD228D3, 0)
  ];
  List<Color> colorList = [
    Color(0xFFDCDCDC)
  ];
  List<int> wollu = [];
  List<int> indexList = [];
  var isLoading = false;
  var max = 0;
  int daypay = 0;
  Map<String, double> dataMap = {'dump': 0};
  var errorMsg = '';
  var sortedByValueMap = {};

  String transform(String s) {
    var newStr = '';
    for (int i=0;i<s.length;i++) {
      if ((s.length-i)%3==0 && i != 0) {
        newStr += ',';
      }
      newStr += s[i];
    }
    return newStr;
  }
  String imageBackgroundPath = "";



  Future<void> copyBundleAssets() async {
    imageBackgroundPath = await copyImage('testRes.png');
  }

  Future<String> copyImage(String filename) async {
    final tempDir = await getTemporaryDirectory();
    ByteData bytes = await rootBundle.load("assets/$filename");
    final assetPath = '${tempDir.path}/$filename';
    File file = await File(assetPath).create();
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file.path;
  }

  Future<bool> callApi(
      int all_time, int no_work, int coffee, int toilet, int wind, int shopping, int smoking, int something, int turnover
      ) async {
    final url = Uri.parse("http://3.35.111.171:80/wollu/");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final data = {
      'user': widget.currentUser.id,
      'all_time': all_time,
      'no_work': no_work,
      'coffe': coffee,
      'toilet': toilet,
      'wind': wind,
      'shopping': shopping,
      'smoking': smoking,
      'something': something,
      'turnover': turnover
    };
    try {
      final response = await http.post(
          url, body: json.encode(data), headers: headers);

      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || jsonData == null) {
        // Error handling
        setState(() {
          errorMsg =
          '서버에 접속할 수 없습니다. 인터넷 연결을 확인해주세요. \n 계속 문제가 발생한다면 고객센터로 문의주시기 바랍니다.';
        });
        return false;
      } else {
        return true;
      }
    } catch (e) {
      setState(() {
        errorMsg =
        '서버에 접속할 수 없습니다. 인터넷 연결을 확인해주세요. \n 계속 문제가 발생한다면 고객센터로 문의주시기 바랍니다.';
      });
      return false;
    }
  }

  Future<dynamic> getWollu(int id) async {
    final helper = DBHelper();
    final wolluTime = await helper.getWollu(id);
    total = wolluTime[1];
    wollu = wolluTime.sublist(2);
    Map<int, int> map = {};
    for (int i=0; i<wollu.length; i++) {
      map[i] = wollu[i];
    }
    sortedByValueMap = Map.fromEntries(
        map.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
    print(sortedByValueMap);
    setState(() {
      max = wollu.reduce((value, element) => value > element ? value : element);
      dataMap = {};
      colorList = [];
      indexList = [];
      sortedByValueMap.forEach((key, value) {
        final category = categories[key];
        indexList.add(key);
        categories[key].time = value;
        dataMap[category.name] = value.toDouble();
        colorList.add(Color(category.color));
      });
      categories.sort((e1, e2) => e2.time.compareTo(e1.time));
    });
  }



  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getWollu(widget.currentUser.id).then((value) => {
      daypay = (widget.currentUser.salary/(widget.currentUser.week_work*4)).floor(),
      barRate = (((total*(daypay/widget.currentUser.day_work/60/60)).floor()/daypay)*100).floor()
    });
    super.initState();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final dayPer = ((max/total*100).isNaN || (max/total*100).isInfinite) ? 0 : (max/total*100).floor();
    String facebookId = '2026184997588579';

    return Scaffold(
        body: ListView(
          children: [
            LayoutBuilder(
              builder: (BuildContext buildContext, covariant) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    width: size.width,
                    padding: const EdgeInsets.only(top: 42, left: 24, right: 24, bottom: 42),
                    color: Styles.blueGrey,
                    child: Column(
                      children: [
                        Container(
                          width: size.width > 430 ? 430 : size.width,
                          height: 156,
                          padding: const EdgeInsets.only(top: 28, left: 20, bottom: 22),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              color: Color(0xFF0017B3)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 38,
                                height: 17,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: Colors.white
                                ),
                                child: const Text(
                                  '루팡중',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF0017B3)
                                  ),
                                ),
                              ),
                              const Gap(7),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      transform('${(total*(daypay/widget.currentUser.day_work/60/60)).floor()}'),
                                      style: TextStyle(color: Styles.secondary, fontSize: 28, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Gap(2),
                                  Text(
                                    '원 루팡',
                                    style: Styles.fInfoStyle.copyWith(fontSize: 24, color: Colors.white),
                                  )
                                ],
                              ),
                              const Gap(14),
                              Stack(
                                children: [
                                  Container(
                                    width: size.width - 88 > 430 ? 430 - 44 : size.width - 88,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.white
                                    ),
                                  ),
                                  Container(
                                    width: (size.width - 88 > 430 ? 430 - 44 : size.width - 88) * barRate / 100,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: const Color(0xFF8ADF1D)
                                    ),
                                  )
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  const Text(
                                    '오늘 일급의 ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      (((total*(daypay/widget.currentUser.day_work/60/60)).floor()/daypay)*100).toStringAsFixed(3),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF8ADF1D)
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    '% 루팡',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const Gap(46),
                        Stack(
                            children: [
                              PieChart(
                                dataMap: dataMap,
                                colorList: colorList,
                                chartRadius: 192,
                                legendOptions: const LegendOptions(
                                    showLegends: false
                                ),
                                initialAngleInDegree: -90,
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValues: false,
                                ),
                              ),
                              Positioned(
                                  top: 85,
                                  left: size.width/2 - 45,
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(90),
                                        color: Colors.white
                                    ),
                                  )
                              ),
                              Positioned(
                                  top: 136,
                                  left: size.width/2,
                                  child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(90),
                                          color: Colors.white
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$dayPer%',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: colorList.first
                                          ),
                                        ),
                                      )
                                  )
                              )
                            ]
                        ),
                        Container(
                            width: size.width > 430 ? 430 : size.width,
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              alignment: Alignment.centerRight,
                              icon: Image.asset('assets/share.png', width: 24, height: 24, isAntiAlias: true,),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierColor: null,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        elevation: 20,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        titlePadding: const EdgeInsets.all(0),
                                        contentPadding: const EdgeInsets.all(0),
                                        content: Container(
                                          height: 86,
                                          alignment: Alignment.topCenter,
                                          padding: EdgeInsets.only(
                                              left: defaultTargetPlatform != TargetPlatform.iOS ? 35 : 89,
                                              right: defaultTargetPlatform != TargetPlatform.iOS ? 35 : 89,
                                              top: 6
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(onPressed: () {
                                                share.shareOnKakao();
                                              }, icon: Image.asset('assets/kakaox4.png')),
                                              if (defaultTargetPlatform != TargetPlatform.iOS) ... [
                                                IconButton(onPressed: () {
                                                  share.shareOnFacebook();
                                                }, icon: Image.asset('assets/facex4.png')),
                                                IconButton(onPressed: () {
                                                  share.shareOnTwitter();
                                                }, icon: Image.asset('assets/twx4.png')),
                                              ],
                                              IconButton(onPressed: () async {
                                                share.shareOnInstagram().then((value) {
                                                  if (value != null) {
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                                                  }
                                                });

                                              }, icon: Image.asset('assets/instax4.png')),
                                              IconButton(onPressed: () {
                                                share.shareSMS();
                                              }, icon: Image.asset('assets/linkx4.png'))
                                            ],
                                          ),
                                        ),
                                        title: Container(
                                            width: 319,
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerRight,
                                                  height: 27,
                                                  child: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.close, color: Styles.blueColor, size: 22),),
                                                ),
                                                const Gap(14),
                                                Text('친구에게 테스트 공유하기', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor, fontWeight: FontWeight.bold)),
                                              ],
                                            )
                                        ),
                                      );
                                    }
                                );
                              },
                            )
                        ),
                        Container(
                          width: size.width > 430 ? 430 : size.width,
                          height: 172,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withOpacity(0.6)
                          ),
                          child: ListView(
                            children: List.generate(categories.length, (index) {
                              return Container(
                                width: size.width > 430 ? 430 : size.width,
                                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          categories[index].image,
                                          width: 16,
                                          height: 16,
                                        ),
                                        const Gap(6),
                                        Column(
                                          children: [
                                            Text(
                                              categories[index].name,
                                              style: Styles.fEnableStyle,
                                            ),
                                            const Gap(2)
                                          ],
                                        ),
                                        const Gap(4),
                                        Text(
                                          ((categories[index].time/total*100).isNaN || (categories[index].time/total*100).isInfinite) ? '0%' : '${(categories[index].time/total*100).floor()}%',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          transform('${(categories[index].time*(daypay/widget.currentUser.day_work/60/60)).floor()}'),
                                          style: Styles.fEnableStyle.copyWith(fontWeight: FontWeight.w500),
                                        ),
                                        const Gap(2),
                                        Text(
                                          '원',
                                          style: Styles.fEnableStyle.copyWith(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        Container(
                          width: size.width > 430 ? 430 : size.width,
                          height: size.height - 556 - 131 - 43 < 0 ? 131 : size.height - 556 - 131 - 43,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 43 + 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Styles.blueColor
                                  ),
                                  width: size.width - 48 > 430 ? 430 : size.width - 48,
                                  height: 43,
                                  child: TextButton(
                                    onPressed: () {
                                      final List<CategoryData> passData = [];
                                      callApi(
                                          total, categories[0].time, categories[1].time, categories[2].time, categories[3].time, categories[4].time, categories[5].time, categories[6].time, categories[7].time
                                      ).then((success) => {
                                        if (success) {
                                          for (int i=0;i<categories.length;i++) {
                                            if (categories[i].time != 0) {
                                              categories[i].time = (categories[i].time*(daypay/widget.currentUser.day_work/60/60)).floor(),
                                              passData.add(categories[i])
                                            }
                                          },
                                          passData.sort((a, b) => b.time.compareTo(a.time)),
                                          if (passData.isEmpty) {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => FinishScreen(
                                              data: [CategoryData('월급루팡', 'assets/dobi.svg', 0xFF9F97FF, 0)],
                                              currentUser: widget.currentUser,
                                              total: 0,
                                            )))
                                          } else {
                                            helper.delete().then((value) => {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => FinishScreen(
                                                data: passData,
                                                currentUser: widget.currentUser,
                                                total: (total*(daypay/widget.currentUser.day_work/60/60)).floor(),
                                              ))),
                                            })
                                          }
                                        }
                                      });
                                    },
                                    child: Text('퇴근하기', style: Styles.fTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white)),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  width: size.width - 48 > 430 ? 430 : size.width - 48,
                                  height: 43,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Styles.blueColor, width: 1),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8))
                                        )
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllStatScreen(currentUser: widget.currentUser, total: (total*(daypay/widget.currentUser.day_work/60/60)).floor(),)));
                                    },
                                    child: Text('다른 월급루팡들 보기', style: Styles.fTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: Styles.blueColor)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        )
    );
  }
}
