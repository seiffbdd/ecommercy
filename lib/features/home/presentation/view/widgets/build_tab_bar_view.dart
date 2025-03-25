import 'package:e_commercy/features/home/presentation/view/widgets/build_custom_scroll_view.dart';
import 'package:flutter/material.dart';

class BuildTabBarView extends StatelessWidget {
  const BuildTabBarView({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: tabController,
      children: [
        BuildCustomScrollView(),
        BuildCustomScrollView(),
        BuildCustomScrollView(),
        BuildCustomScrollView(),
        BuildCustomScrollView(),
        BuildCustomScrollView(),
        BuildCustomScrollView(),
      ],
    );
  }
}
