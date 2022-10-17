import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  IncallManager incallManager = IncallManager();

  @override
  void initState() {
    super.initState();
  }

  void showResult(title, result) {
    if (kDebugMode) {
      print('$title => $result.');
    }
  }

  List<Widget> buildTestButtons() {
    List<Map<String, dynamic>> items = [
      {
        'InCallManager.start(audio)': () {
          incallManager.start(
              media: MediaType.AUDIO, auto: false, ringback: '_DTMF_');
        }
      },
      {
        'InCallManager.start(video)': () {
          incallManager.start(
              media: MediaType.VIDEO, auto: false, ringback: '_DEFAULT_');
        }
      },
      {
        'InCallManager.stop': () {
          incallManager.stop();
        }
      },
      {
        'enableProximitySensor(true)': () {
          incallManager.enableProximitySensor(true);
        }
      },
      {
        'enableProximitySensor(false)': () {
          incallManager.enableProximitySensor(false);
        }
      },
      {
        'checkRecordPermission': () async {
          showResult('checkRecordPermission',
              await incallManager.checkRecordPermission());
        }
      },
      {
        'checkCameraPermission': () async {
          showResult('checkCameraPermission',
              await incallManager.checkCameraPermission());
        }
      },
      {
        'requestRecordPermission': () {
          incallManager.requestRecordPermission();
        }
      },
      {
        'requestCameraPermission': () {
          incallManager.requestCameraPermission();
        }
      },
      {
        'setKeepScreenOn(true)': () {
          incallManager.setKeepScreenOn(true);
        }
      },
      {
        'setKeepScreenOn(false)': () {
          incallManager.setKeepScreenOn(false);
        }
      },
      {
        'setSpeakerphoneOn(true)': () {
          incallManager.setSpeakerphoneOn(true);
        }
      },
      {
        'setSpeakerphoneOn(false)': () {
          incallManager.setSpeakerphoneOn(false);
        }
      },
      {
        'startRingback': () {
          incallManager.startRingback();
        }
      },
      {
        'stopRingback': () {
          incallManager.stopRingback();
        }
      },
      {
        'startRingtone(30)': () {
          incallManager.startRingtone(RingtoneUriType.DEFAULT, 'default', 30);
        }
      },
      {
        'stopRingtone': () {
          incallManager.stopRingtone();
        }
      },
    ];

    if (Platform.isAndroid) {
      items.addAll([
        {
          'turnScreenOn': () {
            incallManager.turnScreenOn();
          }
        },
        {
          'turnScreenOff': () {
            incallManager.turnScreenOff();
          }
        },
        {
          'setMicrophoneMute(true)': () {
            incallManager.setMicrophoneMute(true);
          }
        },
        {
          'setMicrophoneMute(false)': () {
            incallManager.setMicrophoneMute(false);
          }
        },
        {
          'setForceSpeakerphoneOn(true)': () {
            incallManager.setForceSpeakerphoneOn(
                flag: ForceSpeakerType.FORCE_ON);
          }
        }
      ]);
    }

    return items
        .map((item) => ElevatedButton(
              onPressed: () async {
                if (kDebugMode) {
                  print(item.keys.first);
                }
                await item.values.first();
              },
              child: Text(item.keys.first),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buildTestButtons(),
            ),
          ),
        ),
      ),
    );
  }
}
