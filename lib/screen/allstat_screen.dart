import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:wollu/entity/User.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:http/http.dart' as http;
import 'package:wollu/util/category_list.dart';
import 'package:wollu/util/convert_time.dart';

import 'main_origin.dart';


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
  CategoryList categoryList = CategoryList();
  var _trigger = true;
  Timer? timer;
  List<Data> dataList = [Data('직종', 0, 0, 0, 0), Data('연차', 0, 0, 0, 0), Data('성별', 0, 0, 0, 0), Data('연령', 0, 0, 0, 0)];
  var isLoading = false;
  var isLoadings = [true, true, true, true];
  var fstJob = '';
  var sndJob = '';
  var annuals = '';
  var sexs = -1;
  var ages = '';
  List<double> randoms = [Random.secure().nextDouble(), Random.secure().nextDouble(), Random.secure().nextDouble(), Random.secure().nextDouble()];
  Future<dynamic> get(int index, String job, String annual, int sex, String age) async {
    print('호출되었슴');
    setState(() {
      isLoadings[index] = true;
    });
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
      if (jsonData.isEmpty) {
        return;
      }

      for (var e in jsonData) {
        final data = Data(
            e['category'],
            e['min_wollu'],
            e['max_wollu'],
            e['total_wollu'],
            e['user_num']
        );
        print(e);
        setState(() {
          dataList[index] = data;
          if (index == 2) {
            if (data.name == '1') {
              dataList[2].name = '남성';
              sexs = 1;
            } else if (data.name == '2') {
              dataList[2].name = '여성';
              sexs = 2;
            } else {
              dataList[2].name = '선택 안 함';
              sexs = 3;
            }
          } else if (index == 0) {
            fstJob = data.name.split('/')[0];
            sndJob = data.name.split('/')[1];
          } else if (index == 1) {
            annuals = data.name;
          } else if (index == 3){
            ages = data.name;
          }
        });
      }
      setState(() {
        isLoadings[index] = false;
      });
    }
    print('끝낫슴');
  }
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
  Future<dynamic> init() async {
    try {
      await get(0, widget.currentUser.job, 'dump', -7, 'dump');
      await get(1, 'dump', widget.currentUser.annual, -7, 'dump');
      await get(2, 'dump', 'dump', widget.currentUser.sex, 'dump');
      await get(3, 'dump', 'dump', -7, widget.currentUser.age);
    } catch (e) {
      return false;
    }
  }
  String dots(String s) {
    if (s.length < 6) {
      return s;
    } else {
      return '${s.substring(0, 5)}...';
    }
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
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _trigger = !_trigger;
      });
    });
    init().then((value) => {
      setState((){isLoading = false;})
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final width = size.width > 430.0 ? 430.0 : size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: size.width,
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (BuildContext , BoxConstraints ) {
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  children: [
                    Container(
                        width: width,
                        padding: const EdgeInsets.only(top: 42, left: 24, right: 24),
                        decoration: BoxDecoration(
                            color: Styles.blueGrey
                        ),
                        child: Column(
                          children: [
                            // Home button
                            Container(
                              width: width,
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Main(currentUser: widget.currentUser)));
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
                                // 나와 비슷한 사람들은
                                Container(
                                    width: width,
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
                                // 얼마나 루팡하는지 알고싶다면?
                                Container(
                                    width: width,
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
                      width: width,
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 42, bottom: 42, left: 24, right: 24),
                      child: Column(
                        children: [
                          // 직종
                          Container(
                            width: width,
                            child: LayoutBuilder(
                              builder: (p0, p1) {
                                if (isLoadings[0]) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                                  ),
                                                  builder: (bContext) {
                                                    return SizedBox(
                                                      height: 382,
                                                      child: Column(
                                                        children: [
                                                          const Gap(40),
                                                          SizedBox(
                                                            height: 19,
                                                            width: AppLayout.getSize(context).width,
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 30),
                                                              child: Text('1차 직종', style: Styles.fTitleStyle.copyWith(fontSize: 16),),
                                                            ),
                                                          ),
                                                          const Gap(28),
                                                          SizedBox(
                                                            height: 260,
                                                            width: AppLayout.getSize(context).width,
                                                            child: ListView(
                                                              scrollDirection: Axis.vertical,
                                                              children: List.generate(14, (index) => Container(
                                                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                width: AppLayout.getSize(bContext).width,
                                                                height: 260/7,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(categoryList.job1ByIndex[index], style: fstJob == categoryList.job1ByIndex[index] ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                                    IconButton(
                                                                        onPressed: () {
                                                                          fstJob = categoryList.job1ByIndex[index];
                                                                          showModalBottomSheet(
                                                                              context: context,
                                                                              shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                                                              ),
                                                                              builder: (bbContext) {
                                                                                return SizedBox(
                                                                                  height: (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)) + 135 > 395 ? 395 : (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)) + 135,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      const Gap(40),
                                                                                      SizedBox(
                                                                                        width: AppLayout.getSize(context).width,
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Container(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                                              child: Text('2차 직종', style: Styles.fTitleStyle.copyWith(fontSize: 16),),
                                                                                            ),
                                                                                            Container(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                                              child: TextButton(
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(bContext);
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    '이전으로',
                                                                                                    style: Styles.fInfoStyle.copyWith(color: Styles.grey03),
                                                                                                  )
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ), // 2차직종
                                                                                      const Gap(14),
                                                                                      SizedBox(
                                                                                        height: (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)) > 260 ? 260 : (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)),
                                                                                        width: AppLayout.getSize(context).width,
                                                                                        child: ListView(
                                                                                          scrollDirection: Axis.vertical,
                                                                                          children: List.generate(categoryList.job2ByIndex[fstJob]!.length, (index) => Container(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                                            width: AppLayout.getSize(bContext).width,
                                                                                            height: (20*(categoryList.job2ByIndex[fstJob]!.length*2-1))/categoryList.job2ByIndex[fstJob]!.length.toDouble(),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Text(categoryList.job2ByIndex[fstJob]![index], style: sndJob != categoryList.job2ByIndex[fstJob]![index] ? Styles.titleStyle.copyWith(color: Colors.grey):Styles.titleStyle.copyWith(color: Colors.black)),
                                                                                                IconButton(
                                                                                                    onPressed: () {
                                                                                                      setState(() {
                                                                                                        sndJob = categoryList.job2ByIndex[fstJob]![index];
                                                                                                      });
                                                                                                      print('$fstJob/$sndJob');
                                                                                                      get(0, '$fstJob/$sndJob', 'dump', -7, 'dump');
                                                                                                      Navigator.pop(bbContext);
                                                                                                      Navigator.pop(bContext);
                                                                                                    },
                                                                                                    icon: sndJob != categoryList.job2ByIndex[fstJob]![index] ? Image.asset('assets/checkOff.png') : Image.asset('assets/checkOn.png'))
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              }
                                                                          );
                                                                        },
                                                                        icon: fstJob == categoryList.job1ByIndex[index] ? Image.asset('assets/checkOn.png') : Image.asset('assets/checkOff.png'))
                                                                  ],
                                                                ),
                                                              )
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }
                                              );
                                            },
                                            child: Container(
                                              height: 28,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.1),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 1.0,
                                                        offset: const Offset(0,0),
                                                        blurStyle: BlurStyle.outer
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dots(sndJob),
                                                    style: Styles.fEnableStyle,
                                                  ),
                                                  const Gap(12),
                                                  Image.asset(
                                                      width: 7,
                                                      height: 7,
                                                      'assets/downx4.png'
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            ' 하루에 평균',
                                            style: Styles.fEnableStyle.copyWith(color: Colors.black),
                                          ),
                                          Text(
                                            ' 월루 데이터를 수집중입니다.',
                                            style: Styles.fEnableStyle.copyWith(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                      Container(
                                          width: width,
                                          height: 10,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 3,
                                                child: Container(
                                                  width: width,
                                                  height: 4 - 1.63,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset: const Offset(0, -1.63),
                                                            blurRadius: 1.63,
                                                            color: Colors.black.withOpacity(0.10)
                                                        )
                                                      ],
                                                      color: const Color(0xFFF3F3F3)
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 1.63,
                                                child: AnimatedContainer(
                                                  curve: Curves.easeInOut,
                                                  width: _trigger ? width * randoms[0] : width * 0.1,
                                                  height: 4,
                                                  duration: const Duration(milliseconds: 1000),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Styles.blueColor
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                left: size.width/2 * randoms[0],
                                                child: SizedBox(
                                                  width: 8,
                                                  height: 8,
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
                                      ),
                                      const Gap(36),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 28,
                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 5.0,
                                                      spreadRadius: 1.0,
                                                      offset: const Offset(0,0),
                                                      blurStyle: BlurStyle.outer
                                                  )
                                                ]
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                                    ),
                                                    builder: (bContext) {
                                                      return SizedBox(
                                                        height: 382,
                                                        child: Column(
                                                          children: [
                                                            const Gap(40),
                                                            SizedBox(
                                                              height: 19,
                                                              width: AppLayout.getSize(context).width,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                child: Text('1차 직종', style: Styles.fTitleStyle.copyWith(fontSize: 16),),
                                                              ),
                                                            ),
                                                            const Gap(28),
                                                            SizedBox(
                                                              height: 260,
                                                              width: AppLayout.getSize(context).width,
                                                              child: ListView(
                                                                scrollDirection: Axis.vertical,
                                                                children: List.generate(14, (index) => Container(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                  width: AppLayout.getSize(bContext).width,
                                                                  height: 260/7,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(categoryList.job1ByIndex[index], style: fstJob == categoryList.job1ByIndex[index] ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                                      IconButton(
                                                                          onPressed: () {
                                                                            fstJob = categoryList.job1ByIndex[index];
                                                                            showModalBottomSheet(
                                                                                context: context,
                                                                                shape: const RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                                                                ),
                                                                                builder: (bbContext) {
                                                                                  return SizedBox(
                                                                                    height: (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)) + 135 > 395 ? 395 : (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)) + 135,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        const Gap(40),
                                                                                        SizedBox(
                                                                                          width: AppLayout.getSize(context).width,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Container(
                                                                                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                                                child: Text('2차 직종', style: Styles.fTitleStyle.copyWith(fontSize: 16),),
                                                                                              ),
                                                                                              Container(
                                                                                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                                                child: TextButton(
                                                                                                    onPressed: () {
                                                                                                      Navigator.pop(bContext);
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      '이전으로',
                                                                                                      style: Styles.fInfoStyle.copyWith(color: Styles.grey03),
                                                                                                    )
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ), // 2차직종
                                                                                        const Gap(14),
                                                                                        SizedBox(
                                                                                          height: (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)) > 260 ? 260 : (20*(categoryList.job2ByIndex[fstJob]!.length*2-1)),
                                                                                          width: AppLayout.getSize(context).width,
                                                                                          child: ListView(
                                                                                            scrollDirection: Axis.vertical,
                                                                                            children: List.generate(categoryList.job2ByIndex[fstJob]!.length, (index) => Container(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                                              width: AppLayout.getSize(bContext).width,
                                                                                              height: (20*(categoryList.job2ByIndex[fstJob]!.length*2-1))/categoryList.job2ByIndex[fstJob]!.length.toDouble(),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Text(categoryList.job2ByIndex[fstJob]![index], style: sndJob != categoryList.job2ByIndex[fstJob]![index] ? Styles.titleStyle.copyWith(color: Colors.grey):Styles.titleStyle.copyWith(color: Colors.black)),
                                                                                                  IconButton(
                                                                                                      onPressed: () {
                                                                                                        setState(() {
                                                                                                          sndJob = categoryList.job2ByIndex[fstJob]![index];
                                                                                                        });
                                                                                                        print('$fstJob/$sndJob');
                                                                                                        get(0, '$fstJob/$sndJob', 'dump', -7, 'dump');
                                                                                                        Navigator.pop(bbContext);
                                                                                                        Navigator.pop(bContext);
                                                                                                      },
                                                                                                      icon: sndJob != categoryList.job2ByIndex[fstJob]![index] ? Image.asset('assets/checkOff.png') : Image.asset('assets/checkOn.png'))
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                }
                                                                            );
                                                                          },
                                                                          icon: fstJob == categoryList.job1ByIndex[index] ? Image.asset('assets/checkOn.png') : Image.asset('assets/checkOff.png'))
                                                                    ],
                                                                  ),
                                                                )
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dots(sndJob),
                                                    style: Styles.fEnableStyle.copyWith(color: Colors.black),
                                                  ),
                                                  const Gap(12),
                                                  Image.asset(
                                                      width: 7,
                                                      height: 7,
                                                      'assets/downx4.png'
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            ' 하루에 평균',
                                            style: Styles.fEnableStyle.copyWith(color: Colors.black),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              ' ${transform((dataList[0].total/dataList[0].num).toStringAsFixed(0))} ',
                                              style: Styles.titleStyle.copyWith(color: Styles.blueColor, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            '원을 루팡해요.',
                                            style: Styles.fEnableStyle.copyWith(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                      Container(
                                          width: width,
                                          height: 10,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 3,
                                                child: Container(
                                                  width: width,
                                                  height: 4 - 1.63,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset: const Offset(0, -1.63),
                                                            blurRadius: 1.63,
                                                            color: Colors.black.withOpacity(0.10)
                                                        )
                                                      ],
                                                      color: const Color(0xFFF3F3F3)
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 1.63,
                                                child: Container(
                                                  width: (width-48) * (dataList[0].total/dataList[0].num)/(dataList[0].max-dataList[0].min),
                                                  height: 4,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Styles.blueColor
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                left: (widget.total > dataList[0].max || widget.total < dataList[0].min) ? widget.total > dataList[0].max ? width - 56 : 8 : (width - 48) * (widget.total/(dataList[0].max-dataList[0].min)) - 8,
                                                child: SizedBox(
                                                  width: 8,
                                                  height: 8,
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
                                      ),
                                      const Gap(36),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                          // 연차
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                  ),
                                  builder: (bContext) {
                                    return Column(
                                      children: [
                                        const Gap(40),
                                        LayoutBuilder(
                                          builder: (bc, bcs) {
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
                                                  children: [
                                                    Text(
                                                      categoryList.yearByIndex[index+1],
                                                      style: annuals == categoryList.yearByIndex[index+1] ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            annuals = categoryList.yearByIndex[index+1];
                                                          });
                                                          get(1, 'dump', annuals, -7, 'dump');
                                                          Navigator.pop(bc);
                                                        },
                                                        icon: Icon(
                                                          Icons.check_circle,
                                                          color: annuals == categoryList.yearByIndex[index+1] ? Colors.black : Colors.grey,))
                                                  ],
                                                ),
                                              )
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child: Container(
                              width: width,
                              child: LayoutBuilder(
                                builder: (p0, p1) {
                                  if (isLoadings[1]) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.1),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 1.0,
                                                        offset: const Offset(0,0),
                                                        blurStyle: BlurStyle.outer
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dots(annuals),
                                                    style: Styles.fInfoStyle,
                                                  ),
                                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                                ],
                                              ),
                                            ),
                                            Text(
                                              ' 하루에 평균',
                                              style: Styles.fEnableStyle,
                                            ),
                                            Text(
                                              ' 월루 데이터를 수집중입니다.',
                                              style: Styles.fEnableStyle,
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                            width: width,
                                            height: 10,
                                            alignment: Alignment.center,
                                            child: Tooltip(
                                              message: '수집중입니다.',
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: width,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: const Offset(0, -1.63),
                                                                blurRadius: 1.63,
                                                                color: Colors.black.withOpacity(0.10)
                                                            )
                                                          ],
                                                          color: const Color(0xFFF3F3F3)
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 3,
                                                    child: AnimatedContainer(
                                                      curve: Curves.easeInOut,
                                                      width: _trigger ? width * randoms[1] : width * 0.1,
                                                      height: 4,
                                                      duration: const Duration(milliseconds: 1000),
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Styles.blueColor
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0.5,
                                                    left: size.width/2 * randoms[1],
                                                    child: SizedBox(
                                                      width: 8,
                                                      height: 8,
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
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.1),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 1.0,
                                                        offset: const Offset(0,0),
                                                        blurStyle: BlurStyle.outer
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dataList[1].name,
                                                    style: Styles.fInfoStyle,
                                                  ),
                                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                                ],
                                              ),
                                            ),
                                            Text(
                                              ' 하루에 평균',
                                              style: Styles.fEnableStyle,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                ' ${(dataList[1].total/dataList[1].num).toStringAsFixed(0)} ',
                                                style: Styles.fTitleStyle.copyWith(color: Styles.blueColor),
                                              ),
                                            ),
                                            Text(
                                              '원을 루팡해요.',
                                              style: Styles.fEnableStyle,
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                            width: width,
                                            height: 10,
                                            alignment: Alignment.center,
                                            child: Tooltip(
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFF6D7194),
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              message: 'min/max : ${transform(dataList[1].min.toString())} / ${transform(dataList[1].max.toString())}',
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: width,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: const Offset(0, -1.63),
                                                                blurRadius: 1.63,
                                                                color: Colors.black.withOpacity(0.10)
                                                            )
                                                          ],
                                                          color: const Color(0xFFF3F3F3)
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: (width-48) * (dataList[1].total/dataList[1].num)/(dataList[1].max-dataList[1].min),
                                                      height: 4,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Styles.blueColor
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0.5,
                                                    left: (widget.total > dataList[1].max || widget.total < dataList[1].min) ? widget.total > dataList[1].max ? width - 56 : 8 : (width - 48) * (widget.total/(dataList[1].max-dataList[1].min)) - 8,
                                                    child: SizedBox(
                                                      width: 8,
                                                      height: 8,
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
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          // 성별
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                  ),
                                  builder: (bContext) {
                                    return SizedBox(
                                      height: 179,
                                      child: Column(
                                        children: [
                                          const Gap(40),
                                          LayoutBuilder(
                                            builder: (bc, bcs) {
                                              return Flex(
                                                direction: Axis.vertical,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                mainAxisSize: MainAxisSize.min,
                                                children: List.generate(3, (index) => Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                                  width: AppLayout.getSize(context).width,
                                                  height: 100/3,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        categoryList.sexByIndex[index+1],
                                                        style: sexs == index+1 ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              sexs = index+1;
                                                            });
                                                            get(2, 'dump', 'dump', sexs, 'dump');
                                                            Navigator.pop(bc);
                                                          },
                                                          icon: Icon(
                                                            Icons.check_circle,
                                                            color: sexs == index+1 ? Colors.black : Colors.grey,))
                                                    ],
                                                  ),
                                                )
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              );
                            },
                            child: Container(
                              width: width,
                              child: LayoutBuilder(
                                builder: (p0, p1) {
                                  if (isLoadings[2]) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.1),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 1.0,
                                                        offset: const Offset(0,0),
                                                        blurStyle: BlurStyle.outer
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dots(categoryList.sexByIndex[sexs]),
                                                    style: Styles.fInfoStyle,
                                                  ),
                                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                                ],
                                              ),
                                            ),
                                            Text(
                                              ' 하루에 평균',
                                              style: Styles.fEnableStyle,
                                            ),
                                            Text(
                                              ' 월루 데이터를 수집중입니다.',
                                              style: Styles.fEnableStyle,
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                            width: width,
                                            height: 10,
                                            alignment: Alignment.center,
                                            child: Tooltip(
                                              message: '수집중입니다.',
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: width,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: const Offset(0, -1.63),
                                                                blurRadius: 1.63,
                                                                color: Colors.black.withOpacity(0.10)
                                                            )
                                                          ],
                                                          color: const Color(0xFFF3F3F3)
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 3,
                                                    child: AnimatedContainer(
                                                      curve: Curves.easeInOut,
                                                      width: _trigger ? width * randoms[2] : width * 0.1,
                                                      height: 4,
                                                      duration: const Duration(milliseconds: 1000),
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Styles.blueColor
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0.5,
                                                    left: size.width/2 * randoms[2],
                                                    child: SizedBox(
                                                      width: 8,
                                                      height: 8,
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
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.1),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 1.0,
                                                        offset: const Offset(0,0),
                                                        blurStyle: BlurStyle.outer
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dataList[2].name,
                                                    style: Styles.fInfoStyle,
                                                  ),
                                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                                ],
                                              ),
                                            ),
                                            Text(
                                              ' 하루에 평균',
                                              style: Styles.fEnableStyle,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                ' ${(dataList[2].total/dataList[2].num).toStringAsFixed(0)} ',
                                                style: Styles.fTitleStyle.copyWith(color: Styles.blueColor),
                                              ),
                                            ),
                                            Text(
                                              '원을 루팡해요.',
                                              style: Styles.fEnableStyle,
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                            width: width,
                                            height: 10,
                                            alignment: Alignment.center,
                                            child: Tooltip(
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFF6D7194),
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              message: 'min/max : ${transform(dataList[2].min.toString())} / ${transform(dataList[2].max.toString())}',
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: width,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: const Offset(0, -1.63),
                                                                blurRadius: 1.63,
                                                                color: Colors.black.withOpacity(0.10)
                                                            )
                                                          ],
                                                          color: const Color(0xFFF3F3F3)
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: (width-48) * (dataList[2].total/dataList[2].num)/(dataList[2].max-dataList[2].min),
                                                      height: 4,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Styles.blueColor
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0.5,
                                                    left: (widget.total > dataList[2].max || widget.total < dataList[2].min) ? widget.total > dataList[2].max ? width - 56 : 8 : (width - 48) * (widget.total/(dataList[2].max-dataList[2].min)) - 8,
                                                    child: SizedBox(
                                                      width: 8,
                                                      height: 8,
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
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          // 연령
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                  ),
                                  builder: (bContext) {
                                    return Column(
                                      children: [
                                        const Gap(40),
                                        LayoutBuilder(
                                          builder: (bc, bcs) {
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
                                                  children: [
                                                    Text(
                                                      categoryList.ageByIndex[index+1],
                                                      style: ages == categoryList.ageByIndex[index+1] ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ages = categoryList.ageByIndex[index+1];
                                                          });
                                                          get(3, 'dump', 'dump', -7, ages);
                                                          Navigator.pop(bc);
                                                        },
                                                        icon: Icon(
                                                          Icons.check_circle,
                                                          color: ages == categoryList.ageByIndex[index+1] ? Colors.black : Colors.grey,)
                                                    )
                                                  ],
                                                ),
                                              )
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child: Container(
                              width: width,
                              child: LayoutBuilder(
                                builder: (p0, p1) {
                                  if (isLoadings[3]) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.1),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 1.0,
                                                        offset: const Offset(0,0),
                                                        blurStyle: BlurStyle.outer
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dots(ages),
                                                    style: Styles.fInfoStyle,
                                                  ),
                                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                                ],
                                              ),
                                            ),
                                            Text(
                                              ' 하루에 평균',
                                              style: Styles.fEnableStyle,
                                            ),
                                            Text(
                                              ' 월루 데이터를 수집중입니다.',
                                              style: Styles.fEnableStyle,
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                            width: width,
                                            height: 10,
                                            alignment: Alignment.center,
                                            child: Tooltip(
                                              message: '수집중입니다.',
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: width,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: const Offset(0, -1.63),
                                                                blurRadius: 1.63,
                                                                color: Colors.black.withOpacity(0.10)
                                                            )
                                                          ],
                                                          color: const Color(0xFFF3F3F3)
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 3,
                                                    child: AnimatedContainer(
                                                      curve: Curves.easeInOut,
                                                      width: _trigger ? width * randoms[3] : width * 0.1,
                                                      height: 4,
                                                      duration: const Duration(milliseconds: 1000),
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Styles.blueColor
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0.5,
                                                    left: size.width/2 * randoms[3],
                                                    child: SizedBox(
                                                      width: 8,
                                                      height: 8,
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
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.1),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 1.0,
                                                        offset: const Offset(0,0),
                                                        blurStyle: BlurStyle.outer
                                                    )
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    dataList[3].name,
                                                    style: Styles.fInfoStyle,
                                                  ),
                                                  Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                                ],
                                              ),
                                            ),
                                            Text(
                                              ' 하루에 평균',
                                              style: Styles.fEnableStyle,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                ' ${(dataList[3].total/dataList[3].num).toStringAsFixed(0)} ',
                                                style: Styles.fTitleStyle.copyWith(color: Styles.blueColor),
                                              ),
                                            ),
                                            Text(
                                              '원을 루팡해요.',
                                              style: Styles.fEnableStyle,
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                            width: width,
                                            height: 10,
                                            alignment: Alignment.center,
                                            child: Tooltip(
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFF6D7194),
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              message: 'min/max : ${transform(dataList[3].min.toString())} / ${transform(dataList[3].max.toString())}',
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: width,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: const Offset(0, -1.63),
                                                                blurRadius: 1.63,
                                                                color: Colors.black.withOpacity(0.10)
                                                            )
                                                          ],
                                                          color: const Color(0xFFF3F3F3)
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 3,
                                                    child: Container(
                                                      width: (width-48) * (dataList[3].total/dataList[3].num)/(dataList[3].max-dataList[3].min),
                                                      height: 4,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Styles.blueColor
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0.5,
                                                    left: (widget.total > dataList[3].max || widget.total < dataList[3].min) ? widget.total > dataList[3].max ? width - 56 : 8 : (width - 48) * (widget.total/(dataList[3].max-dataList[3].min)) - 8,
                                                    child: SizedBox(
                                                      width: 8,
                                                      height: 8,
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
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          // Bottom button
                          // Container(
                          //   width: width,
                          //   height: 141,
                          //   child: Stack(
                          //     children: [
                          //       Positioned(
                          //         bottom: 0,
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(8),
                          //               color: Styles.blueGrey
                          //           ),
                          //           width: size.width > 430 ? 430 : width - 48,
                          //           height: 43,
                          //           child: TextButton(
                          //             child: Text('월루 랭킹보기', style: Styles.fTitleStyle.copyWith(color: Styles.blueColor, fontSize: 16),),
                          //             onPressed: () {
                          //
                          //             },
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                );
              }
            }),
        )
      ),
    );
  }
}
