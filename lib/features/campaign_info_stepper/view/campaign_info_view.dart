import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tyrads_assessment/features/campaign_info_stepper/models/step_info_model.dart';
import 'package:tyrads_assessment/utils/utils.dart';

import '../../../core/constants/constants.dart';

/// This widget is used for showing stepper component
class CampaignInfoView extends StatefulWidget {
  const CampaignInfoView({Key? key}) : super(key: key);

  @override
  State<CampaignInfoView> createState() => _CampaignInfoViewState();
}

class _CampaignInfoViewState extends State<CampaignInfoView> {
  List<StepInfoModel>? _mStepInfoList;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    getStepsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Future Stepper Demo'),
        ),
        body: Builder(
          builder: (ctx) {
            if (_mStepInfoList != null) {
              return Column(
                children: [
                  Expanded(
                    child: Stepper(
                      type: StepperType.vertical,
                      physics: const ScrollPhysics(),
                      currentStep: _currentStep,
                      steps: getSteps(_mStepInfoList!),
                      controlsBuilder: (context, _) {
                        return Row(
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                if (_currentStep < _mStepInfoList!.length - 1) {
                                  setState(() => _currentStep += 1);
                                } else if (_currentStep ==
                                    _mStepInfoList!.length - 1) {
                                  Utils.showInfoDialog(
                                      context: context,
                                      title: 'Success',
                                      message:
                                          'You have completed ad campaign instructions.');
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: Text(
                                _currentStep == _mStepInfoList!.length - 1
                                    ? 'FINISH'
                                    : 'CONTINUE',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _currentStep > 0
                                    ? setState(() => _currentStep -= 1)
                                    : null;
                              },
                              child: const Text(
                                'BACK',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            // Displaying LoadingSpinner to indicate waiting state
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps(List<StepInfoModel> mStepsInfoList) {
    List<Step> mList = [];
    for (int i = 0; i < mStepsInfoList.length; i++) {
      mList.add(
        Step(
          title: Text(
            mStepsInfoList[i].title,
            style: TextStyle(
                color: _currentStep >= i ? Colors.black87 : Colors.grey),
          ),
          content: Column(
            children: <Widget>[
              Text(mStepsInfoList[i].description),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
          isActive: _currentStep >= i,
          state: _currentStep > i ? StepState.complete : StepState.disabled,
        ),
      );
    }
    return mList;
  }

  Future<void> getStepsInfo() async {
    try {
      final String result =
          await platformChannel.invokeMethod(stepsInfoMethodName);
      var stepsJson = jsonDecode(result) as List;
      _mStepInfoList = List<StepInfoModel>.from(stepsJson.map<dynamic>(
        (dynamic x) {
          return StepInfoModel.fromJson(x as Map<String, dynamic>);
        },
      ));
      setState(() {});
    } on PlatformException catch (e) {
      // todo : show platform not supported toast
      debugPrint("Error : $e");
    }
  }
}
