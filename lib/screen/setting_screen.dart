import 'dart:convert';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:wollu/util/category_list.dart';
import 'package:wollu/util/db_helper.dart';
import 'package:http/http.dart' as http;
import '../entity/User.dart';

class SetScreen extends StatefulWidget {
  User? currentUser;
  SetScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  _SetScreenState createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  DBHelper helper = DBHelper();
  List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  int id = 0;
  String? nickname;
  String? salary;
  String salToWon(String value) {
    var index = 0;
    var zero = 0;
    var plus = [
      '만',
      '억',
      '조',
      '경'
    ];
    var result = '';
    // 123,456,789
    var delComma = value.replaceAll(',', '');
    // 1 2345 6789 => 일억 이천삼백사십오만 육천칠백팔십구
    for (int i=delComma.length; i>0; i--) {
      var temp = '';
      switch(delComma[i-1]) {
        case '1' :
          temp += '일';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '2' :
          temp += '이';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '3' :
          temp += '삼';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '4' :
          temp += '사';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '5' :
          temp += '오';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '6' : temp += '육';
        if (index%4 == 1) {
          temp += '십';
        } else if (index%4 == 2) {
          temp += '백';
        } else if (index%4 == 3) {
          temp += '천';
        } else if (index != 0 && index%4 == 0) {
          temp += plus[(index/4).toInt()-1];
        }
        break;
        case '7' :
          temp += '칠';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '8' :
          temp += '팔';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '9' :
          temp += '구';
          if (index%4 == 1) {
            temp += '십';
          } else if (index%4 == 2) {
            temp += '백';
          } else if (index%4 == 3) {
            temp += '천';
          } else if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          break;
        case '0' :
          if (index != 0 && index%4 == 0) {
            temp += plus[(index/4).toInt()-1];
          }
          zero++;
      }
      index++;
      if (zero >= 8 && delComma.length >= 9)
        result = temp + result.replaceAll('만', '');
      else
        result = temp + result;

    }
    return result;
  }
  String salStr = '';
  String? week_work;
  String? day_work;
  String job = '';
  String selectedJob = '';
  String annual = '';
  int sex = 0;
  String age = '';
  CategoryList categoryList = CategoryList();

  void validate() {
    if (nickname == null) {
      return;
    }

    if (salary == null) {
      return;
    } else {
      salary = salary!.replaceAll(',', '');
    }

    if (week_work == null || day_work == null || week_work!.isEmpty || day_work!.isEmpty) {
      return;
    }

    var tempJob = ' ';
    if (job.isNotEmpty) {
      tempJob = '$selectedJob/$job';
    }

    var tempAn = ' ';
    if (annual != '연차') {
      tempAn = annual;
    }

    var tempS = 0;
    if (sex != 0) {
      tempS = sex;
    }

    var tempAge = ' ';
    if (age != '연령') {
      tempAge = age;
    }

    callApi(nickname!, int.parse(salary!), int.parse(week_work!), int.parse(day_work!), tempJob, tempAn, tempS, tempAge);
  }

  void callApi(String nickname, int salary, int week_work, int day_work, String job, String annual, int sex, String age) async {
    final url = Uri.parse("http://3.35.111.171:80/users/$id/");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final data = {
      'nickname': nickname,
      'salary': salary,
      'week_work': week_work,
      'day_work': day_work,
      'job': job,
      'annual': annual,
      'sex': sex,
      'age': age
    };
    final response = await http.put(url, body: json.encode(data), headers: headers);

    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || jsonData == null) {
      // Error handling
    } else {
      print(jsonData);
      await helper.updateUser(jsonData['id'], jsonData['nickname'], jsonData['salary'], jsonData['week_work'], jsonData['day_work'], jsonData['job'],
          jsonData['annual'], jsonData['sex'], jsonData['age']);
    }
  }

  @override
  void initState() {
    id = widget.currentUser!.id;
    nickname = widget.currentUser!.nickname;
    _controllers[0].text = widget.currentUser!.nickname;
    salary = widget.currentUser!.salary.toString();
    _controllers[1].text = widget.currentUser!.salary.toString();
    salStr = salToWon(widget.currentUser!.salary.toString());
    week_work = widget.currentUser!.week_work.toString();
    _controllers[2].text = widget.currentUser!.week_work.toString();
    day_work = widget.currentUser!.day_work.toString();
    _controllers[3].text = widget.currentUser!.day_work.toString();
    job = widget.currentUser!.job.split('/')[1];
    print(job);
    selectedJob = widget.currentUser!.job.split('/')[0];
    print(selectedJob);
    _controllers[4].text = widget.currentUser!.job;
    annual = widget.currentUser!.annual;
    _controllers[5].text = widget.currentUser!.annual;
    sex = widget.currentUser!.sex;
    _controllers[6].text = widget.currentUser!.sex.toString();
    age = widget.currentUser!.age;
    _controllers[7].text = widget.currentUser!.age;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: ListView(
            children: [
              Container(
                width: 375,
                height: 811,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 72, bottom: 40),
                decoration: BoxDecoration(
                    color: Styles.blueGrey
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 327,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '내 정보 수정하기',
                        style: Styles.fTitleStyle.copyWith(color: Styles.blueColor, fontSize: 16),
                      ),
                    ),
                    const Gap(20),
                    // 닉네임
                    SizedBox(
                      width: 327,
                      height: 42,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white
                        ),
                        child: TextFormField(
                          controller: _controllers[0],
                          inputFormatters: [
                            FilteringTextInputFormatter(
                              RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                              allow: true,
                            )
                          ],
                          onChanged: (value) {
                            nickname = value;
                          },
                          onSaved: (value) {
                            nickname = value;
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 8, left: 18),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Styles.subBlueColor,
                                  )
                              ),
                              hintText: '닉네임',
                              hintStyle: Styles.titleStyle.copyWith(color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                    const Gap(12),
                    // 월급
                    SizedBox(
                      width: 327,
                      height: 42,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white
                        ),
                        child: TextFormField(
                          controller: _controllers[1],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyTextInputFormatter(
                                locale: 'ko',
                                decimalDigits: 0,
                                symbol: ''
                            )
                          ],
                          onChanged: (value) {
                            salary = value;
                            setState(() {
                              salStr = salToWon(value);
                            });
                          },
                          onSaved: (value) {
                            salary = value;
                          },
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Styles.subBlueColor,
                                  )
                              ),
                              hintText: '100,000',
                              hintStyle: Styles.titleStyle.copyWith(color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                    const Gap(6),
                    // 원
                    SizedBox(
                      width: 327,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(salStr, style: Styles.fEnableStyle.copyWith(color: Styles.blueColor), textAlign: TextAlign.end,),
                          Text('원', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor), textAlign: TextAlign.end,)
                        ],
                      ),
                    ),
                    const Gap(14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 일주일 근무일
                        SizedBox(
                          width: 327,
                          height: 42,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white
                            ),
                            child: TextFormField(
                              controller: _controllers[2],
                              onChanged: (value) {
                                week_work = value;
                              },
                              onSaved: (value) {
                                week_work = value;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  suffixText: week_work!.isEmpty ? '' : '일',
                                  prefixText: '일주일 근무 일',
                                  prefixStyle: Styles.titleStyle.copyWith(color: Styles.blueColor),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Styles.subBlueColor,
                                      )
                                  ),
                                  hintText: '일',
                                  hintStyle: Styles.titleStyle.copyWith(color: Colors.grey)
                              ),
                            ),
                          ),
                        ),
                        const Gap(15),
                        // 하루 근무시간
                        SizedBox(
                          width: 327,
                          height: 42,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white
                            ),
                            child: TextFormField(
                              controller: _controllers[3],
                              onChanged: (value) {
                                day_work = value;
                              },
                              onSaved: (value) {
                                day_work = value;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  suffixText: day_work!.isEmpty ? '' : '시간',
                                  prefixText: '하루 근무시간',
                                  prefixStyle: Styles.titleStyle.copyWith(color: Styles.blueColor),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Styles.subBlueColor,
                                      )
                                  ),
                                  hintText: '시간',
                                  hintStyle: Styles.titleStyle.copyWith(color: Colors.grey)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Gap(12),
                    Column(
                      children: [
                        // 업종/직무
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white
                          ),
                          width: 327,
                          height: 42,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white, // Background color
                            ),
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
                                        SizedBox(
                                          height: 20,
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
                                                  Text(categoryList.job1ByIndex[index], style: selectedJob == categoryList.job1ByIndex[index] ? Styles.titleStyle.copyWith(color: Colors.black) :  Styles.titleStyle.copyWith(color: Colors.grey),),
                                                  IconButton(
                                                      onPressed: () {
                                                        selectedJob = categoryList.job1ByIndex[index];
                                                        showModalBottomSheet(
                                                            context: context,
                                                            shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                                            ),
                                                            builder: (BuildContext bbContext) {
                                                              return Column(
                                                                children: [
                                                                  const Gap(40),
                                                                  SizedBox(
                                                                    height: 30,
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
                                                                  const Gap(28),
                                                                  SizedBox(
                                                                    height: 260,
                                                                    width: AppLayout.getSize(context).width,
                                                                    child: ListView(
                                                                      scrollDirection: Axis.vertical,
                                                                      children: List.generate(categoryList.job2ByIndex[selectedJob]!.length, (index) => Container(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                        width: AppLayout.getSize(bContext).width,
                                                                        height: 260/7,
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(categoryList.job2ByIndex[selectedJob]![index], style: job != categoryList.job2ByIndex[selectedJob]![index] ? Styles.titleStyle.copyWith(color: Colors.grey):Styles.titleStyle.copyWith(color: Colors.black)),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    job = categoryList.job2ByIndex[selectedJob]![index];
                                                                                  });
                                                                                  Navigator.pop(bbContext);
                                                                                  Navigator.pop(bContext);
                                                                                },
                                                                                icon: job != categoryList.job2ByIndex[selectedJob]![index] ? const Icon(Icons.check_circle, color: Colors.grey,) : const Icon(Icons.check_circle, color: Colors.black,))
                                                                          ],
                                                                        ),
                                                                      )
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            }
                                                        );
                                                      },
                                                      icon: Icon(Icons.check_circle, color: selectedJob == categoryList.job1ByIndex[index] ? Colors.black : Colors.grey,))
                                                ],
                                              ),
                                            )
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(job == '' ? '업종/직무' : job, style: job == '' ? Styles.fTextStyle.copyWith(color: Colors.grey) : Styles.fTextStyle.copyWith(color: Colors.black)),
                                Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                              ],
                            ),
                          ),
                        ),  // 업종/직무
                        const Gap(12),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white
                          ),
                          width: 327,
                          height: 42,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white, // Background color
                            ),
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
                                        LayoutBuilder(
                                          builder: (BuildContext bc, BoxConstraints bcs) {
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
                                                      style: annual == categoryList.yearByIndex[index+1] ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            annual = categoryList.yearByIndex[index+1];
                                                          });
                                                          Navigator.pop(bc);
                                                        },
                                                        icon: Icon(
                                                          Icons.check_circle,
                                                          color: annual == categoryList.yearByIndex[index+1] ? Colors.black : Colors.grey,))
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  annual.isEmpty ? '연차' : annual,
                                  style: annual == '' ? Styles.fTextStyle.copyWith(color: Colors.grey) : Styles.fTextStyle.copyWith(color: Colors.black),
                                ),
                                Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                              ],
                            ),
                          ),
                        ),  // 연차
                        const Gap(15),
                        SizedBox(
                          width: 327,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white
                                ),
                                width: 159,
                                height: 42,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white, // Background color
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                        ),
                                        builder: (BuildContext bContext) {
                                          return SizedBox(
                                            height: 179,
                                            child: Column(
                                              children: [
                                                const Gap(40),
                                                LayoutBuilder(
                                                  builder: (BuildContext bc, BoxConstraints bcs) {
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
                                                              style: sex == index+1 ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                            IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    sex = index+1;
                                                                  });
                                                                  Navigator.pop(bc);
                                                                },
                                                                icon: Icon(
                                                                  Icons.check_circle,
                                                                  color: sex == index+1 ? Colors.black : Colors.grey,))
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(categoryList.sexByIndex[sex], style: sex != 0 ? Styles.fTextStyle.copyWith(color: Colors.black) :Styles.fTextStyle.copyWith(color: Colors.grey),),
                                      Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                    ],
                                  ),
                                ),
                              ),  // 성별
                              const Gap(9),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white
                                ),
                                width: 159,
                                height: 42,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white, // Background color
                                  ),
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
                                              LayoutBuilder(
                                                builder: (BuildContext bc, BoxConstraints bcs) {
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
                                                            style: age == categoryList.ageByIndex[index+1] ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  age = categoryList.ageByIndex[index+1];
                                                                });
                                                                Navigator.pop(bc);
                                                              },
                                                              icon: Icon(
                                                                Icons.check_circle,
                                                                color: age == categoryList.ageByIndex[index+1] ? Colors.black : Colors.grey,)
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        age.isEmpty ? '연령' : age,
                                        style: age != '' ? Styles.fTextStyle.copyWith(color: Colors.black):Styles.fTextStyle.copyWith(color: Colors.grey),),
                                      Icon(Icons.arrow_drop_down, color: Styles.blueColor,)
                                    ],
                                  ),
                                ),
                              ),  // 연령
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(213),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Styles.blueColor
                      ),
                      width: 327,
                      height: 43,
                      child: TextButton(
                        onPressed: () {
                          validate();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => MainScreen()),
                          // );
                        },
                        child: Text('완료', style: Styles.fTextStyle.copyWith(fontSize: 16, color: Styles.blueGrey),),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
