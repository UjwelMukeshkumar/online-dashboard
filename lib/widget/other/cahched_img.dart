// import 'package:avatar_letter/avatar_letter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';

class CachedImg extends StatelessWidget {
  const CachedImg(
      {Key? key,
      required this.url,
      required this.itemName,
      this.isSmall = false})
      : super(key: key);

  final String url;
  final String itemName;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.scaleDown,
      imageUrl: url,
      placeholder: (context, url) => Image.asset(
        'assets/loading.gif',
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) {
        print("image Erro ${error.toString()}");
        return Padding(
          padding: EdgeInsets.all(isSmall ? 4 : 18.0),
          child: CircleAvatar(
            backgroundColor: AppColor.notificationBackgroud,
            child: Center(
              child: Text(
                '${itemName.length == 0 ? "N" : itemName[0]}',
                style:
                    TextStyle(fontSize: isSmall ? 25 : 40.0, color: Colors.white),
              ),
            ),
          ),
          // child: AvatarLetter(
          //   backgroundColor: AppColor.notificationBackgroud,
          //   textColor: Colors.white,
          //   fontSize: isSmall?25:40.0,
          //   upperCase: true,
          //   numberLetters: 1,
          //   letterType: LetterType.Circular,
          //   text: '${itemName.length==0?"N":itemName}',

          // ),
        );
        return Center(
            child: Text("${itemName.characters.first}",
                style: Theme.of(context).textTheme.headline3));
        // return Icon(Icons.error);
      },
    );
  }
}
