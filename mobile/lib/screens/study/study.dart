import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_garden/configs/AppConfig.dart';
import 'package:e_garden/screens/study/review.dart';
import 'package:e_garden/screens/study/study.provider.dart';
import 'package:e_garden/utils/light_color.dart';
import 'package:e_garden/widgets/custom_buton_component.dart';
import 'package:e_garden/widgets/custom_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'learn.dart';

class StudyScreen extends StatefulWidget {
  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookModel>(
        builder: (_, model, __) => SafeArea(
              child: Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          child: CarouselSlider.builder(
                            itemBuilder: (context, index) =>
                                listClassImage(index, model.getGrade()),
                            options: CarouselOptions(
                                viewportFraction: 0.8,
                                initialPage: model.getGrade(),
                                autoPlay: false,
                                enlargeCenterPage: true,
                                aspectRatio: 2,
                                onPageChanged: (index, reason) {
                                  model.setGrade(index);
                                }),
                            itemCount: classImage.length,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: classImage.map((url) {
                            int index = classImage.indexOf(url);
                            return Container(
                              width: (model.getGrade() == index)
                                  ? SizeConfig.safeBlockHorizontal * 2.25
                                  : SizeConfig.safeBlockHorizontal * 1.5,
                              height: (model.getGrade() == index)
                                  ? SizeConfig.safeBlockHorizontal * 2.25
                                  : SizeConfig.safeBlockHorizontal * 1.5,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: model.getGrade() == index
                                    ? LightColors().bookColor[index]
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        CustomButton(
                            borderColor:
                                LightColors().bookColor[model.getGrade()],
                            backgroundColor: LightColors()
                                .buttonLightColor[model.getGrade()],
                            child: TileWidget(
                              text: "Learn",
                              color: LightColors().bookColor[model.getGrade()],
                              leftText: "15 Units",
                              rightText: "95%",
                            ),
                            height: SizeConfig.safeBlockHorizontal * 30,
                            width: SizeConfig.safeBlockHorizontal * 75,
                            shadowColor:
                                LightColors().bookColor[model.getGrade()],
                            onPressed: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 400),
                                      child: LearnScreen()),
                                )),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        CustomButton(
                            borderColor:
                                LightColors().bookColor[model.getGrade()],
                            backgroundColor: LightColors()
                                .buttonLightColor[model.getGrade()],
                            child: TileWidget(
                              color: LightColors().bookColor[model.getGrade()],
                              text: "Review",
                              leftText: "23 Units",
                              rightText: "37%",
                            ),
                            height: SizeConfig.blockSizeVertical * 15,
                            width: SizeConfig.safeBlockHorizontal * 75,
                            shadowColor:
                                LightColors().bookColor[model.getGrade()],
                            onPressed: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 400),
                                      child: ReviewScreen()),
                                )),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  listClassImage(int index, int _current) {
    return Container(
        decoration: BoxDecoration(
          color: (index == _current)
              ? LightColors().bookColor[_current]
              : Color(0xFFDEF0FD),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 12,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: SizeConfig.safeBlockHorizontal * 80,
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 8),
        child: Image.asset(classImage[index]));
  }

  List<String> classImage = [
    'assets/images/class/class1.png',
    'assets/images/class/class2.png',
    'assets/images/class/class3.png',
    'assets/images/class/class4.png',
    'assets/images/class/class5.png',
  ];
}
