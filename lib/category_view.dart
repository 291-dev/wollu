import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:wollu/util/categories.dart';

class CategoryView extends StatefulWidget {
  final Category category;
  const CategoryView({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  var played = false;

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
                borderRadius: BorderRadius.circular(4),
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
                  const Gap(50),
                  Text('00:00'),
                  IconButton(
                    icon: played ? SvgPicture.asset('assets/stop.svg') : SvgPicture.asset('assets/play.svg'),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    onPressed: () {
                      setState(() {
                        played = !played;
                      });
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
