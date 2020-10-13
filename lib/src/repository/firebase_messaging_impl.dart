import 'dart:async';
import 'dart:io';

// import 'package:mindcapitalsimulator/src/model/new_message.dart';
import 'package:mindcapitalsimulator/src/repository/interface/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingImpl extends Notification{
  final FirebaseMessaging _fcm = FirebaseMessaging();
  // final StreamController _chatMessage = StreamController<NewMessage>();
  // final StreamController _chatMessageBackground = StreamController<NewMessage>();

  Stream<String> get onNewDeviceToken => _fcm.onTokenRefresh;
  // Stream<NewMessage> get onNewChatMessage => _chatMessage.stream;
  // Stream<NewMessage> get onNewChatMessageBackground => _chatMessageBackground.stream;

  Future initialise() async {
    if(Platform.isIOS){
      //Pedimos permisos para iOS
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      // //Se ejecuta cuando la app esta en pantalla
      // onMessage: (Map<String, dynamic> message) async {
      //   print('onMessage: $message');
      //   _newMessage(message);
      // },
      // //Se ejecuta cuando la app ha sido cerrada completamente y se abre a través de la notificación
      // onLaunch: (Map<String, dynamic> message) async {
      //   print('onMessage: $message');
      //   _newMessageBackground(message);
      // },
      // //Se ejecuta cuando la app esta en background y se abre a través de la notificación
      // onResume: (Map<String, dynamic> message) async {
      //   print('onMessage: $message');
      //   _newMessageBackground(message);
      // },  
    );
  }

  Future<String> getDeviceToken() async {
    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");
    return token;
  }

  // void _newMessage(Map<String, dynamic> message){
  //   NewMessage newMessage = NewMessage(message['data']['CHAT_ID'],noRead: message['data']['NO_READ']);
  //   _chatMessage.add(newMessage);
  // }

  // void _newMessageBackground(Map<String, dynamic> message){
  //   NewMessage newMessage = NewMessage(message['data']['CHAT_ID']);
  //   _chatMessageBackground.add(newMessage);
  // }
}