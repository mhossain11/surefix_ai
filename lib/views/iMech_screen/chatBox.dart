import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surefix_ai/utils/colors.dart';
import 'package:surefix_ai/views/Dashboard/searchallpost.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/chatbox_controller.dart';
import '../../controller/requestDetailsController.dart';
import 'package:intl/intl.dart';
import '../../helpers/ProjectResource.dart';
import '../../models/postresponsemodel.dart';
import '../../utils/images.dart';


class ChatBox extends StatefulWidget {
  var requestId;
   ChatBox({super.key,required this.requestId,});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  var loading = false;
  var loadingError = false;
  String? token;
  String? username ="Ismail Hossain";
  int loggedinuserid=0;
  
  final  _messageScrollController = ScrollController();
  late ChatBoxController chatBoxController;



  @override
  void initState() {
    super.initState();
    shareData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }
  shareData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {

      token = sp.getString('tokenSP');
      loggedinuserid= int.parse(sp.getString('userid')!);
    });
  }
  var format = DateFormat('HH:mm a');
  final formatter = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Engine Sound Problem',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: themeColor,
        leading:IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SearchAllPost()));
            //Navigator.of(context).pop();
          },
          icon: Image.asset(Images.backIcon,color: Colors.white,),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Consumer<RequestDetailsController>(
                    builder: (context,value,child){
                  loading =true;
                  value.setValue(widget.requestId);
                  return FutureBuilder<PostResponseModel>(
                  future: value.messageLists(context: context),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                       return ListView.builder(
                          controller: _messageScrollController,
                          reverse: true,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(), // ← can't
                          itemCount: snapshot.data!.postResponse!.length,
                          itemBuilder: (context, index){
                            bool isSameDate = false;
                            String? newDate = '';
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                crossAxisAlignment: snapshot.data!.postResponse![index].userId.toString() == loggedinuserid.toString() ?  CrossAxisAlignment.end  : CrossAxisAlignment.start,
                                children: [
                                  if(newDate.isNotEmpty)
                                    Center(child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffE3D4EE),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(newDate),
                                        ))),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: CustomPaint(
                                      painter: MessageBubble(
                                          color:  snapshot.data!.postResponse![index].userId.toString() == loggedinuserid.toString() ?  const Color(0xffE3D4EE) :  const Color(0xffDAF0F3),
                                         // alignment: snapshot.data!.issueResponses![index].type == 0 ? Alignment.topRight : Alignment.topLeft,
                                          alignment: snapshot.data!.postResponse![index].userId.toString() == loggedinuserid.toString() ? Alignment.topRight : Alignment.topLeft,
                                          tail: true
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * .7,
                                        ),
                                        margin:snapshot.data!.postResponse![index].userId.toString() == loggedinuserid.toString() ? const EdgeInsets.fromLTRB(7, 7, 17, 7) : const EdgeInsets.fromLTRB(17, 7, 7, 7),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: snapshot.data!.postResponse![index].userId.toString() == loggedinuserid.toString()
                                                  ? const EdgeInsets.only(left: 4, right: 4, bottom: 10)
                                                  : const EdgeInsets.only(left: 4, right: 4 ,bottom: 10),
                                              child: Text(snapshot.data!.postResponse![index].responseText.toString()  ,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Text(DateFormat('HH:mm a').format(DateTime.parse(snapshot.data!.postResponse![index].createdAt.toString())) ,textAlign: TextAlign.left, style: const TextStyle(fontSize: 10),))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      );


                    }else{
                      return const Center(child: Text('Loading..'));
                    }
                  },

                );
                }),
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5,bottom: 10),
              child: Consumer<ChatBoxController>(
                    builder: (context,provider,child){
                    provider.setValue(widget.requestId);
                    return Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: provider.messageController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              minLines: 1,
                              decoration: const InputDecoration(
                                  hintText: 'Enter Message...' ,
                                  fillColor: Colors.red ,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                  border: OutlineInputBorder(
                                  )
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10,),

                        Padding(
                          padding: const EdgeInsets.only(right: 12.0,top: 8,bottom: 8),
                          child: GestureDetector(
                            onTap: (){
                              provider.getChatDataFromApis( context: context);
                              setState(() {});
                              _messageScrollController.animateTo(
                                _messageScrollController.position.minScrollExtent,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            child: const CircleAvatar(
                              child: Icon(Icons.send),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
                    },
                    ),
            ),


          ],
        ),
      ),
    );
  }
}

class MessageBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  MessageBubble({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  final double _radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    if (alignment == Alignment.topRight) {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right bubble curve
        path.quadraticBezierTo(
            w - _radius * 1.5, h, w - _radius * 1.5, h - _radius * 0.6);

        /// bottom-right tail curve 1
        path.quadraticBezierTo(w - _radius * 1, h, w, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            w - _radius * 0.8, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right curve
        path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    } else {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);
        // bottom-right tail curve 1
        path.quadraticBezierTo(_radius * .8, h, 0, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            _radius * 1, h, _radius * 1.5, h - _radius * 0.6);

        /// bottom-left bubble curve
        path.quadraticBezierTo(_radius * 1.5, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);

        /// bottom-left curve
        path.quadraticBezierTo(_radius, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin!.left, end!.left, elasticCurveValue)!,
      lerpDouble(begin!.top, end!.top, elasticCurveValue)!,
      lerpDouble(begin!.right, end!.right, elasticCurveValue)!,
      lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue)!,
    );
  }
}
