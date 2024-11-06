import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mbl/app/app.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/app/view/widgets/text_box.dart';
import 'package:mbl/app/view/widgets/theme_button.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/core/utils/custom_form_validator.dart';
import 'package:mbl/feature/auth/presentation/changeNotifier/authNotifier.dart';
import 'package:mbl/feature/items/presentation/changeNotifier/item_notifier.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  var canSubmit = false;


  late StreamController<String> _nameStreamController;
  late StreamController<String> _descriptionStreamController;


  final nameFocus = FocusNode();
  final descriptionFocus = FocusNode();


  final nameController = TextEditingController();
  final descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _nameStreamController = StreamController<String>.broadcast();
    _descriptionStreamController = StreamController<String>.broadcast();


    nameController.addListener(() {
      _nameStreamController.sink.add(
        nameController.text.trim(),
      );
      validateInputs();
    });


    descriptionController.addListener(() {
      _descriptionStreamController.sink.add(
        descriptionController.text.trim(),
      );
      validateInputs();
    });

  }

  @override
  void dispose() {
    super.dispose();
    _descriptionStreamController.close();
    _nameStreamController.close();
    nameFocus.dispose();
    descriptionFocus.dispose();
  }

  void validateInputs() {

    final nameError = CustomFormValidation.errorUsernameMessage(
      nameController.text.trim(),
      'Name is required',
    );


    final descriptionError = CustomFormValidation.errorUsernameMessage(
      descriptionController.text.trim(),
      'Description is required',
    );


    setState(() {
      canSubmit =
          nameError.isEmpty &&
              descriptionError.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.white,),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    TextBody(
                        'Create an Item',
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(4.h),
                    TextSmall('Fill the form below to create an item',fontSize: 13.sp,),
                    Gap(30.h),
                    TextBody(
                      'Name',
                      fontSize: 14.sp,
                      color: AppColors.textColor,
                    ),
                    StreamBuilder<String>(
                      stream: _nameStreamController.stream,
                      builder: (context, snapshot) {
                        return InputField(
                          fieldFocusNode: nameFocus,
                          label: 'Enter item name',
                          validationColor: snapshot.data == null
                              ? AppColors.white
                              : CustomFormValidation.getColor(
                            snapshot.data,
                            nameFocus,
                            CustomFormValidation.errorMessage(
                              snapshot.data,
                              'Enter item name',
                            ),
                          ),
                          controller: nameController,
                          placeholder: 'Enter item name',
                          validationMessage:
                          CustomFormValidation.errorMessage(
                            snapshot.data,
                            'Item name is required',
                          ),
                        );
                      },
                    ),
                    Gap(8.h),
                    TextBody(
                      'Description',
                      fontSize: 14.sp,
                      color: AppColors.textColor,
                    ),
                    Gap(8.h),
                    StreamBuilder<String>(
                      stream: _descriptionStreamController.stream,
                      builder: (context, snapshot) {
                        return InputField(
                          label: 'Description',
                          fieldFocusNode: descriptionFocus,
                          textInputType: TextInputType.text,
                          validationColor: snapshot.data == null
                              ? AppColors.white
                              : CustomFormValidation.getColor(
                            snapshot.data,
                            descriptionFocus,
                            CustomFormValidation
                                .errorUsernameMessage(
                              snapshot.data,
                              'Desription is required',
                            ),
                          ),
                          validationMessage:
                          CustomFormValidation.errorUsernameMessage(
                            snapshot.data,
                            'Description is required',
                          ),
                          controller: descriptionController,
                          placeholder: 'Item description ',
                        );
                      },
                    ),
                  ],
                ),
              ),
              BusyButton(
                disabled: !canSubmit,
                  title: 'Create Item',
                  onTap: (){
                  di<ItemNotifier>().createItem(context,
                      name: nameController.text.trim(),
                      description: descriptionController.text.trim());
                  }

              )
            ],
          ),
        ),
      ),
    );
  }
}
