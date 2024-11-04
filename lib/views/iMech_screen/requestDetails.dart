import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:surefix_ai/models/usersRequestModel.dart';
import 'package:surefix_ai/views/iMech_screen/chatBox.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/requestDetailsController.dart';
import '../../helpers/ProjectResource.dart';
import '../../helpers/textformfield.dart';
import '../../services/route_manager.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class RequestDetails extends StatefulWidget {
  var requestId;
  String nameData = 'Loading..';
  String descriptionData = 'Loading..';
  String make;
  String model;
  String year;

  RequestDetails({
    super.key,
    required this.requestId,
    required this.nameData,
    required this.descriptionData,
    required this.make,
    required this.model,
    required this.year,
  });

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var loading = false;
  String? userType;
  String? token;
  bool isChecked = false;
  int currentid = 0;
  int currentfix = 1;
  bool isFabVisible = true;
  bool flag = false;
  String? descripText;

  late RequestDetailsController requestDetailsController;
  late RequestDetailsController requestDetailsControllerVar;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    shareData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        requestDetailsController.loading = true;
      });
      // requestDetailsController =  Provider.of<RequestDetailsController>(context, listen: false);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    requestDetailsController =
        Provider.of<RequestDetailsController>(context, listen: false);
    requestDetailsControllerVar =
        Provider.of<RequestDetailsController>(context, listen: true);
    super.didChangeDependencies();
  }

  shareData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userType = sp.getString('usertype');
      token = sp.getString('tokenSP');
    });
  }

  @override
  void dispose() {
    super.dispose();
    // requestDetailsController.issueController.clear();
    // requestDetailsController.descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Post Details',
            overflow: TextOverflow.ellipsis,
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
          child: Consumer<RequestDetailsController>(
              builder: (context, value, child) {
            loading = true;
            value.setValue(widget.requestId);
            return Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 2,
                  shadowColor: Colors.black87,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            widget.nameData,
                            /*'VW Golf R. Engine Warning light flashing',*/
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            widget.descriptionData,
                            /*'The engine warning light on my 2018 Golf R is flashing intermittently when I go over 80 mph.',*/
                            // overflow: TextOverflow.ellipsis,
                            //  maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 1,
                  shadowColor: Colors.black87,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    width: 380,
                    height: 40,
                    decoration: BoxDecoration(
                        // border: Border.all(width: .2, color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Initial Possible AI Solutions',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: .7, color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.note_outlined),
                            SizedBox(
                              width: 3,
                            ),
                            Text('Possible Fixes'),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            height: ProjectResource.screenHeight * .60,
                            child: FutureBuilder<UsersRequestModel>(
                                future: requestDetailsController
                                    .userViewRequest(context: context),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return NotificationListener<
                                        UserScrollNotification>(
                                      onNotification: (notification) {
                                        if (notification.direction ==
                                            ScrollDirection.forward) {
                                          if (!isFabVisible) {
                                            setState(() => isFabVisible = true);
                                          }
                                        } else if (notification.direction ==
                                            ScrollDirection.reverse) {
                                          if (isFabVisible) {
                                            setState(
                                                () => isFabVisible = false);
                                          }
                                        }
                                        return true;
                                      },
                                      child: ListView.builder(
                                          itemCount:
                                              snapshot.data!.triages!.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            whiteColor,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0))),
                                                        content: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 400,
                                                          child: Scrollbar(
                                                            controller:
                                                                scrollController,
                                                            trackVisibility:
                                                                true,
                                                            thickness: 7,
                                                            child:
                                                                SingleChildScrollView(
                                                              controller:
                                                                  scrollController,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: const BorderRadius
                                                                        .only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10)),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          110,
                                                                      height:
                                                                          20,
                                                                      color: const Color(
                                                                          0xFF685c11),
                                                                      //color: const Color(0xFF96482B),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'Problem: ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      widget
                                                                          .nameData,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              blackColor)),
                                                                  const Gap(10),
                                                                  ClipRRect(
                                                                    borderRadius: const BorderRadius
                                                                        .only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10)),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          110,
                                                                      height:
                                                                          20,
                                                                      color: const Color(
                                                                          0xFF685c11),
                                                                      //color: const Color(0xFF96482B),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'Description: ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      widget
                                                                          .descriptionData,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              blackColor)),
                                                                  const Gap(10),
                                                                  Center(
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius: const BorderRadius
                                                                          .only(
                                                                          bottomLeft: Radius.circular(
                                                                              5),
                                                                          bottomRight: Radius.circular(
                                                                              5),
                                                                          topLeft: Radius.circular(
                                                                              5),
                                                                          topRight:
                                                                              Radius.circular(5)),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            140,
                                                                        height:
                                                                            20,
                                                                        color: const Color(
                                                                            0xFF681128),
                                                                        //color: const Color(0xFF96482B),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          "Car Information",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Gap(10),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                              'Make:',
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blackColor)),
                                                                          const Gap(
                                                                              5),
                                                                          Text(
                                                                              widget.make,
                                                                              style: const TextStyle(fontSize: 16, color: blackColor)),
                                                                        ],
                                                                      ),
                                                                      const Gap(
                                                                          10),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                              'Model:',
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blackColor)),
                                                                          const Gap(
                                                                              10),
                                                                          Text(
                                                                              widget.model,
                                                                              style: const TextStyle(fontSize: 16, color: blackColor)),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Gap(6),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Text(
                                                                          'Year:',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: blackColor)),
                                                                      const Gap(
                                                                          10),
                                                                      Text(
                                                                          widget
                                                                              .year,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color: blackColor)),
                                                                    ],
                                                                  ),
                                                                  const Gap(10),
                                                                  Center(
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius: const BorderRadius
                                                                          .only(
                                                                          bottomLeft: Radius.circular(
                                                                              5),
                                                                          bottomRight: Radius.circular(
                                                                              5),
                                                                          topLeft: Radius.circular(
                                                                              5),
                                                                          topRight:
                                                                              Radius.circular(5)),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            20,
                                                                        color: const Color(
                                                                            0xFF681128),
                                                                        //color: const Color(0xFF96482B),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          "Problem Solution",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Gap(10),
                                                                  ClipRRect(
                                                                    borderRadius: const BorderRadius
                                                                        .only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10)),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          110,
                                                                      height:
                                                                          20,
                                                                      color: const Color(
                                                                          0xFF685c11),
                                                                      //color: const Color(0xFF96482B),
                                                                      child: Center(
                                                                          child: Text(
                                                                        'Fix:${(index + 1).toString()} ',
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      snapshot
                                                                          .data!
                                                                          .triages![
                                                                              index]
                                                                          .possibleissue
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              blackColor)),
                                                                  const Gap(10),
                                                                  ClipRRect(
                                                                    borderRadius: const BorderRadius
                                                                        .only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10)),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          110,
                                                                      height:
                                                                          20,
                                                                      color: const Color(
                                                                          0xFF685c11),
                                                                      //color: const Color(0xFF96482B),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'Solution: ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      snapshot
                                                                          .data!
                                                                          .triages![
                                                                              index]
                                                                          .description
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              blackColor)),
                                                                  const Gap(10),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                10.0),
                                                                        child: SizedBox(
                                                                            width: 100,
                                                                            height: 30,
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF681128)),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text(
                                                                                  'cancel',
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ))),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                });
                                              },
                                              child: Stack(
                                                children: [
                                                  Card(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    color: Colors.white,
                                                    elevation: 5,
                                                    shadowColor: Colors.black,
                                                    child: Container(
                                                      height: 150,
                                                      width: ProjectResource
                                                          .screenWidth,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: snapshot
                                                                      .data!
                                                                      .triages![
                                                                          index]
                                                                      .isSolution ==
                                                                  0
                                                              ? themeColor
                                                              : Colors.green
                                                                  .shade500,
                                                          // border: Border.all(width: 1, color: Colors.grey),

                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              child: Container(
                                                                width: 100,
                                                                height: 20,
                                                                color: const Color(
                                                                    0xFFDAB36A),
                                                                child: Center(
                                                                    child: Text(
                                                                  'Fix : ${(index + 1).toString()}',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                                snapshot
                                                                    .data!
                                                                    .triages![
                                                                        index]
                                                                    .possibleissue
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              child: Container(
                                                                width: 110,
                                                                height: 20,
                                                                color: const Color(
                                                                    0xFF5691C0),
                                                                //color: const Color(0xFF96482B),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  'Description: ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .triages![
                                                                      index]
                                                                  .description!
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: ProjectResource
                                                            .screenWidth *
                                                        0.7,
                                                    child: Checkbox(
                                                        value: snapshot
                                                                        .data!
                                                                        .triages![
                                                                            index]
                                                                        .isSolution ==
                                                                    1 ||
                                                                (currentid ==
                                                                        snapshot
                                                                            .data!
                                                                            .triages![
                                                                                index]
                                                                            .id &&
                                                                    isChecked ==
                                                                        true)
                                                            ? true
                                                            : false,
                                                        activeColor:
                                                            Colors.blue,
                                                        side: const BorderSide(
                                                          color: Colors.white,
                                                          width: 1.5,
                                                        ),
                                                        onChanged: (onChanged) {
                                                          setState(() {
                                                            //&& ProjectResource.loggedIn == snapshot.data!.triages![index].c// Only Post Created user can mark as complete
                                                            if (snapshot
                                                                    .data!
                                                                    .triages![
                                                                        index]
                                                                    .isSolution ==
                                                                0) {
                                                              isChecked =
                                                                  !isChecked;
                                                              currentid ==
                                                                  snapshot
                                                                      .data!
                                                                      .triages![
                                                                          index]
                                                                      .id;
                                                              requestDetailsController.problemSolve(
                                                                  context:
                                                                      context,
                                                                  id: snapshot
                                                                      .data!
                                                                      .triages![
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                            }
                                                          });
                                                        }),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: themeColor,
                                      ),
                                    );
                                  }
                                }))
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        floatingActionButton: Visibility(
          visible: isFabVisible,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: () {
                  //Navigator.push(context, SlideRightRoute(page: ChatBox(requestId: widget.requestId,email: widget.email,)));
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormFields(
                                  controller:
                                      requestDetailsController.issueController,
                                  minLines: 1,
                                  maxLines: 1,
                                  cursorColor: themeColor,
                                  keyboardType: TextInputType.text,
                                  enabledBorderSide:
                                      const BorderSide(color: Colors.grey),
                                  focusedBorderSide: const BorderSide(
                                      color: Colors.blueAccent),
                                  levelText: const Text('Issue'),
                                  validators: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter issue';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormFields(
                                  controller: requestDetailsController
                                      .descriptionController,
                                  // hint: 'Enter valid Email',
                                  // hintStyle: TextStyle(color: Colors.grey[400]),
                                  minLines: 1,
                                  maxLines: 1,
                                  cursorColor: themeColor,
                                  keyboardType: TextInputType.text,
                                  enabledBorderSide:
                                      const BorderSide(color: Colors.grey),
                                  focusedBorderSide: const BorderSide(
                                      color: Colors.blueAccent),
                                  levelText: const Text('Description'),
                                  validators: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter description';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: themeColor),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          requestDetailsController
                                              .addSolutionApis(
                                                  context: context);
                                        }
                                      },
                                      child: requestDetailsController.loading ==
                                              false
                                          ? const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          : const CircularProgressIndicator(
                                              color: Colors.white,
                                            )),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                label: const Text(
                  'Add Solution',
                  style: TextStyle(color: themeColor),
                ),
              ),
              FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () {
                  Navigator.push(
                      context,
                      SlideRightRoute(
                          page: ChatBox(
                        requestId: widget.requestId,
                      )));
                },
                label: const Row(
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      color: themeColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    //Text('All Replies')
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
