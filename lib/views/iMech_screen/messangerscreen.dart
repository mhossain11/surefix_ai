import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:surefix_ai/controller/chatbox_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/ProjectResource.dart';
import '../../models/userentityModel.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  late ChatBoxController chatBoxController;
  late ChatBoxController chatBoxControllerVar;
  String? token;
  List<ChatMessage>messageList=[];
   final ChatUser currentUser = ChatUser(id: '1',firstName: 'Faysal',profileImage: 'https://banner2.cleanpng.com/20180806/tjy/kisspng-computer-icons-portable-network-graphics-user-symb-profile-svg-png-icon-free-download-446808-onl-5b68e60de80c24.8285058715336012939505.jpg');
  final ChatUser otherUser= ChatUser(id: '2',firstName: 'AIChat');

  @override
  void initState() {
    super.initState();
    shareData();

  }
  shareData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {

      token = sp.getString('tokenSP');

    });
  }
  @override
  void didChangeDependencies() {
    chatBoxController = Provider.of<ChatBoxController>(context, listen: false);
    chatBoxControllerVar = Provider.of<ChatBoxController>(context, listen: true);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body:FutureBuilder(
        future: chatBoxController.getChatDataFromApis(context: context,),
        builder: (context,snapshot) {
          return DashChat(
              currentUser: currentUser,
             messageOptions: const MessageOptions(
               currentUserContainerColor: Colors.blueGrey,
             ),
              onSend: _sendMessage,
              messages: messageList,
            inputOptions: const InputOptions(
              alwaysShowSend: true
            ),

          );
        },
      ),

    );
  }
  void _sendMessage(ChatMessage chatMessage){

    setState(() {
      messageList = [chatMessage,...messageList];
    });

    try{
      String question = chatMessage.text;


    }catch(e){
      print(e.toString());
    }

  }
}


