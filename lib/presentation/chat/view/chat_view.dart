import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/chat/viewmodel/chat_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorManager.bgColor,
      appBar: AppBar(
        title: TextContainer(
          text: AppStrings.chatText.getString(context),
          color: ColorManager.blackColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          margin: const EdgeInsets.only(top: AppMargin.m10),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => ChatViewModel(),
        child: SingleChildScrollView(
          child: Consumer<ChatViewModel>(
            builder: (BuildContext context, viewModel, Widget? child) =>
                StreamBuilder(
                    stream: viewModel.getUserChats(),
                    builder: (context, AsyncSnapshot snapshot) {
                      // print(snapshot.data);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.data.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextContainer(
                                width: displayWidth(context),
                                height: displayHeight(context) * 0.85,
                                text:
                                    AppStrings.emptyChatText.getString(context),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.fontColor3,
                                textAlign: TextAlign.center,
                                align: Alignment.center,
                              )
                            ],
                          );
                        } else {
                          return ListView.builder(
                              primary: false,
                              padding: EdgeInsets.symmetric(
                                  horizontal: displayWidth(context) * 0.03,
                                  vertical: displayHeight(context) * 0.045),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                    key: Key('$index'),
                                    onDismissed: (direction) {
                                      setState(() {});
                                    },
                                    confirmDismiss: (b) {
                                      return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: TextContainer(
                                              text: 'Are You Sure',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.fontColor3,
                                              textAlign: TextAlign.center,
                                            ),
                                            backgroundColor:
                                                ColorManager.whiteColor,
                                            surfaceTintColor:
                                                ColorManager.whiteColor,
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actionsPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        displayWidth(context) *
                                                            0.1),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  context.pop(true);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        ColorManager.whiteColor,
                                                    minimumSize: Size(
                                                        displayWidth(context) *
                                                            0.2,
                                                        displayHeight(context) *
                                                            0.04)),
                                                child: TextContainer(
                                                  text: AppStrings.yesText,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.fontColor3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                height: AppSize.s10,
                                                width: AppSize.s1,
                                                color: ColorManager.blackColor,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  context.pop(false);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        ColorManager.whiteColor,
                                                    minimumSize: Size(
                                                        displayWidth(context) *
                                                            0.2,
                                                        displayHeight(context) *
                                                            0.04)),
                                                child: TextContainer(
                                                  text: AppStrings.noText,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.fontColor3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                            // content: RoundedContainer(
                                            //   radius: displayHeight(context) * 0.035,
                                            //   width: displayWidth(context) * 0.85,
                                            //   height: displayHeight(context) * 0.25,
                                            //   color: ColorManager.whiteColor,
                                            //   // child: ,
                                            // ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: displayWidth(context) * 0.9,
                                      height: displayHeight(context) * 0.095,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              displayHeight(context) * 0.02),
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 4,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.push(
                                              '/chats/conversations/view',extra: snapshot.data[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorManager.whiteColor,
                                            elevation: 0,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    displayWidth(context) *
                                                        0.03),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                                backgroundColor:
                                                    ColorManager.lightGreyColor,
                                                radius: displayHeight(context) *
                                                    0.035,
                                                child: snapshot.data[index]
                                                            ['profile_photo'] ==
                                                        null
                                                    ? TextContainer(
                                                        text: snapshot
                                                                    .data[index]
                                                                ['full_name']
                                                            [0],
                                                        fontSize: 20)
                                                    : ExtendedImage.network(
                                                        supabase.storage
                                                            .from(
                                                                'users_profile')
                                                            .getPublicUrl(snapshot
                                                                .data[index][
                                                                    'profile_photo']
                                                                .toString()
                                                                .split('/')
                                                                .last),
                                                        shape: BoxShape.circle,
                                                        compressionRatio: 0.5,
                                                      )),
                                            SizedBox(
                                              width:
                                                  displayWidth(context) * 0.045,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextContainer(
                                                  text: snapshot.data[index]
                                                      ['full_name'],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.fontColor3,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              });
                        }
                      } else {
                        return Center(
                          child: TextContainer(
                            fontSize: 24,
                            text: "Error 404",
                          ),
                        );
                      }
                    }),
          ),
        ),
      ),
    );
  }
}
