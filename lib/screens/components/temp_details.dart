import 'package:flutter/material.dart';
import 'package:tesla_animate/constants.dart';
import 'package:tesla_animate/home_controller.dart';
import 'package:tesla_animate/screens/components/temp_btn.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _homeController.isCoolSelected,
                  title: "Cool",
                  svgSrc: "assets/icons/coolShape.svg",
                  press: _homeController.updateCoolSelectTab,
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                TempBtn(
                  isActive: !_homeController.isCoolSelected,
                  title: "Heat",
                  svgSrc: "assets/icons/heatShape.svg",
                  press: _homeController.updateCoolSelectTab,
                  activeColor: redColor,
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                ),
              ),
              Text(
                "29" + "\u2103",
                style: TextStyle(
                  fontSize: 86,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "CURRENT TEMPERATURE",
            style: TextStyle(),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inside".toUpperCase(),
                  ),
                  Text(
                    "20 " + "\u2103",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inside".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    "35 " + "\u2103",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white54,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
