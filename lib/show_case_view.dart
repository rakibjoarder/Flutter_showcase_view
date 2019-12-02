import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';


class ShowCasePage extends StatefulWidget {
  @override
  _ShowCasePageState createState() => _ShowCasePageState();
}

class _ShowCasePageState extends State<ShowCasePage> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();


  setSharedPref(flag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('flag', flag);
  }

  getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var flag = prefs.getBool('flag') ?? false;
    return flag;
  }

  @override
  void initState() {
    super.initState();
    getSharedPref().then((flag){
      if(flag == false){
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            ShowCaseWidget.of(context).startShowCase([_one, _two, _three,]));
        setSharedPref(true);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Showcase(
                                  key: _one,
                                  description: 'Tap to see menu options',
//                                  disableAnimation: true,
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.black45,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Search email',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Showcase(
                            key: _two,
                            title: 'Profile',
                            description: 'Tap to see profile',
                            showcaseBackgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            shapeBorder: CircleBorder(),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: NetworkImage('https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/8_avatar-512.png'))
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),

              ],
            ),

          ],
        ),
      ),
      floatingActionButton: Showcase(
        key: _three,
        title: 'Compose Mail',
        description: 'Click here to compose mail',
        shapeBorder: CircleBorder(),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            setSharedPref(false);
            setState(() {
              ShowCaseWidget.of(context).startShowCase([_one, _two, _three,]);
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
