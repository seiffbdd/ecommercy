import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BuildTabBar extends StatelessWidget {
  const BuildTabBar({
    super.key,
    required TabController tabController,
    required List<Widget> tabs,
  }) : _tabController = tabController,
       _tabs = tabs;

  final TabController _tabController;
  final List<Widget> _tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      padding: EdgeInsets.only(bottom: 12.0),
      indicatorPadding: EdgeInsets.symmetric(horizontal: -12.0),
      dividerColor: AppColors.kPrimaryBackgroundColor,
      dividerHeight: 10.0,
      isScrollable: true,
      indicator: BoxDecoration(
        color: AppColors.blueColor,

        borderRadius: BorderRadius.circular(40.0),
      ),
      labelStyle: Styles.textStyle18.copyWith(color: Colors.white),
      unselectedLabelStyle: Styles.textStyle18,
      tabs: _tabs,
    );
  }
}
