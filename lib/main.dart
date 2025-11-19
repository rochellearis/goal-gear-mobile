import 'package:flutter/material.dart';
import 'package:goal_gear/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Goal Gear',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(
              0xFF5459AC, 
              <int, Color>{ // Tambahkan shades jika ingin MaterialColor penuh
                50: Color(0xFFEBEBF5),
                100: Color(0xFFC7C7E5),
                200: Color(0xFFA0A1D3),
                300: Color(0xFF7879C1),
                400: Color(0xFF5E60B5),
                500: Color(0xFF5459AC), // Warna utama
                600: Color(0xFF4C51A4),
                700: Color(0xFF42479A),
                800: Color(0xFF383D90),
                900: Color(0xFF2A2D80),
              },
            ),
          )
          .copyWith(
              // 💡 Secondary/Accent menggunakan warna gelap #52357B
              secondary: const Color(0xFF52357B),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}