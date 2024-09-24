/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */




/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surefix_ai/views/Dashboard/profilescreen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../controller/searchhome_controller.dart';
import '../../helpers/ProjectResource.dart';
import '../../models/DashModel.dart';

import '../../services/route_manager.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../Auth/login/login.dart';
import '../iMech_screen/messangerscreen.dart';
import '../iMech_screen/requestDetails.dart';
import 'dashboard.dart';

class SearchAllPost extends StatefulWidget {
  const SearchAllPost({super.key});

  @override
  _SearchAllPostState createState() => _SearchAllPostState();
}

class _SearchAllPostState extends State<SearchAllPost> {
  var searchText = '';
  int currentPage = 0;
  int resultsPerPage = 2;
  int startPage = 0;
  List<Requests> data = [];
  String search ='';
  var loading = false;
  var loadingError = false;
  var isVisible1 =true;
  var isVisible2 =false;
  var isVisible3 =false;
  String? userType;
  String? email;
  String? token;



  @override
  void initState() {
    super.initState();
    shareData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchHomeController.initRegister();
      searchHomeController.clear();
    });
  }

  late SearchHomeController searchHomeController;
  late SearchHomeController searchHomeControllerVar;
  shareData()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userType = sp.getString('usertype');
      token = sp.getString('tokenSP');
    });
  }

  @override
  void didChangeDependencies() {
    searchHomeController = Provider.of<SearchHomeController>(context, listen: false);
    searchHomeControllerVar = Provider.of<SearchHomeController>(context, listen: true);
    super.didChangeDependencies();
  }
  Widget pagingButton(){

    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          //page numbering text
          if (searchFilter.isNotEmpty)
            Text(
              'Page ${currentPage + 1} of ${(searchFilter.length / resultsPerPage).ceil()}',overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 7),

          //page navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //first page button
              startPage > 0 &&
                  ((MediaQuery.of(context).size.width - 80) / 30).floor() <
                      (searchFilter.length / resultsPerPage).ceil()
                  ? SizedBox(
                width: 30,
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
                      (searchFilter.length / resultsPerPage).ceil()
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
                      (searchFilter.length / resultsPerPage).ceil());
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
                        style: currentPage == i ? const TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              //move forward button
              (searchFilter.length / resultsPerPage).ceil() >
                  ((MediaQuery.of(context).size.width - 120) / 30)
                      .floor() &&
                  ((searchFilter.length / resultsPerPage).ceil() -
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
                  ((searchFilter.length / resultsPerPage).ceil() -
                      startPage) >
                      ((MediaQuery.of(context).size.width - 120) / 30)
                          .floor()
                  ? IconButton(
                icon: const Icon(Icons.last_page),
                onPressed: () {
                  setState(() {
                    startPage = (searchFilter.length / resultsPerPage)
                        .ceil() -
                        ((MediaQuery.of(context).size.width - 120) / 30)
                            .floor();
                    currentPage =
                        (searchFilter.length / resultsPerPage).ceil() - 1;
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
  getOrgDashboardData({context}){
    loading = false;
  }

  @override
  void dispose() {
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

    getItem(String name, double value, IconData iconData,Color backgroundColor,Color iconBackgroundColor,Color iconForegroundColor) {
      return InkWell(
        child: Container(
          width: ProjectResource.screenWidth * .44,
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color:backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            // padding: EdgeInsets.all(15),
            child: Container(
              // width: 200,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 22,
                      backgroundColor: iconBackgroundColor,
                      foregroundColor: iconForegroundColor,
                      child: Icon(iconData)),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(name, style: TextStyle(color: colorTitle,fontSize: ProjectResource.headerFontSize! *.7, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Text("${value.toInt() }", style: const TextStyle(fontSize: 16),),  const SizedBox(height: 5,),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20,top:10),
        child:
        searchHomeControllerVar.loading ?
        const Center(child: CircularProgressIndicator(),) :
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5,),
              //Search
              TextFormField(
                controller: searchHomeController.searchController,
                onChanged: (value){
                  setState(() {
                    searchText =value.toString();
                  });
                },
                decoration: InputDecoration(
                  fillColor:  Colors.white,
                  filled: true,
                  hintText: 'Search',
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      searchHomeController.searchController.clear();
                      searchText ='';
                    });
                  }, icon: const Icon(Icons.close)),
                  border: const OutlineInputBorder(),
                ),

              ),

              const SizedBox(height: 10,),

              FutureBuilder<DashModel>(
                  future: searchHomeController.getOrgDashboardData(context: context,),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: ProjectResource.screenWidth,
                        child: Column(
                          children: [
                            if (searchFilter.isNotEmpty) Text('${searchFilter.length} results'),
                            if (searchFilter.isNotEmpty)
                              for (int i = 0; i <min(resultsPerPage,
                                  (searchFilter.length - (currentPage * resultsPerPage))); i++)

                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  RequestDetails(requestId:  searchFilter[(currentPage * resultsPerPage) + i].id.toString(), nameData:  searchFilter[(currentPage * resultsPerPage) + i].title.toString(),
                                      descriptionData:  searchFilter[(currentPage * resultsPerPage) + i].description.toString(),
                                      make: searchFilter[(currentPage * resultsPerPage) + i].make.toString(),
                                      model: searchFilter[(currentPage * resultsPerPage) + i].model.toString(),
                                      year: searchFilter[(currentPage * resultsPerPage) + i].yearofmake.toString(),
                                    )));

                                  },
                                  child: Card(
                                    elevation:4,
                                    margin: const EdgeInsets.all(2),
                                    //color:Color.fromRGBO(69, 177, 248,0.5),
                                    child: Container(
                                      width: double.infinity,
                                      height: 200,
                                      padding: const EdgeInsets.all(5),
                                      color:Colors.white,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(width: 4,),
                                              Expanded(
                                                child: Text(
                                                  searchFilter[(currentPage * resultsPerPage) + i].title!.length > 101 ? '${searchFilter[(currentPage * resultsPerPage) + i].title!.substring(0, 100)}...' : searchFilter[(currentPage * resultsPerPage) + i].title.toString(),
                                                  overflow: TextOverflow.ellipsis,maxLines: 2,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const SizedBox(width: 4,),
                                              Expanded(
                                                child: Text(
                                                    searchFilter[(currentPage * resultsPerPage) + i].description
                                                        .toString(),maxLines: 1,overflow: TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),

                                          Row(
                                            children: [
                                              const SizedBox(height: 50,),
                                              const Icon(Icons.car_crash,color: themeColor,),
                                              const SizedBox(width: 20,),
                                              Text( searchFilter[(currentPage * resultsPerPage) + i].make.toString(),style: TextStyle(fontSize: 14),),
                                              const SizedBox(width: 25,),
                                              Text( searchFilter[(currentPage * resultsPerPage) + i].model.toString(),style: TextStyle(fontSize: 14),),
                                              const SizedBox(width: 25,),
                                              Text(searchFilter[(currentPage * resultsPerPage) + i].yearofmake.toString(),style: TextStyle(fontSize: 14),),
                                            ],
                                          ),


                                          //  const SizedBox(height: 50),
                                          const Divider(color: themeColor,thickness: 1.0,),
                                          Row(
                                            children: [
                                              const SizedBox(width: 4,),
                                              const Icon(Icons.person),
                                              const SizedBox(width: 6,),
                                              const Text('Mrs Kamal', style: TextStyle(fontSize: 14),),
                                              const SizedBox(width: 5,),
                                              const Icon(Icons.calendar_month),
                                              const SizedBox(width: 6,),
                                              // Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(searchFilter[(currentPage * resultsPerPage) + i].createdAt.toString())),),
                                              const SizedBox(width: 4,),
                                              userType == 'user'?const SizedBox():Row(
                                                children: [
                                                  InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const MessengerScreen()));
                                                      },
                                                      child: const Icon(Icons.message)),
                                                  const SizedBox(width: 4,),
                                                  Text(0.toString(),
                                                    //data[(currentPage * resultsPerPage) + i].issueResponsesCount.toString(),
                                                    style: const TextStyle(fontSize: 14),
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

                            const SizedBox(height: 50,),

                            pagingButton(),
                          ],
                        ),
                      );
                    } else {
                      return Shimmer.fromColors(
                          baseColor:Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: SizedBox(
                            width: double.infinity,
                            height: 700,
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
                          )
                      );
                    }
                  }),

            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: themeColor,
        leading:IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
            //Navigator.of(context).pop();
          },
          icon: Image.asset(Images.backIcon,color: Colors.white,),
        ),

        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert_outlined),
              iconColor: Colors.white,
              itemBuilder: (context){
                return [
                  PopupMenuItem(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 8,),
                          Text('Profile',)
                        ],
                      )),
                  PopupMenuItem(
                      onTap: (){
                        Navigator.popUntil(context, (route) => false);
                        Navigator.push(context, SlideRightRoute(page: LoginScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8,),
                          Text('Logout')
                        ],
                      )),
                ];
              })
        ],
      ),
      body: getHomeView(),

    );
  }
  List<Requests> get searchFilter{
    if(searchText.isEmpty ){
      return searchHomeController.allDataList;
    }else{
      return searchHomeController.allDataList.where((item)=>item.title!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }

  }
}

