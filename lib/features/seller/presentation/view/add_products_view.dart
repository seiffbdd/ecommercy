import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/components.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/widgets/auth_button.dart';
import 'package:e_commercy/core/widgets/custom_text_form_field.dart';
import 'package:e_commercy/features/auth/presentation/view/widgets/center_progress_indicator_with_stack.dart';
import 'package:e_commercy/features/seller/presentation/view/widgets/custom_dropdown_button_form_field.dart';
import 'package:e_commercy/features/seller/presentation/view_model/add_product_cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddProductsView extends StatefulWidget {
  const AddProductsView({super.key});

  @override
  State<AddProductsView> createState() => _AddProductsViewState();
}

class _AddProductsViewState extends State<AddProductsView> {
  String? _selectedCategory;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _imageController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _imageController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Product'),
        backgroundColor: AppColors.kPrimaryBackgroundColor,
      ),
      body: BlocListener<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is AddProductFailed) {
            Components.showSnackBar(
              context,
              text: state.errMessage,
              color: AppColors.redColor,
            );
          }
          if (state is AddProductSuccess) {
            Components.showSnackBar(
              context,
              text: 'Product Added Successfully',
              color: AppColors.greenColor,
            );
            context.pop();
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxHeight10,
                      CustomTextFormField(
                        controller: _imageController,
                        hintText: 'Paste your products image link',
                        labelText: 'Image Link',
                      ),
                      sizedBoxHeight30,
                      CustomTextFormField(
                        controller: _titleController,
                        hintText: 'Enter product title',
                        labelText: 'Product Title',
                      ),
                      sizedBoxHeight30,
                      CustomTextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        hintText: 'Enter product description',
                        labelText: 'Description',
                        maxLines: 5,
                      ),
                      sizedBoxHeight30,

                      SizedBox(
                        width: ScreenSize.screenWidth(context) * 0.6,
                        child: CustomDropdownButtonFormField(
                          hintText: 'Select Category',
                          onChanged: (value) {
                            _selectedCategory = value!;
                          },
                          items: AddProductCubit.categories,
                        ),
                      ),
                      sizedBoxHeight30,

                      CustomTextFormField(
                        controller: _priceController,
                        prefixIcon: Icon(Icons.attach_money_outlined),
                        hintText: '0.00',
                        labelText: 'Price',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field is required';
                          } else if (num.tryParse(value) == null) {
                            return 'Please enter a valid price';
                          } else if (num.parse(value) <= 0) {
                            return 'Price must be greater than zero';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedBoxHeight30,

                      AuthButton(
                        text: 'Add Product',
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _selectedCategory != null) {
                            final ProductModel product = ProductModel(
                              title: _titleController.text,
                              price: num.parse(_priceController.text),
                              category:
                                  Category.fromString(
                                    stringCategory: _selectedCategory!,
                                  )!,
                              image: _imageController.text,
                              description: _descriptionController.text,
                            );
                            context.read<AddProductCubit>().addProduct(
                              product: product,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                if (state is AddProductLoading) {
                  return CenterProgressIndicatorWithStack();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
