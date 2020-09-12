import 'package:app_for_leadit/data_receivers/comments_provider.dart';
import 'package:app_for_leadit/data_receivers/posts_provider.dart';
import 'package:app_for_leadit/data_receivers/users_provider.dart';
import 'package:app_for_leadit/main/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostsProvider>(
    create: (context) => PostsProvider()),
    ChangeNotifierProvider<UsersProvider>(
    create: (context) => UsersProvider()),
    ChangeNotifierProvider<CommentsProvider>(
    create: (context) => CommentsProvider()),

      ],
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
