import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wollu/category_view.dart';
import 'package:wollu/circle_painter.dart';
import 'package:wollu/screen/login_screen.dart';
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

class Times {
  List<int> times = [];

  Times(this.times);
}

class Main extends StatefulWidget {
  User currentUser;
  Main({Key? key, required this.currentUser}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with WidgetsBindingObserver {
  // TotalTime
  var _totalTime = 0;
  // Timer to gathering each category's time
  Timer? timer;
  Timer? notificationTimer;
  User? currentUser;

  // Local notification
  final NavigationHistoryObserver historyObserver = NavigationHistoryObserver();

  DBHelper helper = DBHelper();
  // For data load
  var isLoading = false;
  // To control current running category
  var isRun = false;
  var latest = 1;
  var isRunOnce = false;
  // Categories which user selected
  var selected = [false, true, false, false, false, true, true, false];
  // Category List
  late List<DragAndDropList> _contents = [DragAndDropList(children: [DragAndDropItem(child: Container())])];
  // Dynamic List
  List<DragAndDropItem> _list = [];
  // DragAndDropItem Objects
  final List<DragAndDropItem> _itemList = [];
  // Categories
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
  // Main Pictures List
  final mainPictures = ['assets/x4not.png', 'assets/x4snack.png', 'assets/x4toilet.png', 'assets/x4wind.png', 'assets/x4internet.png', 'assets/x4smoke.png', 'assets/x4do.png', 'assets/x4prepare.png'];
  // Category Views
  final List<CategoryView> _views = [];
  // GlobalKey List
  final List<GlobalKey<CategoryViewState>> _keys = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];
  // Time List
  var times = [0, 0, 0, 0, 0, 0, 0, 0];

  // Center Image and ArcPainter
  final painter = ArcPainter();

  // Functions
  void getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      selected[0] = pref.getBool('0') == null ? false : true;
      selected[1] = pref.getBool('1') == null ? true : true;
      selected[2] = pref.getBool('2') == null ? false : true;
      selected[3] = pref.getBool('3') == null ? false : true;
      selected[4] = pref.getBool('4') == null ? false : true;
      selected[5] = pref.getBool('5') == null ? true : true;
      selected[6] = pref.getBool('6') == null ? true : true;
      selected[7] = pref.getBool('7') == null ? false : true;
    });
    // Get wollu data
    get().then((value) => {
      // Set Category List
      setList().then((value) => {
        timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          setState(() {
            _totalTime = _views[0].category.getTime()
                + _views[1].category.getTime()
                + _views[2].category.getTime()
                + _views[3].category.getTime()
                + _views[4].category.getTime()
                + _views[5].category.getTime()
                + _views[6].category.getTime()
                + _views[7].category.getTime();
          });
          painter.arcAngle = 2 * pi * (_totalTime/(60*60*widget.currentUser.day_work));
        }),
        setState(() {
          isLoading = false;
        })
      })
    });
  }
  Future<Times> get() async {
    DBHelper helper = DBHelper();
    final result = await helper.getWollu(widget.currentUser.id);
    if (result.isEmpty) {
      return Times(List.empty());
    } else {
      setState(() {
        times = result.sublist(2);
      });
      return Times(result.sublist(2));
    }
  }

  Future setList() async {
    for (int i=0; i<8; i++) {
      _views.add(
          CategoryView(
            key: _keys[i],
            category: categories[i],
            time: times[i],
            onTap: () {
              if (isRun) {
                // 그게 나일 때
                if (latest == i) {
                  setState(() {
                    isRun = false;
                    for (int j=0; j<8; j++) {
                      if (j == i) {
                        continue;
                      } else {
                        if (_keys[j].currentState != null) {
                          _keys[j].currentState!.active = true;
                        }
                      }
                    }
                    times[i] = _keys[i].currentState!.time;
                    saveAsIndex(i);
                  });
                }
                // 아무도 실행 중이 아닐 때
              } else {
                setState(() {
                  isRun = true; // 실행 중이다.
                  latest = i; // 내가
                  for (int j=0; j<8; j++) {
                    if (j == i) {
                      continue;
                    } else {
                      if (_keys[j].currentState != null) {
                        _keys[j].currentState!.active = false;
                      }
                    }
                  }
                });
              }
              setState(() {
                isRunOnce = true;
              });
            },
          )
      );
      _views[i].category.setTime(times[i]);
      _itemList.add(
          DragAndDropItem(
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Column(
                children: [
                  Container(
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFEF3900),
                    ),
                    child: Image.asset('assets/trash.png', width: 24, height: 24),
                  ),
                  const Gap(10),
                ],
              ),
              onDismissed: (dir) {
                setState(() {
                  _list.remove(_itemList[i]);
                  selected[i] = false;
                  setPref(i, false);
                });
              },
              child: _views[i],
            ),
          )
      );
      if (selected[i]) {
        _list.add(_itemList[i]);
      }
    }
    _contents = List.generate(1, (index) {
      return DragAndDropList(
          children: _list,
          contentsWhenEmpty: Column(
            children: [
              const Gap(20),
              Center(child: Text("카테고리를 추가해주세요.", style: Styles.fEnableStyle.copyWith(color: Styles.grey03),),),
            ],
          )
      );
    });
  }
  Future<dynamic> setPref(int i, bool b) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (b) {
      pref.setBool(i.toString(), b);
    } else {
      pref.remove(i.toString());
    }
  }
  Future<bool> save() async {
    DBHelper helper = DBHelper();

    for (int i=0; i<8; i++) {
      if (_keys[i].currentState != null) {
        times[i] = _keys[i].currentState!.time;
      }
    }

    try {
      final id = await helper.addWollu(widget.currentUser.id, _totalTime,
          times[0], times[1], times[2], times[3], times[4], times[5], times[6], times[7]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveAsIndex(int index) async {
    DBHelper helper = DBHelper();

      if (_keys[index].currentState != null) {
        times[index] = _keys[index].currentState!.time;
      }
    

    try {
      final id = await helper.addWollu(widget.currentUser.id, _totalTime,
          times[0], times[1], times[2], times[3], times[4], times[5], times[6], times[7]);
      return true;
    } catch (e) {
      return false;
    }
  }
  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
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
    currentUser = widget.currentUser;
    // Data loading
    isLoading = true;
    // Local notification
    LocalNotification.init();
    LocalNotification.requestPermission();
    // Get pref and selected categories data
    getPref();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  var message = "";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        notificationTimer!.cancel();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        notificationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
          if (isRun) {
            LocalNotification.notification(categories[latest].name, _views[latest].category.getTime());
          }
        });
        break;
      case AppLifecycleState.detached:
        break;
    }
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    notificationTimer?.cancel();
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: _body(context)
    );
  }

  Widget _body(BuildContext scaffold) {
    final size = AppLayout.getSize(scaffold);
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: size.width > 430 ? 430 : size.width, // 375
            height: size.height,
            decoration: BoxDecoration(
                color: Styles.blueGrey
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                // TopLeft, TopRight Navigation Buttons and TotalTime Text
                Container(
                  width: size.width > 430 ? 430 : size.width, // 327
                  height: 84,
                  child: Stack(
                    children: [
                      Positioned(
                        left: -8,
                        child: IconButton(
                          iconSize: 39,
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StatScreen(currentUser: widget.currentUser)));
                          },
                          icon: Image.asset('assets/x4stat.png'),
                        ),
                      ),
                      Positioned(
                        right: -8,
                        child: IconButton(
                          iconSize: 39,
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            // Must be fixed Main passes user data to SetScreen
                            check().then((value) {
                              if (value is User) {
                                currentUser = value;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SetScreen(currentUser: currentUser)));
                              }
                            });
                          },
                          icon: Image.asset(
                            'assets/x4set.png',
                          ),
                        ),
                      ),
                      Positioned(
                        left: size.width > 430 ? 430/2 - 81 - 24: size.width/2 - 81 - 24,
                        top: 32,
                        child: Container(
                          width: 162,
                          height: 55,
                          child: Center(
                            child: Text(
                              intToTimeLeft(_totalTime), // _totalTime
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 46,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.blueColor
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(25),
                // Center Image and ArcPainter
                Container(
                    width: 300,
                    height: 340,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Stack(
                          children: [
                            CustomPaint(
                              painter: CirclePainter(),
                            ),
                            CustomPaint(
                              painter: painter,
                            )
                          ],
                        ),
                        Positioned(
                          child: Image.asset(
                            isRunOnce ? mainPictures[latest] : 'assets/default.png',
                            width: 275,
                            height: 275,
                          ),
                        ),
                        Visibility(
                          visible: isRunOnce,
                          child: Positioned(
                            top: 265,
                            width: 85,
                            height: 85,
                            child: IconButton(
                              icon: Image.asset(
                                isRun ? 'assets/stopBtn.png' : 'assets/play.png',
                              ),
                              onPressed: isRun ? () {
                                setState(() {
                                  isRun = false;
                                  _keys[latest].currentState!.stop();
                                  for (int i=0; i<8; i++) {
                                    if (_keys[i].currentState != null) {
                                      _keys[i].currentState!.active = true;
                                    }
                                  }
                                });
                                saveAsIndex(latest);
                              } :
                                  () {
                                setState(() {
                                  isRun = true;
                                  _keys[latest].currentState!.run();
                                  for (int i=0; i<8; i++) {
                                    if (_keys[i].currentState != null && latest != i) {
                                      _keys[i].currentState!.active = false;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                const Gap(20),
                // Category List
                Container(
                  width: size.width > 430 ? 430 : size.width,
                  height: _contents[0].children.length * 52 - 10 < 0 ? 52 : _contents[0].children.length * 52 - 10,
                  child: DragAndDropLists(
                    children: _contents,
                    onItemReorder: _onItemReorder,
                    onListReorder: (a, b) {},
                    lastListTargetSize: 0,
                    horizontalAlignment: MainAxisAlignment.center,
                    verticalAlignment: CrossAxisAlignment.center,
                    contentsWhenEmpty: Center(child: Text("카테고리를 추가해주세요."),),
                  ),
                ),
                const Gap(10),
                // Category Add Button
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFE3E4EC)
                  ),
                  width: 312,
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
                              return SizedBox(
                                height: 467,
                                child: Column(
                                  children: [
                                    const Gap(50),
                                    StatefulBuilder(
                                      builder: (BuildContext bc, StateSetter bottomState) {
                                        return Container(
                                          height: 20*15,
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
                                                            } else {
                                                              setPref(index, false);
                                                              _list.remove(
                                                                  _itemList[index]
                                                              );
                                                            }
                                                          });
                                                        });
                                                      },
                                                      icon: selected[index] ? Image.asset('assets/checkOn.png') : Image.asset('assets/checkOff.png')
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
                                      width: size.width - 60,
                                      height: 43,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(bContext);
                                        },
                                        child: Text('적용하기', style: Styles.fTextStyle.copyWith(fontSize: 16, color: Styles.blueGrey),),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      }
                    },
                  ),
                ),
                const Gap(40),
                Container(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: // End Button
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Styles.blueColor
                        ),
                        width: size.width > 430 ? 430 : size.width,
                        height: 43,
                        child: TextButton(
                          onPressed: () {
                            save().then((success) => {
                              if (success) {
                                notificationTimer?.cancel(),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ResultScreen(currentUser: widget.currentUser,))
                                )
                              }
                            });
                          },
                          child: Text('계산하기', style: Styles.fTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white)),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
