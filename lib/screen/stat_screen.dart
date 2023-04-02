import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wollu/entity/wollu_month.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:http/http.dart' as http;

import '../entity/User.dart';

class StatScreen extends StatefulWidget {
  User currentUser;
  StatScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  var isLoading = true;
  DateTime? currentDate;
  List<WolluByMonth> wolluByMonth = [
    WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth(), WolluByMonth()
  ];
  List<int> timeByMonth = [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  ];

  static String transform(String s) {
    var newStr = '';
    for (int i=0;i<s.length;i++) {
      if ((s.length-i)%3==0 && i != 0) {
        newStr += ',';
      }
      newStr += s[i];
    }
    return newStr;
  }

  Future<dynamic> initData() async {
      await get(widget.currentUser.id);
  }

  Future<dynamic> get(int id) async {
    final url = Uri.parse("http://3.35.111.171:80/wollu/month/$id/?year=${currentDate!.year}&month=${currentDate!.month}");
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
        final date = e['create_date'].toString().split('-');
        final day = int.parse(date[2]);
        final month = int.parse(date[1]);
        time = e['all_time'];
        wolluByMonth[currentDate!.month-1].wollus[day-1].setTime((time*((widget.currentUser.salary/(widget.currentUser.week_work*4)).floor()/widget.currentUser.day_work/60/60)).floor());
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // 오늘 날짜로 초기화
    currentDate = DateTime.now();
    initData().then((value) {
      wolluByMonth[currentDate!.month-1].wollus.forEach((wollu) {
        setState(() {
          timeByMonth[currentDate!.month-1] += wollu.time;
        });
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
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              width: size.width,
              padding: const EdgeInsets.only(bottom: 33),
              child: LayoutBuilder(
                builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container(
                      color: Styles.blueGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(42),
                          Container(
                            width: size.width > 430 ? 430 : size.width,
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Image.asset(
                                'assets/x4home.png',
                                width: 24,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const Gap(6),
                          Container(
                            width: size.width > 430 ? 430 : size.width,
                            height: 108,
                            padding: const EdgeInsets.all(24),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Color(0xFF0017B3)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '이번달 월루 금액',
                                      style: Styles.fInfoStyle.copyWith(color: Colors.white),
                                    ),
                                    const Gap(8),
                                    Text(
                                      transform(timeByMonth[currentDate!.month-1].toString()),
                                      style: TextStyle(color: Styles.secondary, fontSize: 20, fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                const Gap(8),
                                Row(
                                  children: [
                                    Text(
                                      '오늘 월루 금액',
                                      style: Styles.fInfoStyle.copyWith(color: Colors.white),
                                    ),
                                    const Gap(8),
                                    Text(
                                      transform(wolluByMonth[currentDate!.month-1].wollus[currentDate!.day-1].time.toString()),
                                      style: TextStyle(color: Styles.secondary, fontSize: 20, fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Gap(12),
                          Container(
                            width: size.width > 430 ? 430 : size.width,
                            padding: const EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: TableCalendar(
                                focusedDay: DateTime.now(),
                                firstDay: DateTime.utc(2023, 1, 1),
                                lastDay: DateTime.utc(2023, 12, 31),
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  titleTextFormatter: (date, locale) => DateFormat.MMMM(locale).format(date),
                                  titleTextStyle: Styles.fTitleStyle.copyWith(fontSize: 16, color: Styles.blueColor),
                                  leftChevronIcon: Image.asset('assets/calLeftx4.png', width: 18, height: 18, isAntiAlias: true),
                                  rightChevronIcon: Image.asset('assets/calRightx4.png', width: 18, height: 18, isAntiAlias: true),
                                ),
                                rowHeight: 54,
                                daysOfWeekHeight: 68,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                daysOfWeekStyle: DaysOfWeekStyle(
                                    weekdayStyle: Styles.fInfoStyle.copyWith(fontWeight: FontWeight.w500),
                                    weekendStyle: Styles.fInfoStyle.copyWith(fontWeight: FontWeight.w500)
                                ),
                                calendarBuilders: CalendarBuilders(
                                  defaultBuilder: (context, day, focusedDay) {
                                    return Container(
                                      margin: const EdgeInsets.all(6),
                                      width: AppLayout.getSize(context).width,
                                      height: AppLayout.getSize(context).height,
                                      child: Column(
                                        children: [
                                          Text(
                                            day.day.toString(),
                                            style: Styles.fTitleStyle.copyWith(color: Color(0xFF222B45), fontWeight: FontWeight.normal),
                                          ),
                                          const Gap(10),
                                          Text(
                                              transform(wolluByMonth[day.month-1].wollus[day.day-1].time.toString()),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  color: Styles.grey03
                                              )
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  todayBuilder: (context, day, focusedDay) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 6),
                                      width: AppLayout.getSize(context).width,
                                      height: AppLayout.getSize(context).height,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Styles.blueColor
                                            ),
                                            child: Text(
                                              day.day.toString(),
                                              style: Styles.fTitleStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const Gap(5.14),
                                          Text(
                                              transform(wolluByMonth[day.month-1].wollus[day.day-1].time.toString()),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Styles.blueColor
                                              )
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  outsideBuilder: (context, day, focusedDay) {
                                    return Container(
                                      margin: const EdgeInsets.all(6),
                                      width: AppLayout.getSize(context).width,
                                      height: AppLayout.getSize(context).height,
                                      child: Column(
                                        children: [
                                          Text(
                                            day.day.toString(),
                                            style: Styles.fTitleStyle.copyWith(color: Styles.enable, fontWeight: FontWeight.normal),
                                          ),
                                          const Gap(10),
                                          Text(
                                              '-',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  color: Styles.grey03
                                              )
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  disabledBuilder: (context, day, focusedDay) {
                                    return Container(
                                      margin: const EdgeInsets.all(6),
                                      width: AppLayout.getSize(context).width,
                                      height: AppLayout.getSize(context).height,
                                      child: Column(
                                        children: [
                                          Text(
                                            day.day.toString(),
                                            style: Styles.fTitleStyle.copyWith(color: Styles.enable, fontWeight: FontWeight.normal),
                                          ),
                                          const Gap(10),
                                          Text(
                                              '',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  color: Styles.grey03
                                              )
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
          ),
        ),
      ),
    );
  }
}
