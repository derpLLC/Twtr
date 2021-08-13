import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tweetTextEditingController = useTextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: const Color(0xffE9EFFD),
            padding: EdgeInsets.only(top: kToolbarHeight),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Twtr',
                style: Theme.of(context).textTheme.headline6!.copyWith(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(top: kToolbarHeight * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(42),
                topRight: Radius.circular(42),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                CustomInputField(
                    textEditingController: tweetTextEditingController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({Key? key, required this.textEditingController})
      : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
    );
  }
}
