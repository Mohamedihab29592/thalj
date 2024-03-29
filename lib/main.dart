import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thalj/features/auth/presentation/bloc/otp_bloc/otp_bloc.dart';
import 'package:thalj/features/home/presentation/screens/Home_Screen.dart';
import 'core/errors/internetCheck.dart';
import 'core/local/cash_helper.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'features/adminHome/data/remote_data/remote_data_source.dart';
import 'features/adminHome/domain/repository.dart';
import 'features/adminHome/presenation/bloc/driver_subscription_bloc/driver_subscription_bloc.dart';
import 'features/adminHome/presenation/bloc/user_invoice_bloc/user_invoice_bloc.dart';
import 'features/adminHome/presenation/screens/admin_options_screen.dart';
import 'features/auth/data/remote_data_source.dart';
import 'features/auth/domain/repository.dart';
import 'features/documents/data/remote_data.dart';
import 'features/documents/domain/repository.dart';
import 'features/home/data/remote_data_source.dart';
import 'features/home/domain/repository.dart';
import 'features/splash/presentation/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
  await NetworkInfoImpl().checkInternet();
  await CacheHelper.init();
  Widget widget;

  String? loginToken = CacheHelper.getData(key: 'loginToken');
  String? adminToken = CacheHelper.getData(key: 'adminToken');

  if (loginToken != null) {
    widget =  const HomeScreen();
  } else if (adminToken != null) {
    widget = const AdminOptionsScreen();
  }  else {
    widget = const SplashScreen(animateBottom: true);
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
   final Widget startWidget;
  const MyApp(this.startWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            RepositoryProvider<AuthRepository>(
              create: (context) => AuthRepository(AuthRemoteDataSource()),
            ),
            RepositoryProvider<DocumentRepository>(
              create: (context) =>
                  DocumentRepository(DocumentsRemoteDataSource()),
            ),
            RepositoryProvider<HomeRepository>(
              create: (context) => HomeRepository(
                HomeRemoteDataSource(),
              ),
            ),
            RepositoryProvider<AdminRepository>(
              create: (context) => AdminRepository(AdminRemoteDataSource()),
            ),
            BlocProvider(
                create: (context) => DriverSubscriptionBloc(
                    adminRepository: context.read<AdminRepository>())),
            BlocProvider(
                create: (context) => UserInvoiceBloc(
                    adminRepository: context.read<AdminRepository>())),
            BlocProvider(
                create: (context) => OtpBloc(context.read<AuthRepository>()))
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: getAppTheme(),
            home: startWidget,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) =>
                    appRoutes(settings.name!, settings.arguments),
              );
            },
          ),
        );
      },
    );
  }
}
