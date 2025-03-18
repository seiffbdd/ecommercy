import 'package:e_commercy/features/home/presentation/views/widgets/build_custom_scroll_view.dart';
import 'package:flutter/material.dart';

class BuildTabBarView extends StatelessWidget {
  const BuildTabBarView({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        BuildCustomScrollView(),
        Text('cvdfvdf'),
        Text('cds'),
        Text('cvdfvdf'),
        Text('cds'),
        Text('cvdfvdf'),
        Text('cds'),
        Text('cvdfvdf'),
      ],
    );
  }
}
