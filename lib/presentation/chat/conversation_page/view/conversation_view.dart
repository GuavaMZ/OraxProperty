import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/chat/conversation_page/viewmodel/conversation_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class ConversationView extends StatefulWidget {
  ConversationView({super.key, this.userToChatWithData});
  Map<String, dynamic>? userToChatWithData;
  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  final ConversationViewModel _viewModel = ConversationViewModel();
  late Stream stream;
  @override
  void initState() {
    stream = _viewModel.getMessages(widget.userToChatWithData!['chat_id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userToChatWithData);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorManager.lightGreenColor,
            )),
        title: Row(
          children: [
            Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.greyColor,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 1.77),
                          color: ColorManager.chatProfilePicShadowColor)
                    ],
                    border: Border.all(
                        color: ColorManager.chatProfilePicColor, width: 1.77)),
                child: widget.userToChatWithData!['profile_photo'] == null
                    ? TextContainer(
                        text: widget.userToChatWithData!['full_name'][0],
                        textAlign: TextAlign.center,
                        align: Alignment.center,
                        fontSize: 18)
                    : ExtendedImage.network(
                        supabase.storage.from('users_profile').getPublicUrl(
                            widget.userToChatWithData!['profile_photo']
                                .toString()
                                .split('/')
                                .last),
                        shape: BoxShape.circle,
                        compressionRatio: 0.5,
                      )),
            SizedBox(
              width: displayWidth(context) * 0.03,
            ),
            TextContainer(
              width: displayWidth(context) * 0.55,
              text: widget.userToChatWithData!['full_name'],
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: ColorManager.fontColor3,
            ),
            PopupMenuButton(
              icon: SvgPicture.asset(ImageAssets.moreButtonIcon),
              itemBuilder: (BuildContext context) => [],
            )
          ],
        ),
      ),
      bottomSheet: Container(
        alignment: const Alignment(0, 0.96),
        height: displayHeight(context) * 0.1,
        color: ColorManager.bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInputField(
              controller: _viewModel.messageTextController,
              width: displayWidth(context) * 0.8,
              height: displayHeight(context) * 0.073,
              enabledBorderRadius: displayHeight(context) * 0.034,
              focusedBorderRadius: displayHeight(context) * 0.034,
              errorBorderRadius: displayHeight(context) * 0.034,
              maxLines: 1,
              obsecureText: false,
              hintText: AppStrings.chatPromptText.getString(context),
              fillColor: ColorManager.chatPromptColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: displayWidth(context) * 0.04,
                  vertical: displayHeight(context) * 0.017),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    elevation: 0,
                    backgroundColor: ColorManager.lightGreenColor,
                    minimumSize: Size(displayWidth(context) * 0.15,
                        displayHeight(context) * 0.06)),
                onPressed: () async {
                  if (_viewModel.messageTextController.text.isNotEmpty) {
                    await _viewModel.sendMessage(
                        widget.userToChatWithData!['chat_id'],
                        _viewModel.messageTextController.text,
                        supabase.auth.currentUser!.id,
                        true,
                        widget.userToChatWithData!['usr1'] ==
                                supabase.auth.currentUser!.id
                            ? widget.userToChatWithData!['usr2']
                            : widget.userToChatWithData!['usr1']);
                    _viewModel.messageTextController.clear();
                  } else {
                    // Fluttertoast.sho
                  }
                },
                child: Transform.rotate(
                    angle: -0.5,
                    child: Icon(
                      Icons.send,
                      color: ColorManager.whiteColor,
                      size: displayWidth(context) * 0.065,
                    )))
          ],
        ),
      ),
      backgroundColor: ColorManager.bgColor,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => ConversationViewModel(),
        child: Consumer<ConversationViewModel>(
          builder: (BuildContext context, viewModel, Widget? child) =>
              StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color.fromRGBO(12, 77, 62, 1),
                      rightDotColor: ColorManager.lightGreenColor,
                      size: displayWidth(context) * 0.15),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.fromLTRB(
                      0, AppPadding.p10, 0, displayHeight(context) * 0.11),
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data[index]['sender'] ==
                        supabase.auth.currentUser!.id) {
                      return SentMessageBubbleChat(
                        message: snapshot.data[index]['content'],
                        time: snapshot.data[index]['created_at']
                            .toString()
                            .split('.')
                            .first
                            .split('T')
                            .join(' '),
                      );
                    } else {
                      // _viewModel.flutterLocalNotificationsPlugin.show(
                      //   111,
                      //   'New Message',
                      //   snapshot.data[index]['content'],
                      //   const NotificationDetails(
                      //     android: AndroidNotificationDetails(
                      //         'high_importance_channel', // id
                      //         'High Importance Notifications', // title
                      //         icon: '@mipmap/ic_launcher',
                      //         importance: Importance.high),
                      //   ),
                      // );
                      return ReceivedMessageBubbleChat(
                        message: snapshot.data[index]['content'],
                        time: snapshot.data[index]['created_at']
                            .toString()
                            .split('.')
                            .first
                            .split('T')
                            .join(' '),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
