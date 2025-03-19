import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/home/presentation/cubits/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildTabBar extends StatelessWidget {
  const BuildTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (index) {
        context.read<GetAllProductsCubit>().selectedCategory =
            GetAllProductsCubit.categories[index];
      },
      controller: tabController,
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
      tabs: GetAllProductsCubit.tabs,
    );
  }
}
