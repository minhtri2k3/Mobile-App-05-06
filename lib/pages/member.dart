import 'package:createtest2/models/access_token.dart';
import 'package:createtest2/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../secure/flutter_secure_storage.dart';
import '../service/app_client.dart';

class SecondPage extends StatefulWidget {
  SecondPage({
    Key? key,
    required this.title,
    required this.client,
    required this.accessToken,
  }) : super(key: key);

  final String title;
  final ApiClient client;
  final AccessToken accessToken;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final SecureStorage secureStorage = SecureStorage();
  late ApiClient apiClient;
  User? userInfo;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    apiClient = widget.client;
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final token = await secureStorage.retrieveJwt();
      final user = await widget.client.getInfor('Bearer $token');
      print('${user.personal?.Address}');
      setState(() {
        userInfo = user;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text('Error: $errorMessage'))
          : _buildUserInfo(),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildUserInfoRow('FirstName', userInfo?.firstName ?? 'N/A'),
          _buildUserInfoRow('Lastname', userInfo?.lastName ?? 'N/A'),
          _buildUserInfoRow('Email', userInfo?.email ?? 'N/A'),
          _buildUserInfoRow('Age', userInfo?.personal?.Age?.toString() ?? 'N/A'),
          _buildUserInfoRow('Address', userInfo?.personal?.Address ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildUserInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$title: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
