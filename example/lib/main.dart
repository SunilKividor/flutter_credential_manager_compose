import 'package:credential_manager/credential_manager.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

const clientId = '';
final scopes = ['https://www.googleapis.com/auth/drive.file'];
const webClientId = '';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CredentialsScreen(),
    );
  }
}


final logger = Logger();
CredentialManager credentialManager = CredentialManager();

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({super.key});

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {


Future<void> signIn() async{
  
  try {
      if(credentialManager.isSupportedPlatform){
    await credentialManager.init(preferImmediatelyAvailableCredentials: true,
        googleClientId: webClientId, 
    );
      logger.d("Entered try");
     final gCredential= await credentialManager.saveGoogleCredential(nonce: Nonce(nonce: "jedn23iudbuyfb")); 
      final idToken = gCredential!.idToken;

  Logger().d("idToken : $idToken");
}
  } on CredentialException catch (e) {
     logger.d("caught exception");
     logger.d("error : ${e.code}");
     logger.d("error : ${e.details}");
    logger.d("error : ${e.message}");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Drive API Test'),
      ),

      body: Center(child: Column(
        children: [
          ElevatedButton(onPressed:signIn, child: const Text('Sign in')),
          // ElevatedButton(onPressed:createFile, child: const Text('Create File')),
        ],
      )),
    );
  }
}