import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_style.dart';


class ProfileAppBar extends StatefulWidget {
  final String name;

  const ProfileAppBar({super.key, required this.name});

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.14,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff1F6EC3),
            Color(0xff155293),
            Color(0xff155293),
          ])),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [


                Column(children: [
                  Text('مرحبا بك',
                      style: boldStyle(color: Colors.white, fontSize: 20)),
                  Text(
                    widget.name,
                    style: boldStyle(color: Colors.white, fontSize: 20),
                    overflow: TextOverflow.clip,
                  ),
                ]),
                const SizedBox(
                  width: 5,
                ),

              ],
            ),
          ),
        ),



      ],
    );
  }
}
