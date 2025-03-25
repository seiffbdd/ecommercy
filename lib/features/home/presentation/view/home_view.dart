import 'package:e_commercy/core/cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/cache_helper.dart';
import 'package:e_commercy/core/utils/components.dart';
import 'package:e_commercy/core/utils/strings.dart';

import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/home/presentation/view_model/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:e_commercy/features/home/presentation/view/widgets/build_tab_bar.dart';
import 'package:e_commercy/features/home/presentation/view/widgets/build_tab_bar_view.dart';
import 'package:e_commercy/features/home/presentation/view/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    if (FirebaseAuth.instance.currentUser != null) {
      context.read<GetUserInfoCubit>().saveUserInfo(
        userId: FirebaseAuth.instance.currentUser!.uid,
      );
    }
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
          IconButton(
            onPressed: () {
              if (FirebaseAuth.instance.currentUser == null) {
                Components.showCustomDialog(
                  context,
                  onPressedCancelButton: () {
                    context.pop();
                  },
                  onPressedOkButton: () async {
                    await CacheHelper.prefs.setBool(Strings.isGuest, false);
                    if (!context.mounted) return;
                    context.go('/login');
                  },
                  title: 'Sign In',
                  content: 'You need to sign in first',
                  okButtonText: 'Sign In',
                  cancelButtonText: 'Cancel',
                );
              } else {}
            },
            icon: Icon(Icons.person, size: 30.0),
          ),
        ],
      ),
      drawer: FirebaseAuth.instance.currentUser == null ? null : CustomDrawer(),
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
