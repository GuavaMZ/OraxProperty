import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:oraxproperty/app/app.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eytldvdgtjmcvctflnvz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV5dGxkdmRndGptY3ZjdGZsbnZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY0NDAzNzYsImV4cCI6MjAxMjAxNjM3Nn0.2TdI0gCk74HYJd8_yDhPZ2TcNFurCr5oMvd_KKCWnhk',
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await initService();
  runApp(MyApp());
}

final supabase = Supabase.instance.client;  

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// @pragma('vm:entry-point')
// Future<void> initService() async {
//   final service = FlutterBackgroundService();

//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'TST', // id
//     'TST', // title
//     showBadge: false,
//     importance: Importance.low,
//   );

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   service.configure(
//       androidConfiguration: AndroidConfiguration(
//           onStart: onStart,
//           notificationChannelId: 'TST',
//           autoStart: true,
//           isForegroundMode: true,
//           autoStartOnBoot: true,
//           foregroundServiceNotificationId: 555),
//       iosConfiguration: IosConfiguration());

//   flutterLocalNotificationsPlugin.cancelAll();
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   // final supabaseBG = Supabase.instance.client;
//   DartPluginRegistrant.ensureInitialized();
//   await Supabase.initialize(
//     url: 'https://eytldvdgtjmcvctflnvz.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV5dGxkdmRndGptY3ZjdGZsbnZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY0NDAzNzYsImV4cCI6MjAxMjAxNjM3Nn0.2TdI0gCk74HYJd8_yDhPZ2TcNFurCr5oMvd_KKCWnhk',
//   );

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // supabase
  //     .from('messages')
  //     .stream(primaryKey: ['message_id'])
  //     .eq('to_usr', supabase.auth.currentUser!.id)
  //     .limit(15)
  //     .order('created_at')
  //     .listen((event) async {
  //       for (var message in event) {
  //         if (message['isRead'] == false) {
  //           await flutterLocalNotificationsPlugin.show(
  //               777,
  //               'New Message',
  //               "${message['content']}",
  //               const NotificationDetails(
  //                   android: AndroidNotificationDetails(
  //                       'chat_channel', 'Orax Property Chat Channel')));
  //         }
  //       }
  //     });
// }
