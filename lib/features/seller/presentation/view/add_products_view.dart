import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/widgets/auth_button.dart';
import 'package:e_commercy/core/widgets/custom_text_form_field.dart';
import 'package:e_commercy/features/home/presentation/view_model/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:e_commercy/features/seller/presentation/view/widgets/custom_dropdown_button_form_field.dart';
import 'package:flutter/material.dart';

class AddProductsView extends StatefulWidget {
  const AddProductsView({super.key});

  @override
  State<AddProductsView> createState() => _AddProductsViewState();
}

class _AddProductsViewState extends State<AddProductsView> {
  late String _selectedCategory;
  @override
  void initState() {
    super.initState();
    _selectedCategory = 'Select Category';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Product'),
        backgroundColor: AppColors.kPrimaryBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'Paste your products image link',
                  labelText: 'Image Link',
                  autovalidateMode: AutovalidateMode.disabled,
                ),
                sizedBoxHeight30,
                CustomTextFormField(
                  hintText: 'Enter product name',
                  labelText: 'Product Name',
                  autovalidateMode: AutovalidateMode.disabled,
                ),
                sizedBoxHeight30,
                CustomTextFormField(
                  hintText: 'Enter product desciription',
                  labelText: 'Desciription',
                  maxLines: 5,
                  autovalidateMode: AutovalidateMode.disabled,
                ),
                sizedBoxHeight30,

                CustomDropdownButtonFormField(
                  labelText: 'Select Category',
                  onChanged: (value) {
                    _selectedCategory = value!;
                  },
                  items: GetAllProductsCubit.categories,
                ),
                sizedBoxHeight30,

                CustomTextFormField(
                  prefixIcon: Icon(Icons.attach_money_outlined),
                  hintText: '0.00',
                  labelText: 'Price',
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
                sizedBoxHeight30,

                AuthButton(text: 'Add Product', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
