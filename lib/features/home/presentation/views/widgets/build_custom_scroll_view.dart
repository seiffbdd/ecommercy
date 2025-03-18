import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/home/presentation/cubits/get_products_cubit/get_products_cubit.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/horizontal_products_list_view.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/product_card.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/title_and_see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildCustomScrollView extends StatelessWidget {
  const BuildCustomScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: TitleAndSeeAllButton()),
        SliverToBoxAdapter(
          child: SizedBox(
            height: ScreenSize.screenHeight(context) / 4,
            child: HorizontalProductsListView(),
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(
            color: AppColors.kPrimaryBackgroundColor,
            thickness: 10.0,
          ),
        ),

        BlocBuilder<GetProductsCubit, GetProductsState>(
          builder: (context, state) {
            if (state is GetProductsLoading) {
              return SliverToBoxAdapter(
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is GetProductsFailed) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(state.errMessage, style: Styles.textStyle18),
                ),
              );
            } else if (state is GetProductsSuccess) {
              return SliverGrid.builder(
                itemCount: state.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    image: state.products[index].image,
                    title: state.products[index].title,
                    price: state.products[index].price,
                    rating: state.products[index].rating,
                  );
                },
              );
            } else {
              return SliverToBoxAdapter(child: const SizedBox());
            }
          },
        ),
      ],
    );
  }
}
