import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:wollu/util/categories.dart';
import 'package:wollu/util/convert_time.dart';

class CategoryView extends StatefulWidget {
  final Category category;
  final Function()? onTap;
  final int time;
  const CategoryView({Key? key, required this.category, this.onTap, required this.time}) : super(key: key);


  @override
  CategoryViewState createState() => CategoryViewState();
}

class CategoryViewState extends State<CategoryView> {
  var played = false;
  Timer? timer;
  var time = 0;
  var active = true;

  void stop() {
    setState(() {
      widget.category.togglePlay();
      played = false;
      timer?.cancel();
    });
  }

  void run() {
    setState(() {
      widget.category.togglePlay();
      played = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          time++;
          widget.category.setTime(time);
        });
      });
    });
  }

  void setTime(int time) {
    widget.category.setTime(time);
  }
  @override
  void initState() {
    // TODO: implement initState
    time = widget.time;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Category category = widget.category;

    return Column(
      children: [
        SizedBox(
          width: 327,
          height: 42,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: Row(
                children: [
                  SvgPicture.asset(category.image),
                  const Gap(4),
                  SizedBox(
                      width: 150,
                      child: Text(category.name)
                  ),
                  const Gap(45),
                  Container(
                      width: 43,
                      alignment: Alignment.centerRight,
                      child: Text(
                        intToTimeLeft(time),
                        style: played ? Styles.fEnableStyle.copyWith(color: Styles.blueColor) : Styles.fEnableStyle.copyWith(color: const Color(0xFFAAAAAA)),
                      )
                  ),
                  IconButton(
                    icon: played ? SvgPicture.asset('assets/stop.svg') : SvgPicture.asset('assets/play.svg'),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    onPressed: () {
                      widget.onTap!();
                      if (active) {
                        setState(() {
                          widget.category.togglePlay();
                          played = widget.category.played;

                          if (played) {
                            timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                              setState(() {
                                time++;
                                widget.category.setTime(time);
                              });
                            });
                          } else {
                            timer?.cancel();
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(10)
      ],
    );
  }
}
