import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_cleanarchitecture/features/data/datasources/remotedatasource/remotedatasource.dart';
import 'package:insta_cleanarchitecture/features/data/datasources/remotedatasource/remotedatasourceimpli.dart';
import 'package:insta_cleanarchitecture/features/data/repository/firebaserepositoryimpli.dart';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/post/likepostusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/storage/uploadimagetostorageusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/createuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getcurrentuidusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getsingleuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/is_signinuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/signinuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/signoutuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/signupuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/updateuserusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/credential/credentialcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleuser/getsingleusercubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/usercubit.dart';

import 'features/domain/usecases/firebaseusecases/post/createpostusecase.dart';
import 'features/domain/usecases/firebaseusecases/post/deletepostusecase.dart';
import 'features/domain/usecases/firebaseusecases/post/readpostusecase.dart';
import 'features/domain/usecases/firebaseusecases/post/updatepostusecase.dart';
import 'features/presentation/cubit/auth/authcubit.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Cubits
  sl.registerFactory(
    () => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => CredentialCubit(
      signUpUseCase: sl.call(),
      signInUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(
      updateUserUseCase: sl.call(),
      getUsersUseCase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => GetSingleUserCubit(
      getSingleUserUseCase: sl.call(),
    ),
  );

  //post cubit injection
  sl.registerFactory(
    () => PostCubit(
      createPostUseCase: sl.call(),
      deletePostUseCase: sl.call(),
      likePostUseCase: sl.call(),
      readPostsUseCase: sl.call(),
      updatePostUseCase: sl.call(),
    ),
  );

  //Usecases
  //user
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));

//cloud storage
  sl.registerLazySingleton(
      () => UploadImageToStorageUseCase(repository: sl.call()));

//post
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));

//repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpli(remoteDataSource: sl.call()));

//remotedatasource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpli(
            firebaseFirestore: sl.call(),
            firebaseAuth: sl.call(),
            firebaseStorage: sl.call(),
          ));

//Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
