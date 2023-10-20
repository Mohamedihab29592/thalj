import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thalj/core/utils/app_strings.dart';
import 'package:thalj/features/auth/data/remote_data_source.dart';
import 'package:thalj/features/auth/domain/repository.dart';
import 'package:thalj/features/documents/presentation/bloc/document_checking_bloc/document_checking_bloc.dart';
import 'package:thalj/features/home/domain/repository.dart';

import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart';
import '../features/home/data/remote_data_source.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => DocumentCheckingBloc()),
           // RepositoryProvider(create: (context) => OffersRemoteDataSource().getOffers()),
            RepositoryProvider<AuthRepository>(
              create: (context) => AuthRepository(AuthRemoteDataSource()),
            ),
            RepositoryProvider<OffersRepository>(
              create: (context) => OffersRepository(OffersRemoteDataSource()),
            ),
            
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: getAppTheme(),
            initialRoute: Routes.intitlRoute,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}