import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thalj/core/utils/commons.dart';
import 'package:thalj/features/auth/presentation/components/text_filed.dart';
import 'package:thalj/features/home/domain/repository.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/toast.dart';
import '../../../../../core/widgets/custom_app_bar_product_info.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../bloc/sendOffer-bloc/sendOffer_bloc.dart';
import '../../bloc/sendOffer-bloc/sendOffer_event.dart';
import '../../bloc/sendOffer-bloc/sendOffer_state.dart';

class SendOffer extends StatefulWidget {
  const SendOffer({super.key, required this.id});
  final String id;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<SendOffer> createState() => _SendOfferState();
}

class _SendOfferState extends State<SendOffer> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => SendOfferBloc(
          homeRepository: context.read<HomeRepository>()),
      child: _productDetailsView(),
    ));
  }

  Widget _productDetailsView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 860.h,
            child: Form(
              key: SendOffer._formKey,
              child: Column(
                children: [
                  const CustomAppBar(
                    img: AppAssets.moka,
                    title: AppStrings.productDetails,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  BlocBuilder<SendOfferBloc, SendOfferState>(
                    builder: (context, state) {
                      return MyFormField(
                        controller: _nameController,
                        type: TextInputType.text,
                        hint: "الاسم ثلالثي",
                        maxLines: 1,
                        readonly: false,
                        title: AppStrings.productName,
                        vaild: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.vaildForm;
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  BlocBuilder<SendOfferBloc, SendOfferState>(
                    builder: (context, state) {
                      return MyFormField(
                        controller: _priceController,
                        type: TextInputType.number,
                        hint: "100",
                        maxLines: 1,
                        readonly: false,
                        title: AppStrings.price,
                        vaild: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.vaildForm;
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  BlocBuilder<SendOfferBloc, SendOfferState>(
                    builder: (context, state) {
                      return MyFormField(
                        controller: _phoneController,
                        type: TextInputType.phone,
                        hint: "xxx xxx xxxx",
                        maxLines: 1,
                        readonly: false,
                        title: AppStrings.number,
                        vaild: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.vaildForm;
                          }
                          if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return AppStrings.phoneNumber;
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  BlocConsumer<SendOfferBloc, SendOfferState>(
                    listener: (context, state) {
                      if (state.isSuccess) {
                        navigatePushReplacement(context: context, route: Routes.homeScreen);
                        showToast(
                            text: AppStrings.sendOfferSuccess,
                            state: ToastStates.success);
                      }
                    },
                    builder: (context, state) {
                      return state.isSubmitting
                          ? const CircularProgressIndicator.adaptive()
                          : CustomButton(
                              onPressed: () {
                                if (SendOffer._formKey.currentState!
                                    .validate()) {
                                  BlocProvider.of<SendOfferBloc>(context).add(
                                      SendOfferSubmitted(
                                         name: _nameController.text,
                                          phone:_phoneController.text,
                                          price:_priceController.text,
                                        id:widget.id,
                                      ));
                                }
                              },
                              text: AppStrings.send,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
