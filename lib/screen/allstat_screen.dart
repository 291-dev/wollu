import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wollu/entity/User.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:http/http.dart' as http;

import 'main_screen.dart';

class AllStatScreen extends StatefulWidget {
  User currentUser;
  int total;
  AllStatScreen({Key? key, required this.currentUser, required this.total}) : super(key: key);

  @override
  _AllStatScreenState createState() => _AllStatScreenState();
}
class Data {
  String name;
  int min;
  int max;
  int total;
  int num;

  Data(
      this.name,
      this.min,
      this.max,
      this.total,
      this.num
      );
}

class _AllStatScreenState extends State<AllStatScreen> {
  var _trigger = true;
  Timer? timer;
  var isLoading = false;
  List<Data> dumpData = [

  ];
  Future<dynamic> get(String job, String annual, int sex, String age) async {
    final url = Uri.parse("http://3.35.111.171:80/stats/?job=${job}&annual=${annual}&sex=${sex}&age=${age}");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final response = await http.get(url, headers: headers);
    List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || jsonData == null) {
      Future.error('데이터를 가져오는데 실패했습니다.');
    } else {
      print(jsonData);
      var time = 0;
      for (var e in jsonData) {
        // final date = e['create_date'].toString().split('-');
        // final day = int.parse(date[2]);
        // final month = int.parse(date[1]);
        // time = e['all_time'];
        // wolluByMonth[currentDate!.month-1].wollus[day-1].setTime(time);
      }
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<dynamic> dump() async {
    dumpData.add(Data(widget.currentUser.job, 123, 124135, 4513520, 50));
    dumpData.add(Data(widget.currentUser.annual, 23455, 224544, 4513520, 50));
    dumpData.add(Data(widget.currentUser.nickname, 43412, 343512, 4513520, 50));
    dumpData.add(Data(widget.currentUser.age, 13421, 143554, 121320, 54));
    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    dump();
    // get(widget.currentUser.job, widget.currentUser.annual, widget.currentUser.sex, widget.currentUser.age);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _trigger = !_trigger;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext , BoxConstraints ) {
            return ListView(
              children: [
                Container(
                    width: size.width,
                    padding: const EdgeInsets.only(top: 42, left: 24, right: 24),
                    decoration: BoxDecoration(
                        color: Styles.blueGrey
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(currentUser: widget.currentUser)));
                            },
                            icon: Image.asset(
                              'assets/home.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: size.width,
                                child: Text(
                                  '나랑 비슷한 사람들은',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Styles.blueColor,
                                      fontFamily: 'Pretendard'
                                  ),
                                )
                            ),
                            const Gap(4),
                            Container(
                                width: size.width,
                                child: Text(
                                  '얼마나 루팡하는지 알고싶다면?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Styles.blueColor,
                                      fontFamily: 'Pretendard'
                                  ),
                                )
                            )
                          ],
                        ),
                        const Gap(22),
                      ],
                    )
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(top: 42, bottom: 42, left: 24, right: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white70.withOpacity(0.9),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0,1),
                                  )
                                ]
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '직종',
                                    style: Styles.fInfoStyle,
                                  ),
                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '하루에 평균',
                            style: Styles.fEnableStyle,
                          ),
                          if (!isLoading)
                          Container(
                            alignment: Alignment.center,
                            width: 65,
                            child: Text(
                              (dumpData[0].total/dumpData[0].num).toString(),
                              style: Styles.fTitleStyle.copyWith(color: Styles.blueColor),
                            ),
                          ),
                          Text(
                            isLoading ? ' 월루데이터를 수집중입니다.' : '원을 루팡해요.',
                            style: Styles.fEnableStyle,
                          )
                        ],
                      ),
                      const Gap(10),
                      Container(
                          width: size.width,
                          height: 10,
                          alignment: Alignment.center,
                          child: Tooltip(
                            message: 'hi',
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 3,
                                  child: SizedBox(
                                    width: size.width,
                                    height: 4,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: const Color(0xFFF3F3F3)
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  child: AnimatedContainer(
                                    curve: Curves.elasticInOut,
                                    width: _trigger ? size.width * (dumpData[0].total/dumpData[0].num)/dumpData[0].max : size.width * 0.1,
                                    height: 4,
                                    duration: const Duration(milliseconds: 1000),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.5,
                                  left: size.width/2 * (widget.total/(dumpData[0].total/dumpData[0].num)),
                                  child: SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      const Gap(36),
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white70.withOpacity(0.9),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0,1),
                                  )
                                ]
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '연차',
                                    style: Styles.fInfoStyle,
                                  ),
                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '하루에 평균',
                            style: Styles.fEnableStyle,
                          ),
                          if (!isLoading)
                            Container(
                              alignment: Alignment.center,
                              width: 65,
                              child: Text(
                                (dumpData[0].total/dumpData[0].num).toString(),
                                style: Styles.fTitleStyle.copyWith(color: Styles.blueColor),
                              ),
                            ),
                          Text(
                            isLoading ? ' 월루데이터를 수집중입니다.' : '원을 루팡해요.',
                            style: Styles.fEnableStyle,
                          )
                        ],
                      ),
                      const Gap(10),
                      Container(
                          width: size.width,
                          height: 10,
                          alignment: Alignment.center,
                          child: Tooltip(
                            message: 'hi',
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 3,
                                  child: SizedBox(
                                    width: size.width,
                                    height: 4,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: const Color(0xFFF3F3F3)
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  child: AnimatedContainer(
                                    curve: Curves.elasticInOut,
                                    width: _trigger ? size.width * (dumpData[1].total/dumpData[1].num)/dumpData[1].max : size.width * 0.5,
                                    height: 4,
                                    duration: const Duration(milliseconds: 1000),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.5,
                                  left: size.width/2 * (widget.total/(dumpData[0].total/dumpData[0].num)),
                                  child: SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      const Gap(36),
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white70.withOpacity(0.9),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0,1),
                                  )
                                ]
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '성별',
                                    style: Styles.fInfoStyle,
                                  ),
                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '하루에 평균',
                            style: Styles.fEnableStyle,
                          ),
                          if (!isLoading)
                            Container(
                              alignment: Alignment.center,
                              width: 65,
                              child: Text(
                                (dumpData[0].total/dumpData[0].num).toString(),
                                style: Styles.fTitleStyle.copyWith(color: Styles.blueColor),
                              ),
                            ),
                          Text(
                            isLoading ? ' 월루데이터를 수집중입니다.' : '원을 루팡해요.',
                            style: Styles.fEnableStyle,
                          )
                        ],
                      ),
                      const Gap(10),
                      Container(
                          width: size.width,
                          height: 10,
                          alignment: Alignment.center,
                          child: Tooltip(
                            message: 'hi',
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 3,
                                  child: SizedBox(
                                    width: size.width,
                                    height: 4,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: const Color(0xFFF3F3F3)
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  child: AnimatedContainer(
                                    curve: Curves.easeInOut,
                                    width: _trigger ? size.width * (dumpData[2].total/dumpData[2].num)/dumpData[2].max : size.width * 0.8,
                                    height: 4,
                                    duration: const Duration(milliseconds: 1000),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.5,
                                  left: size.width/2 * (widget.total/(dumpData[0].total/dumpData[0].num)),
                                  child: SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      const Gap(36),
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white70.withOpacity(0.9),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0,1),
                                  )
                                ]
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '연령',
                                    style: Styles.fInfoStyle,
                                  ),
                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '하루에 평균',
                            style: Styles.fEnableStyle,
                          ),
                          if (!isLoading)
                            Container(
                              alignment: Alignment.center,
                              width: 65,
                              child: Text(
                                (dumpData[0].total/dumpData[0].num).toString(),
                                style: Styles.fTitleStyle.copyWith(color: Styles.blueColor),
                              ),
                            ),
                          Text(
                            isLoading ? ' 월루데이터를 수집중입니다.' : '원을 루팡해요.',
                            style: Styles.fEnableStyle,
                          )
                        ],
                      ),
                      const Gap(10),
                      Container(
                          width: size.width,
                          height: 10,
                          alignment: Alignment.center,
                          child: Tooltip(
                            message: 'hi',
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 3,
                                  child: SizedBox(
                                    width: size.width,
                                    height: 4,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: const Color(0xFFF3F3F3)
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  child: AnimatedContainer(
                                    curve: Curves.elasticInOut,
                                    width: _trigger ? size.width * (dumpData[3].total/dumpData[3].num)/dumpData[3].max : size.width * 0.05,
                                    height: 4,
                                    duration: const Duration(milliseconds: 1000),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.5,
                                  left: size.width/2 * (widget.total/(dumpData[0].total/dumpData[0].num)),
                                  child: SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Styles.blueColor
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      const Gap(174),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFE3E4EC)
                        ),
                        width: size.width,
                        height: 43,
                        child: TextButton(
                          child: Text('월루 랭킹보기', style: Styles.fTitleStyle.copyWith(color: Styles.blueColor, fontSize: 16),),
                          onPressed: () {

                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },)
      ),
    );
  }
}
