import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/injection/injector.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../controllers/user/user_cubit.dart';
import '../widgets/common/posts_tab_bar.dart';
import '../widgets/user_profile/user_profile_appbar.dart';
import '../widgets/user_profile/user_profile_header.dart';

class UserProfile extends HookWidget {
  final String uID;

  const UserProfile({super.key, required this.uID});

  @override
  Widget build(BuildContext context) {
    final userState = useState<UserEntity?>(null);
    final isLoading = useState<bool>(true);

    useEffect(() {
      sl<UserCubit>().getUserById(uID).then((user) {
        userState.value = user;
        isLoading.value = false;
      });
      return null;
    }, []);

    //TODO: Refactor getting profile loading
    if (isLoading.value) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 1.2));
    }

    final user = userState.value!;

    return Scaffold(
      appBar: UserProfileAppBar(username: user.username),
      body: NestedScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: UserProfileHeader(user: user),
            ),
          ];
        },
        body: PostsTabBar(
          uID: user.uID,
          tapFromMyProfile: false,
          tapFromUserProfile: true,
        ),
      ),
    );
  }
}
