import 'package:fluent/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseShimmer extends StatelessWidget {
  const CourseShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey.withAlpha(200),
      highlightColor: AppColor.grey.withAlpha(100),
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 12),
                // Text Content Placeholder
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(height: 12, width: 180, color: AppColor.white),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            height: 12,
                            width: 80,
                            color: AppColor.white,
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 12,
                            width: 60,
                            color: AppColor.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
