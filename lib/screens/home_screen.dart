import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animate/constants.dart';
import 'package:tesla_animate/home_controller.dart';
import 'package:tesla_animate/screens/components/battery_status.dart';
import 'package:tesla_animate/screens/components/door_lock.dart';
import 'package:tesla_animate/screens/components/temp_details.dart';
import 'package:tesla_animate/screens/components/tesla_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _homeController = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0, 0.2),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.7, 1),
    );
  }

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.0, 0.5),
    );

    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.2, 0.4),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _homeController,
          _batteryAnimationController,
          _tempAnimationController,
        ]),
        builder: (context, snapshot) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigation(
              onTap: (index) {
                if (index == 1) {
                  _batteryAnimationController.forward();
                } else if (_homeController.selectedBottomTab == 1 &&
                    index != 1) {
                  _batteryAnimationController.reverse(from: 0.7);
                }
                if (index == 2) {
                  _tempAnimationController.forward();
                } else if (_homeController.selectedBottomTab == 2 &&
                    index != 2) {
                  _tempAnimationController.reverse(from: 4);
                }
                _homeController.onBottomNavigationTabChange(index);
              },
              selectedTab: _homeController.selectedBottomTab,
            ),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          "assets/icons/Car.svg",
                          width: double.infinity,
                        ),
                      ),
                    ),
                    //door locks
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _homeController.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      //Now we need to animate the lock
                      //once user click on it
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _homeController.isRightDoorLock,
                          press: _homeController.updateRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _homeController.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      //Now we need to animate the lock
                      //once user click on it
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _homeController.isLeftDoorLock,
                          press: _homeController.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _homeController.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.13
                          : constrains.maxHeight / 2,
                      //Now we need to animate the lock
                      //once user click on it
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _homeController.isBonnetLock,
                          press: _homeController.updateBonnetDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _homeController.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.17
                          : constrains.maxHeight / 2,
                      //Now we need to animate the lock
                      //once user click on it
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _homeController.isTruckLock,
                          press: _homeController.updateTruckDoorLock,
                        ),
                      ),
                    ),

                    //Battery
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        "assets/icons/Battery.svg",
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(constrains: constrains),
                      ),
                    ),

                    Positioned(
                      top: 60 * (1 - _animationTempShowInfo.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetails(homeController: _homeController),
                      ),
                    ),
                    Positioned(
                      right: -180 * (1 - _animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _homeController.isCoolSelected
                            ? Image.asset(
                                "assets/images/Cool_glow_2.png",
                                width: 200,
                                key: UniqueKey(),
                              )
                            : Image.asset(
                                "assets/images/Hot_glow_4.png",
                                width: 200,
                                key: UniqueKey(),
                              ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
