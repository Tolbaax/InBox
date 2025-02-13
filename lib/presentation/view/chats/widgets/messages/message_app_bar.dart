import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../components/text_fields/search_field.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MessagesCubit cubit;

  const MessagesAppBar({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 86.0.h,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.messages,
            style: TextStyle(fontSize: 20.0.sp),
          ),
          SizedBox(height: 12.0.h),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 4.0.w),
            child: SearchField(
              controller: cubit.searchController,
              hintText: AppStrings.search,
              isTextFieldEmpty: cubit.isTextFieldEmpty,
              onChanged: cubit.onSearchFieldChanged,
              suffixTap: cubit.clearSearchField,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(86.0.h);
}
