import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wollu/category_view.dart';
import 'package:wollu/circle_painter.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:wollu/util/local_notification.dart';

import '../util/categories.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var categoryHeight = 156.0;
  var categories = [
    Category(image: 'assets/nothing.svg', name: '업무 없음'),
    Category(image: 'assets/coffee.svg', name: '커피/간식 먹기'),
    Category(image: 'assets/toilet.svg', name: '화장실 가기'),
    Category(image: 'assets/wind.svg', name: '바깥바람쐬기'),
    Category(image: 'assets/internet.svg', name: '인터넷 서핑하기'),
    Category(image: 'assets/smoke.svg', name: '담배 피우기'),
    Category(image: 'assets/dosomething.svg', name: '딴짓하기'),
    Category(image: 'assets/prepare.svg', name: '이직준비')
  ];
  List<Category> _list = [];
  var selected = [
    false,
    true,
    false,
    false,
    false,
    true,
    true,
    false
  ];

  @override
  void initState() {
    LocalNotification.init();
    for (int i=0;i<8;i++) {
      if (selected[i]) {
        _list.add(categories[i]);
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Styles.blueGrey,
        body: _body()
      )
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/statistics.svg',
                      )
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/settings.svg',
                        width: 24,
                        height: 39,
                      )
                  )
                ],
              ), // 아이콘 버튼
            ), // 상단 버튼
            SizedBox(
              width: 132,
              height: 32,
              child: Center(
                child: Text(
                  '06:32',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Styles.blueColor
                  ),
                ),
              ),
            ), // 시계
            const Gap(15),
            SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            width: 300,
                            height: 300,
                            child: CustomPaint(
                              painter: CirclePainter(),
                            )
                        ),
                        SizedBox(
                            width: 300,
                            height: 300,
                            child: CustomPaint(
                              painter: ArcPainter(),
                            )
                        ),
                      ],
                    ),
                    Positioned(
                      child: Image.asset(
                        'assets/snacks.png',
                        width: 235,
                        height: 235,
                      ),
                    ),
                    Positioned(
                      top: 230,
                      width: 75,
                      height: 75,
                      child: IconButton(
                        icon: Image.asset(
                          'assets/play.png',
                        ),
                        onPressed: () {
                          LocalNotification.notification();
                        },
                      ),
                    ),
                  ],
                )
            ), // 센터
            const Gap(30),
            SizedBox(
              height: 156,
              child: ListView(
                children: _list.map((category) => CategoryView(category: category)).toList(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFFE3E4EC)
              ),
              width: 327,
              height: 42,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                      ),
                      builder: (BuildContext bContext) {
                        return Column(
                          children: [
                            const Gap(40),
                            StatefulBuilder(
                              builder: (BuildContext bc, StateSetter setState) {
                                return Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(8, (index) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    width: AppLayout.getSize(context).width,
                                    height: 300/8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          categories[index].name,
                                          style: selected[index] ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                selected[index] = !selected[index];
                                                if (selected[index]) {
                                                  _list.add(categories[index]);
                                                } else {
                                                  _list.remove(categories[index]);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: selected[index] ? Colors.black : Colors.grey,)
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                  );
                },
              ),
            ),  // + 버튼
            const Gap(40),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Styles.blueColor
              ),
              width: 327,
              height: 43,
              child: TextButton(
                onPressed: () {

                },
                child: Text('계산하기', style: Styles.fTextStyle.copyWith(fontSize: 16, color: Colors.white),),
              ),
            ), // 계산하기 버튼
            const Gap(30)
          ],
        ),
      ],
    );
  }
}
