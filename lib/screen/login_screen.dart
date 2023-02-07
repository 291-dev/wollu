import 'dart:convert';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:wollu/screen/main_screen.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:wollu/util/category_list.dart';
import 'package:wollu/util/db_helper.dart';
import '../entity/User.dart';
import '../my_painter.dart';
import 'package:http/http.dart' as http;

import 'main_origin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CategoryList categoryList = CategoryList();
  final _globalKeys = <GlobalKey>[
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  Future<bool> validate() async {
    if (nickname == null || nickname!.isEmpty) {
      Scrollable.ensureVisible(_globalKeys[0].currentContext!, duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
      return false;
    }

    if (salary == null || salary!.isEmpty) {
      Scrollable.ensureVisible(_globalKeys[1].currentContext!, duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
      return false;
    } else {
      salary = salary!.replaceAll(',', '');
    }

    if (week_work == null || day_work == null || week_work!.isEmpty || day_work!.isEmpty) {
      Scrollable.ensureVisible(_globalKeys[2].currentContext!, duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
      return false;
    }

    var tempJob = '';
    if (job.isNotEmpty) {
      tempJob = '$selectedJob/$job';
    }

    var tempAn = '';
    if (annual != '연차') {
      tempAn = annual;
    }

    var tempS = 0;
    if (sex != 0) {
      tempS = sex;
    }

    var tempAge = '';
    if (age != '연령') {
      tempAge = age;
    }

    print('$nickname $salary $week_work $day_work $tempJob $tempAn $tempS $tempAge');
    final success = await callApi(
        nickname!, int.parse(salary!), int.parse(week_work!), int.parse(day_work!), tempJob, tempAn, tempS, tempAge
    );
    if (success) {
      return true;
    } else {
      return false;
    }
  }

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

  DBHelper helper = DBHelper();

  final _scrollController = ScrollController();
  var offset = 0.0;
  String? nickname;
  String? salary;
  String? week_work;
  String? day_work;
  String job = '';
  String annual = '';
  var sex = 0;
  String age = '';
  bool nickError = false;
  String errorMsg = '에러문구';
  String salaryToWon = '';
  bool workError = false;
  String workErrorMsg = '에러문구';
  String selectedJob = '';
  var isLoading = false;
  User? currentUser;

  Future<bool> callApi(String nickname, int salary, int week_work, int day_work, String job, String annual, int sex, String age) async {
    final url = Uri.parse("http://3.35.111.171:80/users/");
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
        await helper.add(
            jsonData['id'],
            jsonData['nickname'],
            jsonData['salary'],
            jsonData['week_work'],
            jsonData['day_work'],
            jsonData['job'],
            jsonData['annual'],
            jsonData['sex'],
            jsonData['age']);
        setState(() {
          currentUser = User(
            id: jsonData['id'],
            nickname: jsonData['nickname'],
              salary: jsonData['salary'],
              week_work: jsonData['week_work'],
              day_work: jsonData['day_work'],
              job: jsonData['job'],
              annual: jsonData['annual'],
              sex: jsonData['sex'],
              age: jsonData['age']
          );
        });
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

  Future<dynamic> check() async {
    final user = await helper.get();
    if (user.isEmpty) {
      return false;
    } else {
      return user.last;
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    check().then((isExistUser) => {
      if (isExistUser is User) {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => Main(currentUser: isExistUser,))))
      } else {
        setState(() {
          isLoading = false;
        }),
        _scrollController.addListener(() {
          setState(() {
            offset = _scrollController.offset;
          });
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    key: _globalKeys[0],
                    width: size.width,
                    height: 111,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Styles.blueGrey
                      ),
                    ),
                  ),  // 첫 화면 위 공백
                  Container(
                    color: Styles.blueGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Gap(20),
                            SizedBox(
                              width: 7,
                              height: 7,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Styles.blueColor
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                    width: 1,
                                    height: offset > 808 ? 808 : offset,
                                    child: CustomPaint(
                                      painter: MyPainter(),
                                    )
                                ),
                                const SizedBox(
                                  width: 1,
                                  height: 808,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.grey
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),  // 파란선
                        const Gap(7),
                        SizedBox(
                          height: 833,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('step 1/4', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor),),
                              const Gap(9),
                              Text('닉네임을 설정해주세요.',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Styles.black02
                                ),
                              ),
                              const Gap(28),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: 313,
                                        height: 42,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.7),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0.0,
                                                  offset: const Offset(0,1),
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white
                                          )
                                        ),
                                      ),
                                      Container(
                                        width: 313,
                                        height: 62,
                                        child: TextFormField(
                                          maxLength: 12,
                                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                                              hintText: '월급도둑',
                                              hintStyle: Styles.titleStyle.copyWith(color: Colors.grey)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(7),
                                  if (nickError)
                                    Row(
                                      children: [
                                        const Gap(14),
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/error.png')
                                                )
                                            ),
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(errorMsg, style: TextStyle(
                                            fontSize: 10,
                                            color: Styles.error
                                        ),)
                                      ],
                                    )
                                ],
                              )
                            ],
                          ),
                        ),  // 메인
                      ],
                    ),
                  ),  // 닉네임
                  Container(
                    color: Styles.blueGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  key: _globalKeys[1],
                                  width: 1,
                                  height: 25,
                                  child: const DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.grey
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 1,
                                    height: offset > 808 ? (offset - 808) > 25 ? 25 : (offset - 808) : 0,
                                    child: CustomPaint(
                                      painter: MyPainter(),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 7,
                              height: 7,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: offset > 833 ? Styles.blueColor : Colors.grey
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                const SizedBox(
                                  width: 1,
                                  height: 808,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.grey
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 1,
                                    height: offset > 833 ? (offset - 833) > 833 ? 833 : (offset - 833) : 0,
                                    child: CustomPaint(
                                      painter: MyPainter(),
                                    )
                                ),
                              ],
                            )
                          ],
                        ),  // 파란선
                        const Gap(7),
                        SizedBox(
                          height: 833,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('step 2/4', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor),),
                              const Gap(9),
                              Text('월급을 알려주세요.',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Styles.black02
                                ),
                              ),
                              const Gap(28),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 313,
                                    height: 42,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.7),
                                              blurRadius: 5.0,
                                              spreadRadius: 0.0,
                                              offset: const Offset(0,1),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white
                                      ),
                                      child: TextFormField(
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
                                            salaryToWon = salToWon(value);
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
                                  const Gap(7),
                                  SizedBox(
                                    width: 310,
                                    height: 20,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(salaryToWon, style: Styles.fEnableStyle.copyWith(color: Styles.blueColor), textAlign: TextAlign.end,),
                                        Text('원', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor), textAlign: TextAlign.end,)
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),  // 메인
                      ],
                    ),
                  ),  // 월급
                  Container(
                    color: Styles.blueGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  key: _globalKeys[2],
                                  width: 1,
                                  height: 25,
                                  child: const DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.grey
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 1,
                                    height: offset > 1641 ? (offset - 1641) > 25 ? 25 : (offset - 1641) : 0,
                                    child: CustomPaint(
                                      painter: MyPainter(),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 7,
                              height: 7,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: offset > 1666 ? Styles.blueColor : Colors.grey
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                const SizedBox(
                                  width: 1,
                                  height: 808,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.grey
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 1,
                                    height: offset > 1666 ? (offset - 1666) > 808 ? 808 : (offset - 1666) : 0,
                                    child: CustomPaint(
                                      painter: MyPainter(),
                                    )
                                ),
                              ],
                            )
                          ],
                        ),  // 파란선
                        const Gap(7),
                        SizedBox(
                          height: 833,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('step 3/4', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor),),
                              const Gap(9),
                              Text('근무 정보를 알려주세요.',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Styles.black02
                                ),
                              ),
                              const Gap(28),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 313,
                                    height: 42,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.7),
                                              blurRadius: 5.0,
                                              spreadRadius: 0.0,
                                              offset: const Offset(0,1),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white
                                      ),
                                      child: TextFormField(
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
                                            suffixText: '일',
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
                                  SizedBox(
                                    width: 313,
                                    height: 42,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.7),
                                              blurRadius: 5.0,
                                              spreadRadius: 0.0,
                                              offset: const Offset(0,1),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white
                                      ),
                                      child: TextFormField(
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
                                  ),
                                  const Gap(7),
                                  if (workError)
                                    Row(
                                      children: [
                                        const Gap(14),
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/error.png')
                                                )
                                            ),
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(workErrorMsg, style: TextStyle(
                                            fontSize: 10,
                                            color: Styles.error
                                        ),
                                        ),
                                      ],
                                    )
                                ],
                              )
                            ],
                          ),
                        ),  // 메인
                      ],
                    ),
                  ),  // 근무정보
                  Container(
                    color: Styles.blueGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                const SizedBox(
                                  width: 1,
                                  height: 25,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.grey
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 1,
                                    height: offset > 2474 ? (offset - 2474) > 25 ? 25 : (offset - 2474) : 0,
                                    child: CustomPaint(
                                      painter: MyPainter(),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 7,
                              height: 7,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: offset > 2499 ? Styles.blueColor : Colors.grey
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                              height: 833,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Styles.blueGrey
                                ),
                              ),
                            )
                          ],
                        ),  // 파란선
                        const Gap(7),
                        SizedBox(
                          height: 833,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('step 4/4', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor),),
                              const Gap(9),
                              Text('추가 정보를 알려주세요.',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Styles.black02
                                ),
                              ),
                              const Gap(8),
                              Text('해당 정보는 통계 집계 시, 사용됩니다.',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Styles.black02
                                ),
                              ),
                              const Gap(28),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.7),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0,
                                            offset: const Offset(0,1),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white
                                    ),
                                    width: 313,
                                    height: 42,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
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
                                                            Text(categoryList.job1ByIndex[index], style: Styles.titleStyle.copyWith(color: Colors.grey),),
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
                                                                icon: const Icon(Icons.check_circle, color: Colors.grey,))
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
                                  const Gap(15),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.7),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0,
                                            offset: const Offset(0,1),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white
                                    ),
                                    width: 313,
                                    height: 42,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.7),
                                                blurRadius: 5.0,
                                                spreadRadius: 0.0,
                                                offset: const Offset(0,1),
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.white
                                        ),
                                        width: 152,
                                        height: 42,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
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
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.7),
                                                blurRadius: 5.0,
                                                spreadRadius: 0.0,
                                                offset: const Offset(0,1),
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.white
                                        ),
                                        width: 152,
                                        height: 42,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
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
                                  const Gap(200),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Styles.blueColor
                                    ),
                                    width: 327,
                                    height: 42,
                                    child: TextButton(
                                      onPressed: () {
                                        validate().then((valid) => {
                                          if (valid) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Main(
                                                currentUser: currentUser!,
                                              )),
                                            ),
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)))
                                          }
                                        });

                                      },
                                      child: Text('완료', style: Styles.fTextStyle.copyWith(fontSize: 16, color: Styles.blueGrey),),
                                    ),
                                  ) // 완료버튼
                                ],
                              )
                            ],
                          ),
                        ),  // 메인
                      ],
                    ),
                  ),  // 추가정보
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        elevation: 0,
        backgroundColor: Styles.blueGrey,
        onPressed: () {},
        child: Image.asset('assets/down_arrow.png',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
