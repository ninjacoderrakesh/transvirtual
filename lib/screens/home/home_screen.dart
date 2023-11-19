import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/connectivity/connectivity_cubit.dart';
import '../../business_logic/cubit/time_cubit/time_cubit.dart';
import '../../business_logic/cubit/user_cubit/user_cubit.dart';
import '../../data/models/base/user_data/user_data.dart';
import '../../widgets/default_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/default_text_span.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/football.png",
              height: 10.h,
              width: 10.w,
              color: Colors.blue,
            ),
            SizedBox(
              width: 2.w,
            ),
            Flexible(
                child: DefaultRichText(
                    text: defaultTextSpan(children: [
              defaultTextSpan(
                  text: 'Trans',
                  color: const Color(0XFF4C489B),
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp),
              defaultTextSpan(
                  text: 'Virtual',
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp),
            ])))
          ],
        ),
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dashboard",
                    style: TextStyle(
                        color: const Color(0XFF4C489B),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  BlocBuilder<TimeCubit, TimeState>(
                    builder: (context, state) {
                      return Text(
                        state.currentTime,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0XFF4C489B),
                            fontWeight: FontWeight.w500),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              buildContainerWithImageAndTitle(
                  "Search", "assets/image/search.png"),
              SizedBox(
                height: 2.h,
              ),
              buildContainerWithImageAndTitle(
                  "Movements", "assets/image/trolley.png"),
              SizedBox(
                height: 2.h,
              ),
              buildContainerWithImageAndTitle(
                  "Stock Take", "assets/image/to-do-list.png"),
              SizedBox(
                height: 2.h,
              ),
              const UserDetails(),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Text(
                      "Privacy",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.orange,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: (){},

                    child: Text(
                      "Legal",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.orange,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Copyright @ 2014-2023 Rapid Teks. All rights reserved",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainerWithImageAndTitle(String title, String image) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 8.h,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              color: Colors.white,
              height: 4.h,
              width: 4.h,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConnectivityCubit>(context).checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0, 0.4, 0.4],
          colors: [
            Colors.blueAccent.withOpacity(0.05),
            Colors.blueAccent.withOpacity(0.05),
            Colors.white
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      child: BlocBuilder<UserCubit, UserData?>(
        builder: (context, userData) {
          if (userData != null) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildRow(
                      "TransVirtual #", userData.transVirtualNumber.toString()),
                  const Divider(color: Colors.blueGrey),
                  buildRow("Company", userData.currentClientName.toString()),
                  const Divider(color: Colors.blueGrey),
                  buildRow("Warehouse", userData.warehouseTitle),
                  const Divider(color: Colors.blueGrey),
                  buildRow("Login", userData.currentUserShortName.toString()),
                  const Divider(color: Colors.blueGrey),
                  BlocBuilder<ConnectivityCubit, ConnectivityState>(
                    builder: (context, state) {
                      if (state is ConnectivityConnected) {
                        return buildRow(
                            "Status", "Connected via ${state.source}");
                      } else if (state is ConnectivityDisconnected) {
                        return buildRow("Status", "Disconnected");
                      } else {
                        // Loading state or initial state
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('User data not available.'),
            );
          }
        },
      ),
    );
  }

  Widget buildRow(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 30.w,
              child: Text(title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF4C489B),
                  ))),
          SizedBox(
            width: 1.w,
          ),
          SizedBox(
              width: 45.w,
              child: Text(content, style: const TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}
