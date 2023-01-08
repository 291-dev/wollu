import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _job1ByIndex = [
    '개발',
    '교육',
    '금융/재무',
    '기획/경영',
    '데이터',
    '디자인',
    '마케팅/시장조사'
  ];
  final _yearByIndex = [
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
    '남성',
    '여성',
    '선택 안 함'
  ];
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return Scaffold(
      body: ListView(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: 7,
                        height: 7,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Styles.blueColor
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                      height: 833,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Styles.blueColor
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
                              Text('에러문구', style: TextStyle(
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
                    SizedBox(
                      width: 1,
                      height: 25,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Styles.blueColor
                        ),
                      ),
                    ),
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
                    SizedBox(
                      width: 1,
                      height: 833,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Styles.blueColor
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
                                  SizedBox(
                                    width: 280,
                                    child: Flex(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      direction: Axis.horizontal,
                                      children: [
                                        Text('에러문구', style: TextStyle(
                                            fontSize: 10,
                                            color: Styles.error
                                        ),),
                                        Text('만원', style: Styles.fEnableStyle.copyWith(color: Styles.blueColor), textAlign: TextAlign.end,)
                                      ],
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
          ),  // 월급
          Container(
            color: Styles.blueGrey,
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 1,
                      height: 25,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Styles.blueColor
                        ),
                      ),
                    ),
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
                    SizedBox(
                      width: 1,
                      height: 833,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Styles.blueColor
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
                              Text('에러문구', style: TextStyle(
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
                    SizedBox(
                      width: 1,
                      height: 25,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Styles.blueColor
                        ),
                      ),
                    ),
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
                                    shape: RoundedRectangleBorder(
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
                                            LayoutBuilder(
                                              builder: (BuildContext bc, BoxConstraints bcs) {
                                                return Flex(
                                                    direction: Axis.vertical,
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: List.generate(7, (index) => Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                                    width: AppLayout.getSize(context).width,
                                                    height: 260/7,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(_job1ByIndex[index], style: Styles.titleStyle.copyWith(color: Colors.grey),),
                                                        IconButton(
                                                            onPressed: () {

                                                        },
                                                            icon: Icon(Icons.check_circle, color: Colors.grey,))
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
                                  Text('업종/직무', style: Styles.fTextStyle.copyWith(color: Colors.grey),),
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
                                    shape: RoundedRectangleBorder(
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
                                                        Text(_yearByIndex[index], style: Styles.titleStyle.copyWith(color: Colors.grey),),
                                                        IconButton(
                                                            onPressed: () {

                                                            },
                                                            icon: Icon(Icons.check_circle, color: Colors.grey,))
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
                                  Text('연차', style: Styles.fTextStyle.copyWith(color: Colors.grey),),
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
                                        shape: RoundedRectangleBorder(
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
                                                            Text(_sexByIndex[index], style: Styles.titleStyle.copyWith(color: Colors.grey),),
                                                            IconButton(
                                                                onPressed: () {

                                                                },
                                                                icon: Icon(Icons.check_circle, color: Colors.grey,))
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
                                      Text('성별', style: Styles.fTextStyle.copyWith(color: Colors.grey),),
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
                                                            Text(_ageByIndex[index], style: Styles.titleStyle.copyWith(color: Colors.grey),),
                                                            IconButton(
                                                                onPressed: () {

                                                                },
                                                                icon: Icon(Icons.check_circle, color: Colors.grey,))
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
                                      Text('연령', style: Styles.fTextStyle.copyWith(color: Colors.grey),),
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
                              onPressed: () {  },
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
