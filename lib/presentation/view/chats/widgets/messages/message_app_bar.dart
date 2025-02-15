import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../components/text_fields/search_field.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';

import 'chat_selection_mode_app_bar.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MessagesCubit cubit;

  const MessagesAppBar({super.key, required this.cubit});

  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 86.0.h,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
            width: double.infinity, // Ensures full width
            child: cubit.isChatSelecting
                ? ChatSelectionModeAppBar(cubit: cubit)
                : Text(
                    AppStrings.messages,
                    style: TextStyle(fontSize: 20.0.sp),
                  ),
          ),
          SizedBox(height: 8.0.h),
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
