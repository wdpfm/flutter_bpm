import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController idController = TextEditingController();
  String showText = '0';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
      ),
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('心率计'),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: '心率id',
                      helperText: '请输入id',
                    ),
                    autofocus: false, //自动打开手机键盘
                  ),
                  RaisedButton(
                    onPressed: () {
                      _getBpm();
                    },
                    child: Text('输入完毕'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'BPM:',
                        style: TextStyle(
                          fontSize: 72,
                        ),
                      ),
                      Text(
                        showText,
                        overflow: TextOverflow.ellipsis, //超出内容省略号
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 72,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getBpm() {
    print('start get');
    if (idController.text.toString() == '') {
      setState(() {
        showText = ('id为空');
      });
    } else {
      getHttp(idController.text.toString()).then((val) {
        if(val.toString()=='0'){
          val='异常';
        }
        setState(() {
          showText = val.toString();
        });
      });
    }
  }

  Future getHttp(String idText) async {
    try {
      Response response;
      //var data={'id':1};
      response = await Dio().get(
        'http://api.zzxmy.xyz/bpm/$idText',
        //queryParameters: data,
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
