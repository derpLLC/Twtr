import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'twtr-controller.dart';
import 'twtr_repository.dart';

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
                style: Theme.of(context).textTheme.headline4!.copyWith(),
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
                  onPressed: () => postTweet(context, tweetTextEditingController),
                    textEditingController: tweetTextEditingController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void postTweet(BuildContext context,
      TextEditingController tweetTextEditingController) async {
    if (tweetTextEditingController.text.isEmpty) return;

    final result = await context
        .read(twitterControllerProvider)
        .postTweet(tweetTextEditingController.text);
    if(result.isRight()) {
      tweetTextEditingController.clear();
    }
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({Key? key, required this.textEditingController, required this.onPressed})
      : super(key: key);

  final TextEditingController textEditingController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 4,
      maxLength: 280,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        hintText: 'What\'s happening?',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: ClipOval(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.send),
            ),
          ),
        ),
        fillColor: Color(0xffE9EFFD),
        filled: true,
      ),
    );
  }
}
