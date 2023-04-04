import 'package:flutter/material.dart';
import 'package:job_app/app/presentation/pages/widgets/card_clipper.dart';
import 'package:job_app/app/presentation/pages/widgets/card_painter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //ottengo le dimensioni del dispositivo:
    var mSize = MediaQuery.of(context).size;
    //salvo larghezza e altezza
    var mWidth = mSize.width; //Larghezza
    var mHeight = mSize.height; //Altezza

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.corporate_fare),
            label: "Aziende",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Preferiti",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Freelancers",
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  height: 0.1 * mHeight,
                  color: Colors.amber,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: TextEditingController(),
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        hintText: "Enter Text",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        filled: true,
                        fillColor: Color(0xfff2f2f3),
                        isDense: false,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        prefixIcon: Icon(Icons.search,
                            color: Color(0xff212435), size: 24),
                        suffixIcon: Icon(Icons.filter_alt_outlined,
                            color: Color(0xff212435), size: 24),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 0.2 * mHeight,
                  color: Colors.deepOrange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 0.15 * mHeight,
                          child: Card(
                            color: Colors.greenAccent,
                            child: Text("tot annunci"),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.yellow,
                          height: 0.15 * mHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 0.075 * mHeight,
                                width: 0.75 * mWidth,
                                child: Card(
                                  color: Colors.blueGrey,
                                  child: Text("tot aziende"),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 0.075 * mHeight,
                                width: 0.75 * mWidth,
                                child: Card(
                                  color: Colors.blueAccent,
                                  child: Text("tot aziende"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.deepPurple,
                )),
              ],
            )),
      ),
    );
  }
}
