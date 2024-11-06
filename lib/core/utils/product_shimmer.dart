import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    this.height,
    this.width,
    super.key,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          title: Container(
            height: height?? 119.h,
            width:double.infinity,

            decoration: BoxDecoration(
              color: const Color(0xffF8F8FA),
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
            ),
          ),
        )
    );
  }
}