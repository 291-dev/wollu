import 'dart:convert';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wollu/entity/user_provider.dart';
import 'package:wollu/screen/main_screen.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import '../entity/User.dart';
import '../my_painter.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
  final _job1ByIndex = [
    '경영·사무',
    '마케팅·광고·홍보',
    'IT·인터넷',
    '디자인',
    '무역·유통',
    '영업·고객상담',
    '서비스',
    '연구개발·설계',
    '생산·제조',
    '교육',
    '건설',
    '의료',
    '미디어',
    '전문·특수직'
  ];
  final _job2ByIndex = {
    '경영·사무': ['기획·전략·경영', '사무·총무·법무', '인사·노무·교육', '경리·회계·결산', '재무·세무·IR', '사무보조·문서작성', '비서·안내'],
    '마케팅·광고·홍보': ['마케팅·광고·분석', '홍보·PR', '전시·컨벤션'],
    'IT·인터넷': ['웹프로그래머', '응용프로그래머', '시스템프로그래머', 'DBA·데이터베이스', '네트워크·서버·보안', '웹기획·PM', '웹마케팅', 'HTML·퍼블리싱·UI개발', '웹디자인', 'QA·테스터·검증', '게임', 'ERP·시스템분석·설계', 'IT·디자인·컴퓨터강사', '동영상제작·편집', '빅데이터·AI', '소프트웨어·하드웨어'],
    '디자인': ['그래픽디자인·CG', '출판·편집디자인', '제품·산업디자인', '캐릭터·애니메이션', '광고·시각디자인', '의류·패션·잡화디자인', '전시·공간디자인', '디자인기타'],
    '무역·유통': ['해외영업·무역영업', '수출입·무역사무', '구매·자재', '상품기획·MD', '유통·물류·재고', '배송·택배·운송', '운전·기사', '화물·중장비'],
    '영업·고객상담': ['제품·서비스영업', '금융·보험영업', 'IT·솔루션·기술영업', '영업관리·지원·영업기획', '광고영업', '법인영업', '판매·서빙·매장관리', '단순홍보·회원관리', '아운바운드TM', '고객상담·인바운드', 'CS관리·강의'],
    '서비스': ['요리·영양·제과제빵·바리스타', '설치·정비·A/S', '시설·보안·경비·안전', '레저·스포츠', '여행·항공·숙박', '뷰티·미용·애완', '주차·세차·주유', '청소·가사·육아', '이벤트·웨딩·도우미'],
    '연구개발·설계': ['자동차·조선·기계', '반도체·디스플레이', '화학·에너지·환경', '전기·전자·제어', '기계설계·CAD·CAM', '통신기술·네트워크구축', '바이오·제약·식품'],
    '생산·제조': ['생산관리·공정관리·품질관리', '생산·제조·설비·조립', '포장·가공', '섬유·의류·패션'],
    '교육': ['유치원·보육교사', '초중고·특수학교', '대학교수·강사·행정직', '보습학원·입시학원', '학원상담·관리·운영', '학습지·과외·방문교사', '외국어교육', '자격증·기술·전문교육', '교재기획·교수설계'],
    '건설': ['건축·설계·인테리어', '시공·현장·감리·공무', '토목·조경·도시·측량', '전기·소방·통신·안전', '환경·플랜트', '부동산·중개·분양·경매'],
    '의료': ['의사·치과·한의사', '약사·한약사·약무보조', '간호사', '간호조무사', '의료기사', '사무·원무·코디', '수의사·수의간호', '의료직기타'],
    '미디어': ['감독·연출·PD', '영상·사진·촬영', '광고제작·카피·CF', '아나운서·리포터·성우', '기자', '작가·시나리오', '연예·엔터테인먼트', '인쇄·출판·편집', '영화·배급', '음악·음향', '공연·전시·무대·스텝'],
    '전문·특수직': ['경영분석·컨설턴트', '채권·심사·보험·보상', '회계·세무·CPA', '노무·헤드헌터·직업상담', '리서치·통계·설문', '도서관사서', '법률·특허·상표', '외국어·번역·통역', '보안·경호', '사회복지·요양보호·자원봉사', '연구소·R&D']
  };
  final _yearByIndex = [
    '연차',
    '1년차',
    '2-3년차',
    '4-6년차',
    '7-9년차',
    '10-15년차',
    '16-19년차',
    '20년차 이상',
    '선택 안 함'
  ];
  final _ageByIndex = [
    '연령',
    '19-22세',
    '23-25세',
    '26-29세',
    '30-32세',
    '33-36세',
    '37-39세',
    '40세 이상',
    '선택 안 함'
  ];
  final _sexByIndex = [
    '성별',
    '남성',
    '여성',
    '선택 안 함'
  ];
  final _scrollController = ScrollController();
  var offset = 0.0;
  String? nickname;
  String? salary;
  String? week_work;
  String? day_work;
  String job = '';
  var annual = 0;
  var sex = 0;
  var age = 0;
  bool nickError = false;
  String nickErrorMsg = '에러문구';
  String salaryToWon = '';
  bool workError = false;
  String workErrorMsg = '에러문구';
  String selectedJob = '';

  static void callApi() async {
    var response = await http.get(Uri.parse("http://3.35.111.171:80/test"));
    print(json.decode(utf8.decode(response.bodyBytes)));
  }
  static void getPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return Scaffold(
      body: ListView(
        controller: _scrollController,
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
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
                                    hintText: '우미관',
                                    hintStyle: Styles.titleStyle.copyWith(color: Colors.grey)
                                  ),
                                ),
                              ),
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
                                Text(nickErrorMsg, style: TextStyle(
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
                                                        Text(_job1ByIndex[index], style: Styles.titleStyle.copyWith(color: Colors.grey),),
                                                        IconButton(
                                                            onPressed: () {
                                                              selectedJob = _job1ByIndex[index];
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
                                                                            children: List.generate(_job2ByIndex[selectedJob]!.length, (index) => Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                              width: AppLayout.getSize(bContext).width,
                                                                              height: 260/7,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(_job2ByIndex[selectedJob]![index], style: job != _job2ByIndex[selectedJob]![index] ? Styles.titleStyle.copyWith(color: Colors.grey):Styles.titleStyle.copyWith(color: Colors.black)),
                                                                                  IconButton(
                                                                                      onPressed: () {
                                                                                        setState(() {
                                                                                          job = _job2ByIndex[selectedJob]![index];
                                                                                        });
                                                                                        Navigator.pop(bbContext);
                                                                                        Navigator.pop(bContext);
                                                                                      },
                                                                                      icon: job != _job2ByIndex[selectedJob]![index] ? const Icon(Icons.check_circle, color: Colors.grey,) : const Icon(Icons.check_circle, color: Colors.black,))
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
                                                              _yearByIndex[index+1],
                                                              style: annual == index+1 ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                            IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    annual = index+1;
                                                                  });
                                                                  Navigator.pop(bc);
                                                                },
                                                                icon: Icon(
                                                                  Icons.check_circle,
                                                                  color: annual == index+1 ? Colors.black : Colors.grey,))
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
                                      _yearByIndex[annual],
                                      style: annual == 0 ? Styles.fTextStyle.copyWith(color: Colors.grey) : Styles.fTextStyle.copyWith(color: Colors.black),
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
                                                                _sexByIndex[index+1],
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
                                        Text(_sexByIndex[sex], style: sex != 0 ? Styles.fTextStyle.copyWith(color: Colors.black) :Styles.fTextStyle.copyWith(color: Colors.grey),),
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
                                                                _ageByIndex[index+1],
                                                                style: age == index+1 ? Styles.titleStyle.copyWith(color: Colors.black) : Styles.titleStyle.copyWith(color: Colors.grey),),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      age = index+1;
                                                                    });
                                                                    Navigator.pop(bc);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.check_circle,
                                                                    color: age == index+1 ? Colors.black : Colors.grey,)
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
                                          _ageByIndex[age],
                                          style: age != 0 ? Styles.fTextStyle.copyWith(color: Colors.black):Styles.fTextStyle.copyWith(color: Colors.grey),),
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
                                  print(nickname);
                                  print(salary);
                                  print(week_work);
                                  print(day_work);
                                  print(job);
                                  print(_yearByIndex[annual]);
                                  print(_sexByIndex[sex]);
                                  print(_ageByIndex[age]);
                                  callApi();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  );
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
