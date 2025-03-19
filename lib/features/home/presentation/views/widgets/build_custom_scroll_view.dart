import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/core/widgets/custom_circle_prgress_indicator.dart';
import 'package:e_commercy/features/home/presentation/cubits/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:e_commercy/features/home/presentation/cubits/get_new_arrivals_cubit/get_new_arrivals_cubit.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/all_products_sliver_grid.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/horizontal_products_list_view.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/title_and_see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildCustomScrollView extends StatefulWidget {
  const BuildCustomScrollView({super.key});

  @override
  State<BuildCustomScrollView> createState() => _BuildCustomScrollViewState();
}

class _BuildCustomScrollViewState extends State<BuildCustomScrollView> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllProductsCubit>().getAllProducts(
      category: context.read<GetAllProductsCubit>().selectedCategory,
    );
    context.read<GetNewArrivalsCubit>().getNewArrivalsProducts(
      category: context.read<GetAllProductsCubit>().selectedCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: TitleAndSeeAllButton()),
        SliverToBoxAdapter(
          child: SizedBox(
            height: ScreenSize.screenHeight(context) / 4,
            child: BlocBuilder<GetNewArrivalsCubit, GetNewArrivalsState>(
              builder: (context, state) {
                if (state is GetNewArrivalsLoading) {
                  return CustomCirclePrgressIndicator();
                } else if (state is GetNewArrivalsFailed) {
                  return Center(child: Text('Something went wrong'));
                } else if (state is GetNewArrivalsSuccess) {
                  return HorizontalProductsListView(products: state.products);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(
            color: AppColors.kPrimaryBackgroundColor,
            thickness: 10.0,
          ),
        ),

        BlocBuilder<GetAllProductsCubit, GetAllProductsState>(
          builder: (context, state) {
            if (state is GetAllProductsLoading) {
              return SliverToBoxAdapter(
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is GetAllProductsFailed) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(state.errMessage, style: Styles.textStyle18),
                ),
              );
            } else if (state is GetAllProductsSuccess) {
              return AllProductsSliverGrid(products: state.products);
            } else {
              return SliverToBoxAdapter(child: const SizedBox());
            }
          },
        ),
      ],
    );
  }
}
