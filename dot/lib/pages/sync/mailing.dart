//import 'dart:io';

//import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SendEmail extends StatefulWidget {
  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Attach File To Email'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            WaveWidget(
              duration: 2,
              config: CustomConfig(
                gradients: [
                  [Color(0xFF3bc2DB3), Color(0xFF3A2DB1)],
                  [Color(0xFFE472EE), Color(0xFFFF7D9C)],
                  [Color(0xFFfcfeff), Color(0xFFFFdbde)],
                  [Color(0xFF396aFF), Color(0xFF2948ff)]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.25, 0.5, 0.75, 1],
                blur: MaskFilter.blur(BlurStyle.outer, 5),
                gradientBegin: Alignment.bottomRight,
                gradientEnd: Alignment.bottomLeft,
              ),
              waveAmplitude: 2.0,
              backgroundColor: Colors.blue,
              size: Size(double.infinity, 130.0),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 100,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Card(
                elevation: 4,
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          'Press the botton bellow to generate csv file to downloads')),
                ),
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        onPressed: () => _sendEmail(),
                        color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("AttachFile")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        onPressed: getfile,//{
                          //final path =  FlutterDocumentPicker.openDocument();
                          //print(path);
                
            //  },
                         color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("Browse")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //File x;
  void _sendEmail() async {
    //debugPrint(x.path);
    final MailOptions mailOptions = MailOptions(
      body: 'hello from the pixelSalles app',
      subject: 'Report in CSV File',
      recipients: ['abrhaabadi88@gmail.com'],
      isHTML: false,
//      bccRecipients: ['other@example.com'],
//      ccRecipients: ['third@example.com'],
      //attachments: [ '/test.txt' ],
    );
try {
    await FlutterMailer.send(mailOptions);
     Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('File Attach Success!'),
                      duration: Duration(seconds: 3),
                    ));
} catch (e) {
  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(e),
                      duration: Duration(seconds: 3),
                    ));

}
  }
File x;
 Future<File>getfile() async{
    x= await FilePicker.getFile();
    return x;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory/
}

// Future<File> get _localFile async {
//   final path = await _localPath;

//   return new File('$path/data.txt'); //home/directory/data.txt
// }

// Future<String> readData() async {
//   try {
//     final file = await _localFile;

//     //Read
//     String data = await file.readAsString();

//     return data;
//   } catch (e) {
//     return "Nothing saved yet!";
//   }
// }
}

// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/material.dart';
// class SendEmail extends StatelessWidget {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _subjectController = TextEditingController();
//   TextEditingController _bodyController = TextEditingController();
//   _sendEmail() async {
//     final String _email = 'mailto:' +
//         _emailController.text +
//         '?subject=' +
//         _subjectController.text +
//         '&body=' +
//         _bodyController.text;
//     try {
//       await launch(_email);
//     } catch (e) {
//       throw 'Could not Call Phone';
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Call Phone from App Example')),
//       body: Center(
//           child: Column(
//         children: <Widget>[
//           TextField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               hintText: 'Email',
//             ),
//           ),

//           RaisedButton(
//             shape:RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10)
//             ),
//             child: Text('Send Email'),
//             color: Colors.red,

//             onPressed: _sendEmail,
//           ),
//         ],
//       )),
//     );
//   }
// }
