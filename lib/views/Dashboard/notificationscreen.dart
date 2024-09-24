import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surefix_ai/views/Dashboard/viewownpost.dart';
import '../../controller/notification_controller.dart';
import '../../helpers/ProjectResource.dart';
import '../../models/notificationmodel.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../iMech_screen/requestDetails.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationController notificationController;
  late NotificationController notificationControllerVar;
  String? token;

  void initState() {
    super.initState();
    shareData();
    notificationController = Provider.of<NotificationController>(context, listen: false);
    notificationControllerVar = Provider.of<NotificationController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //  notificationController.notificationData(context: context);
      setState(() {
        notificationController.loading=false;
      });

    });
  }
  shareData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      token = sp.getString('tokenSP');

    });
  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notification',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: themeColor,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              Images.backIcon,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: ProjectResource.screenHeight,
            child: FutureBuilder<NotificationModel>(
                future: notificationController.notificationData(
                  context: context,token:token
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.notifications!.isEmpty){
                      return const Center(
                          child: Text('No Notification Right Now!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),));
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.notifications!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                               /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestDetails(
                                              requestId: snapshot.data!.notifications![index].postId.toString(),
                                              nameData: snapshot.data!.notifications![index].postTitle.toString(),
                                              descriptionData: snapshot.data!.notifications![index].postDescription.toString(),
                                            )));*/
                              },
                              child: SizedBox(
                                height: 100,
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.notifications, size: 50, color: Colors.blue,),
                                        Expanded(
                                          child: Padding(padding: const EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: [
                                                Text(snapshot
                                                    .data!
                                                    .notifications![index]
                                                    .notificationText
                                                    .toString(),maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700),),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Text(DateFormat(
                                                        'yyyy-MM-dd hh:mm:ss')
                                                        .format(DateTime.parse(snapshot
                                                        .data!
                                                        .notifications![index]
                                                        .createdAt
                                                        .toString())))
                                                  ],
                                                )
                                              ],
                                            ),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                   
                  } else {
                    return Shimmer.fromColors(
                      baseColor:Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: SizedBox(
                        child: ListView.builder(
                          itemCount:10,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Container(
                                width: 30,
                                height: 30,
                                color: Colors.white,
                              ),
                              title: Container(
                                color: Colors.white,
                                height: 10,
                                width: 100,
                              ),
                              subtitle: Container(
                                color: Colors.white,
                                height: 10,
                                width: 100,
                              ),
                            );
                          },

                        ),
                      ) ,
                    );
                  }
                }),
          ),
        )));
  }

/*  Widget timeFormat(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    return Text(DateTime(dt.year, dt.month, dt.day).timeZoneName);
  }*/
}
