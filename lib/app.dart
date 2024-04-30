import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:submision_flutter_intermediate/global_bloc/app_bloc.dart';
import 'package:submision_flutter_intermediate/routes/get_router.dart';
import 'package:submision_flutter_intermediate/styles/styles.dart';
import 'package:submision_flutter_intermediate/utils/hive/services/user_hive_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    late AppBloc bloc;
    Locale? locale;
    bloc = context.read<AppBloc>();
    locale = UserHiveService.getLocale();
    if (locale == null) {
      Locale defaultLocale = View.of(context).platformDispatcher.locale;
      bloc.add(EventChangeLocaleUser(defaultLocale));
      locale = UserHiveService.getLocale();
    }
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppLocalizationsState) {
          locale = state.locale;
        }
      },
      listenWhen: (previous, current) {
        if (previous is AppLocalizationsState &&
            current is AppLocalizationsState) {
          return previous.locale != current.locale;
        }
        return false;
      },
      buildWhen: (previous, current) {
        if (previous is AppLocalizationsState &&
            current is AppLocalizationsState) {
          return previous.locale != current.locale;
        }
        return false;
      },
      builder: (context, state) {
        if (state is AppLocalizationsState) {
          if (state.locale != null) {
            locale = state.locale!;
          }
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Router(
            routerDelegate: appRouter,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        );
      },
    );
  }
}
