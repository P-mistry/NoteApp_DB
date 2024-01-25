import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/cubit/auth/auth_cubit.dart';
import 'package:noteapp/cubit/credential/credential_cubit.dart';
import 'package:noteapp/cubit/note/note_cubit.dart';
import 'package:noteapp/cubit/user/user_cubit.dart';
import 'package:noteapp/router/on_generate_route.dart';
import 'package:noteapp/ui/home_page.dart';
import 'package:noteapp/ui/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()..appStarted()),
        BlocProvider<CredentialCubit>(create: (_) => CredentialCubit()),
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
        BlocProvider<NoteCubit>(create: (_) => NoteCubit()),
      ],
      child: MaterialApp(
        title: 'Note App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                if (authState.uid == "") {
                  return SignInPage();
                } else {
                  return HomePage(uid: authState.uid,);
                }
              } else {
                return SignInPage();
              }
            });
          }
        },
      ),
    );
  }
}
