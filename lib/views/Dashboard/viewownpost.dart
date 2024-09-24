/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surefix_ai/views/Dashboard/profilescreen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:surefix_ai/views/iMech_screen/chatBox.dart';
import '../../controller/viewownpost_controller.dart';
import '../../helpers/ProjectResource.dart';

import '../../models/DashModel.dart';
import '../../services/data/databasehelper.dart';
import '../../services/route_manager.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../Auth/login/login.dart';
import '../iMech_screen/messangerscreen.dart';
import '../iMech_screen/requestDetails.dart';
import 'dashboard.dart';

class ViewOwnPost extends StatefulWidget {
  String? requestId ='';
   ViewOwnPost({super.key,this.requestId});

  @override
  _ViewOwnPostState createState() => _ViewOwnPostState();
}

class _ViewOwnPostState extends State<ViewOwnPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ViewOwnPostController viewOwnPostController;
  var searchText = '';
  int currentPage = 0;
  int resultsPerPage = 2;
  int startPage = 0;


  List<String> nameList = [];
  String? userType;

  @override
  void initState() {
    super.initState();
    shareData();
    viewOwnPostController = Provider.of<ViewOwnPostController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      viewOwnPostController.getOrgDashboardData(context: context);
      setState(() {
        viewOwnPostController.loadLocalData();
        viewOwnPostController.initRegister();
      });
      viewOwnPostController.clear();
    });
  }
  String formatDate(String dateString) {
    // Parse the API date (assuming it comes as a string)
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date (e.g., 'yyyy-MM-dd HH:mm:ss')
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  Future syncData()async{
   await viewOwnPostController.getOrgDashboardData(context: context);
    setState(() async{
     await viewOwnPostController.loadLocalData();

    });
  }
  shareData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      email = sp.getString('UserEmail');
      token = sp.getString('tokenSP');
      userType = sp.getString('usertype');
    });
  }


  String? email;
  String? token;


  Widget pagingButton() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          //page numbering text
          if (searchFilter.isNotEmpty)
            Text(
              'Page ${currentPage + 1} of ${(viewOwnPostController.userList.length / resultsPerPage).ceil()}',
              overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600,),),
          const SizedBox(height: 7),

          //page navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //first page button
              startPage > 0 && ((MediaQuery.of(context).size.width - 80) / 30).floor() < (searchFilter.length / resultsPerPage)
                          .ceil() ? SizedBox(width: 30,
                child: IconButton(
                    icon: const Icon(Icons.first_page),
                    onPressed: () {
                      setState(() {
                        startPage = 0;
                        currentPage = 0;
                      });
                    }),
              )
                  : const SizedBox(),
              //move backward button
              startPage > 0 &&
                  ((MediaQuery.of(context).size.width - 120) / 30).floor() <
                      (searchFilter.length / resultsPerPage)
                          .ceil()
                  ? SizedBox(
                width: 30,
                child: IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () {
                    setState(() {
                      startPage--;
                    });
                  },
                ),
              )
                  : const SizedBox(),
              //numbered page buttons
              for (int i = startPage;
              i <
                  min(
                      (((MediaQuery.of(context).size.width - 120) / 30)
                          .floor() +
                          startPage),
                      (searchFilter.length / resultsPerPage)
                          .ceil());
              i++)
                SizedBox(
                  width: 30,
                  height: 40,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor:
                    currentPage == i ? themeColor : Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentPage = i;
                        });
                      },
                      child: Text(
                        (i + 1).toString(),
                        style: currentPage == i
                            ? const TextStyle(color: Colors.white)
                            : const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              //move forward button
              (searchFilter.length / resultsPerPage).ceil() >
                  ((MediaQuery.of(context).size.width - 120) / 30)
                      .floor() &&
                  ((searchFilter.length / resultsPerPage)
                      .ceil() -
                      startPage) >
                      ((MediaQuery.of(context).size.width - 120) / 30)
                          .floor()
                  ? SizedBox(
                width: 30,
                child: IconButton(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () {
                      setState(() {
                        startPage++;
                      });
                    }),
              )
                  : const SizedBox(),
              //last page button
              (searchFilter.length / resultsPerPage).ceil() >
                  ((MediaQuery.of(context).size.width - 120) / 30)
                      .floor() &&
                  ((searchFilter.length / resultsPerPage)
                      .ceil() -
                      startPage) >
                      ((MediaQuery.of(context).size.width - 120) / 30)
                          .floor()
                  ? IconButton(
                icon: const Icon(Icons.last_page),
                onPressed: () {
                  setState(() {
                    startPage = (searchFilter.length /
                        resultsPerPage)
                        .ceil() -
                        ((MediaQuery.of(context).size.width - 120) / 30)
                            .floor();
                    currentPage = (searchFilter.length /
                        resultsPerPage)
                        .ceil() -
                        1;
                  });
                },
              )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  getSpacer() {
    return SizedBox(
      height: ProjectResource.screenHeight * .01,
    );
  }

  getSpacer2x() {
    return SizedBox(
      height: ProjectResource.screenHeight * .02,
    );
  }

  getHomeView() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: viewOwnPostController.loading
                ? const Center(
              child: CircularProgressIndicator(),)
                : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                //Search

                TextFormField(
                  controller: viewOwnPostController.searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toString();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            viewOwnPostController.searchController
                                .clear();
                            searchText = "";
                            // data = userdata;
                          });
                        },
                        icon: viewOwnPostController
                            .searchController.text.isEmpty
                            ? const SizedBox()
                            : const Icon(Icons.close,
                            color: Colors.black12)),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                 // future:  viewOwnPostController.getOrgDashboardData(context: context),
                   future:  viewOwnPostController.loadLocalData(),


                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        if(viewOwnPostController.userList.isEmpty){
                          return  const Center(
                              child: Text('Empty List',textAlign: TextAlign.center,)
                          );
                        }
                        else{
                          return SizedBox(
                            width: ProjectResource.screenWidth,
                            child: Column(
                              children: [
                                if (searchFilter.isNotEmpty)
                                  Text('${searchFilter.length} results'),
                                if (searchFilter.isNotEmpty)
                                  for (int i = 0;
                                  i <
                                      min(
                                          resultsPerPage,
                                          (searchFilter.length -
                                              (currentPage *
                                                  resultsPerPage)));
                                  i++)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RequestDetails(
                                                      requestId: searchFilter[
                                                      (currentPage *
                                                          resultsPerPage) +
                                                          i]
                                                          .id
                                                          .toString(),
                                                      nameData: searchFilter[
                                                      (currentPage *
                                                          resultsPerPage) +
                                                          i]
                                                          .title
                                                          .toString(),
                                                      descriptionData: searchFilter[
                                                      (currentPage *
                                                          resultsPerPage) +
                                                          i]
                                                          .description
                                                          .toString(),
                                                      make: searchFilter[(currentPage * resultsPerPage) + i].make.toString(),
                                                      model: searchFilter[(currentPage * resultsPerPage) + i].model.toString(),
                                                      year: searchFilter[(currentPage * resultsPerPage) + i].yearofmake.toString(),
                                                    )));
                                      },
                                      child: Card(
                                        elevation: 4,
                                        margin: const EdgeInsets.all(2),
                                        //color:Color.fromRGBO(69, 177, 248,0.5),
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          padding: const EdgeInsets.all(5),
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      searchFilter[(currentPage * resultsPerPage) + i].title!
                                                          .length > 101
                                                          ? '${searchFilter[(currentPage * resultsPerPage) + i].title!.substring(0, 100)}...'
                                                          : searchFilter[(currentPage * resultsPerPage) + i].title.toString(),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(searchFilter[(currentPage *
                                                        resultsPerPage) +
                                                        i]
                                                        .description
                                                        .toString(),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                const Row(
                                              children: [
                                                SizedBox(
                                                  width: 4,
                                                ),
                                               /* Text(searchFilter[(currentPage *
                                                    resultsPerPage) +
                                                    i]
                                                    .faultCode
                                                    .toString()),*/
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    height: 50,
                                                  ),
                                                  const Icon(
                                                    Icons.car_crash,
                                                    color: themeColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    searchFilter[(currentPage *
                                                        resultsPerPage) +
                                                        i]
                                                        .make
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    width: 25,
                                                  ),
                                                  Text(
                                                    searchFilter[(currentPage *
                                                        resultsPerPage) +
                                                        i]
                                                        .model
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    width: 25,
                                                  ),
                                                  Text(
                                                    searchFilter[(currentPage *
                                                        resultsPerPage) +
                                                        i]
                                                        .yearofmake
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                /*Text(
                  viewOwnPostController.userList[(currentPage * resultsPerPage) + i].message.toString(),
                                                          style: const TextStyle(fontSize: 14),
                                                        ),*/
                                                ],
                                              ),

                                              //  const SizedBox(height: 50),
                                              const Divider(
                                                color: themeColor,
                                                thickness: 1.0,
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  const Icon(Icons.person),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  const Text(
                                                    'Mrs Kamal',
                                                    style: TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(
                                                      Icons.calendar_month),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  /*Text(DateFormat("dd-MM-yyyy").parse(searchFilter[(currentPage * resultsPerPage) + i].createdAt.toString()).timeZoneName
                                                    , style: const TextStyle(fontSize: 12),
                                                  ),*/
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  userType == 'user'
                                                      ? const SizedBox()
                                                      : Row(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ChatBox(requestId: searchFilter[(currentPage * resultsPerPage) + i].id)));
                                                          },
                                                          child: const Icon(Icons.message)),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        searchFilter[(currentPage *
                                                            resultsPerPage) +
                                                            i]
                                                            .isSolved
                                                            .toString(),
                                                        //data[(currentPage * resultsPerPage) + i].issueResponsesCount.toString(),
                                                        style: const TextStyle(
                                                            fontSize:
                                                            14),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                const SizedBox(
                                  height: 50,
                                ),
                                pagingButton(),
                              ],
                            ),
                          );
                        }
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                              color: themeColor,
                            ));
                      }
                    })

              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  print(viewOwnPostController.dbHelper?.getItems().toString());
    ProjectResource.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Posts',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: themeColor,
        leading: IconButton(
          onPressed: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
            //Navigator.of(context).pop();;
          },
          icon: Image.asset(
            Images.backIcon,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            syncData();
          }, icon: const Icon(Icons.refresh_sharp,color: Colors.white,)),
          PopupMenuButton(
              icon: Icon(Icons.more_vert_outlined),
              iconColor: Colors.white,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Profile',
                          )
                        ],
                      )),
                  PopupMenuItem(
                      onTap: () {
                        Navigator.popUntil(context, (route) => false);
                        Navigator.push(
                            context, SlideRightRoute(page: LoginScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Logout')
                        ],
                      )),
                ];
              })
        ],
      ),
      //  drawer: const DrawerCustom(),
      body: getHomeView(),
    );
  }

  List<Requests> get searchFilter{
    if(searchText.isEmpty ){
      return viewOwnPostController.userList;
    }else{
      return viewOwnPostController.userList.where((item)=>item.title!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }

  }

}
