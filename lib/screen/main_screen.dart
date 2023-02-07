import 'dart:async';
import 'dart:ui';

import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wollu/category_view.dart';
import 'package:wollu/circle_painter.dart';
import 'package:wollu/screen/result_screen.dart';
import 'package:wollu/screen/setting_screen.dart';
import 'package:wollu/screen/stat_screen.dart';
import 'package:wollu/util/app_layout.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:wollu/util/convert_time.dart';
import 'package:wollu/util/db_helper.dart';
import 'package:wollu/util/local_notification.dart';

import '../entity/User.dart';
import '../util/categories.dart';

class MainScreen extends StatefulWidget {
  User currentUser;
  MainScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var isRun = false;
  late Timer timer;
  var _totalTimer = 0;
  var _totalTimerStr = '00:00';
  var latest = 2;
  var categoryHeight = 156.0;
  final mainPictures = [
    'assets/mainNot.png',
    'assets/snacks.png',
    'assets/mainToilet.png',
    'assets/mainWind.png',
    'assets/mainInternet.png',
    'assets/mainSmoke.png',
    'assets/mainSome.png',
    'assets/mainPrepare.png'
  ];
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
  Future<bool> save() async {
    DBHelper helper = DBHelper();
    List<int> _list = [0, 0, 0, 0, 0, 0, 0, 0];

    for (int i=0; i<8; i++) {
      if (_keys[i].currentState != null) {
        _list[i] = _keys[i].currentState!.time;
      }
    }

    print('save $_list');

    try {
      final id = await helper.addWollu(widget.currentUser.id, _totalTimer,
          _list[0], _list[1], _list[2], _list[3], _list[4], _list[5], _list[6], _list[7]);
      print(id);
      return true;
    } catch (e) {
      return false;
    }
  }
  final List<GlobalKey<CategoryViewState>> _keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];
  // late final List<CategoryView> _views = [
  //   CategoryView(
  //       key: _keys[0],
  //       category: Category(image: 'assets/nothing.svg', name: '업무 없음'),
  //       onTap: () {
  //         // 누군가가 실행 중
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 0) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 0) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true; // 실행 중이다.
  //             latest = 0; // 내가
  //             for (int i=0; i<8; i++) {
  //               if (i == 0) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  //   CategoryView(
  //     key: _keys[1],
  //     category: Category(image: 'assets/coffee.svg', name: '커피/간식 먹기'),
  //       onTap: () {
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 1) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 1) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true;
  //             latest = 1;
  //             for (int i=0; i<8; i++) {
  //               if (i == 1) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  //   CategoryView(
  //     key: _keys[2],
  //     category: Category(image: 'assets/toilet.svg', name: '화장실 가기'),
  //       onTap: () {
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 2) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 2) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true;
  //             latest = 2;
  //             for (int i=0; i<8; i++) {
  //               if (i == 2) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  //   CategoryView(
  //     key: _keys[3],
  //     category: Category(image: 'assets/wind.svg', name: '바깥바람쐬기'),
  //       onTap: () {
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 3) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 3) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true;
  //             latest = 3;
  //             for (int i=0; i<8; i++) {
  //               if (i == 3) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  //   CategoryView(
  //     key: _keys[4],
  //     category: Category(image: 'assets/internet.svg', name: '인터넷 서핑하기'),
  //       onTap: () {
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 4) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 4) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true;
  //             latest = 4;
  //             for (int i=0; i<8; i++) {
  //               if (i == 4) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  //   CategoryView(
  //     key: _keys[5],
  //     category: Category(image: 'assets/smoke.svg', name: '담배 피우기'),
  //       onTap: () {
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 5) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 5) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true;
  //             latest = 5;
  //             for (int i=0; i<8; i++) {
  //               if (i == 5) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  //   CategoryView(
  //     key: _keys[6],
  //     category: Category(image: 'assets/dosomething.svg', name: '딴짓하기'),
  //       onTap: () {
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 6) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 6) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true;
  //             latest = 6;
  //             for (int i=0; i<8; i++) {
  //               if (i == 6) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  //   CategoryView(
  //     key: _keys[7],
  //     category: Category(image: 'assets/prepare.svg', name: '이직준비'),
  //       onTap: () {
  //         if (isRun) {
  //           // 그게 나일 때
  //           if (latest == 7) {
  //             setState(() {
  //               isRun = false;
  //               for (int i=0; i<8; i++) {
  //                 if (i == 7) {
  //                   continue;
  //                 } else {
  //                   if (_keys[i].currentState != null) {
  //                     _keys[i].currentState!.active = true;
  //                   }
  //                 }
  //               }
  //             });
  //
  //           }
  //           // 아무도 실행 중이 아닐 때
  //         } else {
  //           setState(() {
  //             isRun = true;
  //             latest = 7;
  //             for (int i=0; i<8; i++) {
  //               if (i == 7) {
  //                 continue;
  //               } else {
  //                 if (_keys[i].currentState != null) {
  //                   _keys[i].currentState!.active = false;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       },
  //   ),
  // ];
  Future<dynamic> setPref(int i, bool b) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (b) {
      pref.setBool(i.toString(), b);
    } else {
      pref.remove(i.toString());
    }
  }
  final List<DragAndDropItem> _itemList = [
    DragAndDropItem(child: Container()),
    DragAndDropItem(child: Container()),
    DragAndDropItem(child: Container()),
    DragAndDropItem(child: Container()),
    DragAndDropItem(child: Container()),
    DragAndDropItem(child: Container()),
    DragAndDropItem(child: Container()),
    DragAndDropItem(child: Container()),
  ];
  List<DragAndDropItem> _list = [];
  late List<DragAndDropList> _contents;
  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      final index = _itemList.indexOf(movedItem);
      final time = _keys[index].currentState!.time;
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
      _keys[index].currentState!.time = time;
      _keys[index].currentState!.setTime(time);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = _contents.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }
  final painter = ArcPainter();
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
  Timer? saveTimer;
  DBHelper helper = DBHelper();
  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose');
    timer.cancel();
    saveTimer?.cancel();
    super.dispose();
  }

  Future<dynamic> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      selected[0] = pref.getBool('0') == null ? false : true;
      if (selected[0]) {
        _list.add(
            _itemList[0]
        );
      }
      selected[1] = pref.getBool('1') == null ? true : true;
      if (selected[1]) {
        _list.add(
            _itemList[1]
        );
      }
      selected[2] = pref.getBool('2') == null ? false : true;
      if (selected[2]) {
        _list.add(
            _itemList[2]
        );
      }
      selected[3] = pref.getBool('3') == null ? false : true;
      if (selected[3]) {
        _list.add(
            _itemList[3]
        );
      }
      selected[4] = pref.getBool('4') == null ? false : true;
      if (selected[4]) {
        _list.add(
            _itemList[4]
        );
      }
      selected[5] = pref.getBool('5') == null ? true : true;
      if (selected[5]) {
        _list.add(
            _itemList[5]
        );
      }
      selected[6] = pref.getBool('6') == null ? true : true;
      if (selected[6]) {
        _list.add(
            _itemList[6]
        );
      }
      selected[7] = pref.getBool('7') == null ? false : true;
      if (selected[7]) {
        _list.add(
            _itemList[7]
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    // timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    //   setState(() {
    //     _totalTimer = _views[0].category.getTime()
    //     + _views[1].category.getTime()
    //     + _views[2].category.getTime()
    //     + _views[3].category.getTime()
    //     + _views[4].category.getTime()
    //     + _views[5].category.getTime()
    //     + _views[6].category.getTime()
    //     + _views[7].category.getTime();
    //
    //     _totalTimerStr = intToTimeLeft(_totalTimer);
    //
    //     painter.setAngle(_totalTimer/(60*60*widget.currentUser.day_work));
    //
    //     // for (int i=0; i<8; i++) {
    //     //       if (selected[i]) {
    //     //         final time = _keys[i].currentState!.time;
    //     //         _keys[i].currentState!.setTime(time);
    //     //       }
    //     //     }
    //   });
    // });
    LocalNotification.init();
    for (int i=0; i<8; i++) {
      // _itemList[i] = DragAndDropItem(
      //     child: Dismissible(
      //         key: UniqueKey(),
      //         direction: DismissDirection.endToStart,
      //         background: Column(
      //           children: [
      //             Container(
      //               height: 42,
      //               width: 312,
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(8),
      //                 color: const Color(0xFFEF3900),
      //               ),
      //               child: Image.asset('assets/trash.png', width: 24, height: 24,),
      //             ),
      //             const Gap(10),
      //           ],
      //         ),
      //         onDismissed: (dir) {
      //           setState(() {
      //             _list.remove(_itemList[i]);
      //             selected[i] = false;
      //             if (isRun && latest == i) {
      //               isRun = false;
      //               for (int index=0; index<8; index++) {
      //                 if (index == i) {
      //                   continue;
      //                 } else {
      //                   if (_keys[index].currentState != null) {
      //                     _keys[index].currentState!.active = true;
      //                   }
      //                 }
      //               }
      //             }
      //           });
      //         },
      //         child: _views[i]
      //     ),
      // );
    }
    // for (int i=0;i<8;i++) {
    //   if (selected[i]) {
    //     _list.add(
    //       _itemList[i]
    //     );
    //   }
    // }
    _contents = List.generate(1, (index) {
      return DragAndDropList(
          children: _list
      );
    });
  }
  
  Future<dynamic> setTimeData(dynamic data) async {
    if (data is List<int>) {
      setState(() {
        for (int i=0; i<8; i++) {
          if (_keys[i].currentState != null) {
            _keys[i].currentState!.time = data[2+i];
            _keys[i].currentState!.setTime(data[2+i]);
          }
        }
      });
    }
  }

  Future<dynamic> get() async {
    DBHelper helper = DBHelper();
    final result = await helper.getWollu(widget.currentUser.id);
    if (result.isEmpty) {
      return false;
    } else {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Styles.blueGrey,
        body: _body(context)
      )
    );
  }

  Widget _body(BuildContext scaffold) {
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StatScreen(currentUser: widget.currentUser,)));
                      },
                      icon: Image.asset(
                        'assets/stat.png',
                        width: 48,
                        height: 39,
                      )
                  ),
                  IconButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SetScreen()));
                      },
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
              height: 46,
              child: Center(
                child: Text(
                  _totalTimerStr,
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 46,
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
                            width: 237,
                            height: 244,
                            child: CustomPaint(
                              painter: CirclePainter(),
                            )
                        ),
                        SizedBox(
                            width: 237,
                            height: 244,
                            child: CustomPaint(
                              painter: painter,
                            )
                        ),
                      ],
                    ),
                    Positioned(
                      child: Image.asset(
                        mainPictures[latest],
                        width: 237,
                        height: 244,
                      ),
                    ),
                    Visibility(
                      visible: isRun,
                      child: Positioned(
                        top: 230,
                        width: 75,
                        height: 75,
                        child: IconButton(
                          icon: Image.asset(
                            'assets/play.png',
                          ),
                          onPressed: () {
                            setState(() {
                              isRun = false;
                              _keys[latest].currentState!.stop();
                              for (int i=0; i<8; i++) {
                                if (_keys[i].currentState != null) {
                                  _keys[i].currentState!.active = true;
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
            ), // 센터
            const Gap(20),
            FutureBuilder(
                builder: ((context, snapshot) {
              return Container(
                  width: 323,
                  height: 156,
                  child: DragAndDropLists(
                    children: _contents,
                    onItemReorder: _onItemReorder,
                    onListReorder: _onListReorder,
                    lastItemTargetHeight: 42,
                    itemDecorationWhileDragging: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Styles.blueColor.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ]
                    ),
                    listDividerOnLastChild: true,
                    listDivider: Container(height: 1,decoration: BoxDecoration(color: Styles.blueColor),),
                    lastListTargetSize: 0,
                    horizontalAlignment: MainAxisAlignment.center,
                    verticalAlignment: CrossAxisAlignment.center,
                  )
              );
            }),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFE3E4EC)
              ),
              width: 327,
              height: 42,
              child: IconButton(
                icon: Icon(Icons.add, color: Styles.blueColor,),
                onPressed: () {
                  if (isRun) {
                    Fluttertoast.showToast(
                      msg: '실행중인 월루 카테고리를 종료해주세요.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  } else {
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
                                builder: (BuildContext bc, StateSetter bottomState) {
                                  return SizedBox(
                                    height: 250,
                                    child: ListView(
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
                                                  bottomState(() {
                                                    setState(() {
                                                      selected[index] = !selected[index];
                                                      if (selected[index]) {
                                                        setPref(index, true);
                                                        _list.add(
                                                            _itemList[index]
                                                        );
                                                        //_contents[0].children.add(_list.last);
                                                      } else {
                                                        // _contents[0].children.remove(
                                                        //     DragAndDropItem(
                                                        //         child: CategoryView(category: categories[index],)
                                                        //     )
                                                        // );
                                                        setPref(index, false);
                                                        _list.remove(
                                                            _itemList[index]
                                                        );
                                                      }
                                                    });
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
                                    ),
                                  );
                                },
                              ),
                              const Gap(34),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Styles.blueColor
                                ),
                                width: 327,
                                height: 42,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(bContext);
                                  },
                                  child: Text('적용하기', style: Styles.fTextStyle.copyWith(fontSize: 16, color: Styles.blueGrey),),
                                ),
                              )
                            ],
                          );
                        }
                    );
                  }
                },
              ),
            ),  // + 버튼
            const Gap(28),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Styles.blueColor
              ),
              width: 327,
              height: 43,
              child: TextButton(
                onPressed: () {
                  save().then((success) => {
                    if (success) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(currentUser: widget.currentUser,)))
                    }
                  });
                },
                child: Text('계산하기', style: Styles.fTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white)),
              ),
            ), // 계산하기 버튼
            const Gap(30)
          ],
        ),
      ],
    );
  }
}
