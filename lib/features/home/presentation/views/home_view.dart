import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/components.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/screen_size.dart';

import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:e_commercy/features/home/presentation/cubits/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/build_tab_bar.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/build_tab_bar_view.dart';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: GetAllProductsCubit.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text('ECommercy'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, size: 30.0),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.person, size: 30.0)),
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: BuildTabBar(tabController: _tabController),
            ),
            Expanded(child: BuildTabBarView(tabController: _tabController)),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: ScreenSize.screenWidth(context) * 0.6,
      backgroundColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxHeight30,
            Text('Hello profile name', style: Styles.textStyle25),
            sizedBoxHeight20,
            Divider(),
            sizedBoxHeight10,
            AuthButton(
              text: 'Start Selling',
              textStyle: Styles.textStyle16.copyWith(
                color: AppColors.whiteColor,
              ),
              onPressed: () {},
            ),
            sizedBoxHeight20,
            AuthButton(
              buttonColor: AppColors.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  sizedBoxWidth10,
                  Text('Logout', style: Styles.textStyle16),
                ],
              ),
              onPressed: () async {
                await Components.showCustomDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
