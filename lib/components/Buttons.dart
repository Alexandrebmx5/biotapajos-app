import 'package:biotapajos_app/components/DropDown.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget btInitial({context, String title, Function call}) {
  return Padding(
    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ))),
        onPressed: () {
          call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                title,
                style: TextStyle(color: PRIMARY, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: PRIMARY,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Center(
                    child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                )),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget btDropDown({context, String title, Function call}) {
  return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ))),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
              ),
              child: DropDown<String>(
                items: ['Português', 'English'],
                dropDownType: DropDownType.Button,
                showUnderline: false,
                customWidgets: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'images/brasil.jpg',
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Portugês',
                            style: TextStyle(color: PRIMARY),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'images/eua.jpg',
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'English',
                            style: TextStyle(color: PRIMARY),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                hint: Text(
                  title,
                  style: TextStyle(color: PRIMARY),
                ),
                onChanged: (value) {
                  call(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: PRIMARY,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ));
}

Widget btFilter({context, Function call}) {
  return DropDown<String>(
    items: ['name', 'color'],
    dropDownType: DropDownType.Button,
    showUnderline: false,
    customWidgets: [
      Text(S.of(context).nome),
      Text(S.of(context).cor),
    ],
    isCleared: true,
    hint: Icon(Icons.filter_list),
    onChanged: (value) {
      call(value);
    },
  );
}

Widget btLogin({
  @required Function call,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(100)),
    child: Container(
      width: 60,
      height: 60,
      color: Colors.white,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        onPressed: () {
          call();
        },
        child: Icon(
          Icons.arrow_forward_outlined,
          color: PRIMARY,
          size: 25,
        ),
      ),
    ),
  );
}

Widget btPrimaryIcon(
    {@required Function call, @required String title, Color color}) {
  return ElevatedButton.icon(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(PRIMARY)),
      onPressed: () {
        call();
      },
      icon: Icon(Icons.location_on, color: Colors.white),
      label: Text(title));
}
