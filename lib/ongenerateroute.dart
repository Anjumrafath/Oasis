import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/appentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/credential/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/editcommentpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/editreplaypage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/postdetailpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/updatepostpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/editprofilepage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/followerspage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/followingpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/singleuserprofilepage.dart';

import 'features/presentation/pages/credential/signinpage.dart';
import 'features/presentation/pages/post/comment/commentpage.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return routeBuilder(EditProfilePage(
              currentUser: args,
            ));
          } else {
            return routeBuilder(NoPageFound());
          }
        }
      case PageConst.updatePostPage:
        {
          if (args is PostEntity) {
            return routeBuilder(UpdatePostPage(
              post: args,
            ));
          } else {
            return routeBuilder(NoPageFound());
          }
        }
      case PageConst.updateCommentPage:
        {
          if (args is CommentEntity) {
            return routeBuilder(EditCommentPage(
              comment: args,
            ));
          } else {
            return routeBuilder(NoPageFound());
          }
        }
      case PageConst.updateReplayPage:
        {
          if (args is ReplayEntity) {
            return routeBuilder(EditReplayPage(
              replay: args,
            ));
          } else {
            return routeBuilder(NoPageFound());
          }
        }
      case PageConst.commentPage:
        {
          if (args is AppEntity) {
            return routeBuilder(CommentPage(
              appEntity: args,
            ));
          }
          return routeBuilder(NoPageFound());
        }
      case PageConst.postDetailPage:
        {
          if (args is String) {
            return routeBuilder(PostDetailPage(
              postId: args,
            ));
          }
          return routeBuilder(NoPageFound());
        }
      case PageConst.singleUserProfilePage:
        {
          if (args is String) {
            return routeBuilder(SingleUserProfilePage(
              otherUserId: args,
            ));
          }
          return routeBuilder(NoPageFound());
        }
      case PageConst.followingPage:
        {
          if (args is UserEntity) {
            return routeBuilder(FollowingPage(
              user: args,
            ));
          }
          return routeBuilder(NoPageFound());
        }
      case PageConst.followersPage:
        {
          if (args is UserEntity) {
            return routeBuilder(FollowersPage(
              user: args,
            ));
          }
          return routeBuilder(NoPageFound());
        }
      case PageConst.signInPage:
        {
          return routeBuilder(SignInPage());
        }
      case PageConst.signUpPage:
        {
          return routeBuilder(SignUpPage());
        }
      case PageConst.signUpPage:
        {
          return routeBuilder(SignUpPage());
        }
      default:
        {
          NoPageFound();
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page not found"),
      ),
      body: Center(
        child: Text("Page not found"),
      ),
    );
  }
}
