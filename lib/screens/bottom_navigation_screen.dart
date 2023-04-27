import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bottomnavigation/screens/ScreenOne.dart';
import 'package:flutter_bottomnavigation/screens/ScreenThree.dart';
import 'package:flutter_bottomnavigation/screens/ScreenTwo.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  //1 Создаем переменную для хранения индексной страницы
  var _bottomNavIndex = 0;

  //2 Создаем функцию списка с типом Widget, потому что в этом списке будут храниться виджеты других экранов навигации
  List<Widget> _screens() => [ScreenOne(), ScreenTwo()];

  //3 Создаем список иконок
  //3.1 Список иконок может состоять из набора иконок встроенной библиотеки Icons или CupertinoIcons
  List<IconData> _iconDataList = [
    Icons.home,
    Icons.account_circle_outlined,
    Icons.manage_search_sharp,
    Icons.message_outlined,
  ];
  List<String> _iconNamesDataList = ['Home', 'Profile', 'Search', 'Chat'];

  //3.1 Если по дизайну треубется подключить дизайнерскую иконку или кастомную (custom), то можно составить список с изображениями
  //В таком случае требуется установить библиотеку flutter_svg_provider для поддержки векторного формата иконок (SVG), чтобы не терялось качество изображений
  List<ImageIcon> _iconImageDataList = [
    ImageIcon(
      Svg('assets/user.svg', color: Colors.white),
    ),
    ImageIcon(
      Svg('assets/home.svg', color: Colors.white),
    ),
    ImageIcon(
      Svg('assets/search.svg', color: Colors.white),
    ),
    ImageIcon(
      Svg('assets/envelope.svg', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return null!;
        },
        child: SafeArea(
            child: Scaffold(
          //Вызываем параметр bottomNavigationBar: у Scaffold, но перед этим ставим библиотеку AnimatedBottomNavigationBar
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            //задаем параметр количества иконок, ссылаясь на наш список _iconDataList или _iconImageDataList
            itemCount: _iconDataList.length,
            //задаем активную вкладку
            activeIndex: _bottomNavIndex,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            onTap: (index) => setState(() => _bottomNavIndex = index),
            //строим вкладки tabbuilder
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isActive
                      ? Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.blueGrey[300],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _iconDataList[index],
                                //здесь меняется цвет иконок нижнего меню
                                color: Colors.white,
                                size: 20.0,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${_iconNamesDataList[index]}",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ))
                      : Icon(_iconDataList[index],
                          //здесь меняется цвет иконок нижнего меню
                          color: Colors.blueGrey[700],
                          size: 30.0),
                  //ImageIcon(_iconImageData[index].image),
                ],
              );
            },
            //Фоновый цвет панели нижней навигации
            backgroundColor: Colors.white,
            //определяем положение плавающей иконки и распределение иконок равномерно по центру
            gapLocation: GapLocation.center,
          ),
          //Добавляем плавающую кнопку, если нужно
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.blueGrey[700],
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScreenThree()));
              },
              child: Icon(
                Icons.wallet,
                color: Colors.white,
                size: 35,
              )),
          //Задаем отображение виджетов экранов в тело bottomNavigationBar
          body: _screens().elementAt(_bottomNavIndex),
        )));
  }
}
