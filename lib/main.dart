import 'package:flutter/material.dart';
import 'package:tyrads_assessment/features/campaign_info_stepper/view/campaign_info_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CampaignInfoView(),
    );
  }
}
