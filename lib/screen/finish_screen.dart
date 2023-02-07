import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:wollu/entity/User.dart';
import 'package:wollu/screen/allstat_screen.dart';
import 'package:wollu/screen/result_screen.dart';
import 'package:wollu/screen/stat_screen.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';

import 'main_screen.dart';

class FinishScreen extends StatefulWidget {
  List<CategoryData> data;
  User currentUser;
  int total;
  FinishScreen({Key? key, required this.data, required this.currentUser, required this.total}) : super(key: key);

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
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
  var total = 0;
  final newImages = {
    '없무 없음': 'assets/finNot.png',
    '커피/간식 먹기': 'assets/finSnack.png',
    '화장실 가기': 'assets/finToilet.png',
    '바깥바람쐬기': 'assets/finWind.png',
    '인터넷 서핑하기': 'assets/finInternet.png',
    '담배 피우기': 'assets/finSmoke.png',
    '딴짓하기': 'assets/finDo.png',
    '이직준비': 'assets/finPre'
  };

  @override
  void initState() {
    // TODO: implement initState
    for (int i=0;i<widget.data.length;i++) {
      total += widget.data[i].time;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsets.only(top: 42, bottom: 42, left: 24, right: 24),
              color: Styles.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StatScreen(currentUser: widget.currentUser)));
                            },
                            icon: Image.asset(
                              'assets/chart.png',
                              width: 24,
                              height: 24,
                            )
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(currentUser: widget.currentUser)));
                          },
                          icon: Image.asset(
                            'assets/home.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  Container(
                    width: size.width,
                    height: 387,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Styles.blueColor
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          newImages[widget.data[0].name]!,
                        ),
                        const Gap(13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              transform(widget.total.toString()),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Pretendard'
                              ),
                            ),
                            const Text(
                              '원 루팡했다!',
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Pretendard'
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(12),
                  Container(
                    width: size.width,
                    height: 136,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white.withOpacity(0.6)
                    ),
                    child: ListView(
                      children: List.generate(widget.data.length, (index) {
                        return Container(
                          width: size.width,
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    widget.data[index].image,
                                    width: 16,
                                    height: 16,
                                  ),
                                  const Gap(6),
                                  Column(
                                    children: [
                                      Text(
                                        widget.data[index].name,
                                        style: Styles.fEnableStyle,
                                      ),
                                      const Gap(2)
                                    ],
                                  ),
                                  const Gap(4),
                                  Text(
                                    '${(widget.data[index].time/total*100).floor()}%',
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
                                    transform('${(widget.data[index].time)}'),
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
                  const Gap(28),
                  Text('친구에게 테스트 공유하기'),
                  const Gap(14),
                  Container(
                    width: 210,
                    height: 34,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/chart.png'),
                        Image.asset('assets/chart.png'),
                        Image.asset('assets/chart.png'),
                        Image.asset('assets/chart.png'),
                        Image.asset('assets/chart.png')
                      ],
                    ),
                  ),
                  const Gap(28),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white
                    ),
                    width: size.width,
                    height: 43,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Styles.blueColor, width: 1)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllStatScreen(currentUser: widget.currentUser, total: widget.total,)));
                      },
                      child: Text('다른 월급루팡들 보기', style: Styles.fTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: Styles.blueColor)),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
