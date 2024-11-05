import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mbl/app/view/app.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/app/view/widgets/theme_button.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/core/navigation/route_name.dart';
import 'package:mbl/feature/items/presentation/changeNotifier/item_notifier.dart';
import 'package:mbl/feature/items/presentation/widgets/item_widget.dart';
import 'package:provider/provider.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {

  void runbackground()async{
   await di<ItemNotifier>().getAllItems(context);
  }

  @override
  @override
  void initState() {
    runbackground();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<ItemNotifier>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 12.w,vertical: 20.h
            ),
          child: Column(
            children: [
              TextBody(
                  'All items will be listed below'
              ),
              Gap(20.h),
              myProvider.isItemsLoading
                  ? CircularProgressIndicator(color: AppColors.primaryColor,)
                  : myProvider.items.isEmpty
                  ? Expanded(child: Center(child: TextBody('No item, Create an Item'),))
                  : Expanded(
                  child:ListView.separated(
                    itemCount:myProvider.items.length,
                    itemBuilder: (context, index) {
                      return ItemWidget(
                        anItem: myProvider.items[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.primaryColor,
                        thickness: 1.0,
                        indent: 16.0,
                        endIndent: 16.0,
                      );
                    },
                  )
              ),
              BusyButton(
                  title: "Add Item",
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.addItem);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
