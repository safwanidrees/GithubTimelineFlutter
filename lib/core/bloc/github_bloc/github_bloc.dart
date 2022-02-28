import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_flutter/core/networking/exception.dart';
import 'package:github_flutter/core/repository/github_repository.dart';
import 'package:github_flutter/model/repositries.dart';
import 'package:github_flutter/model/user.dart';
import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/utils/alert_message.dart';
import 'package:github_flutter/widgets/loader_dialog.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
//Local imports
import 'package:github_flutter/core/helper/file_saver_mobile.dart'
    if (dart.library.html) 'package:github_flutter/core/helper/file_saver_web.dart';

class GithubBloc with ChangeNotifier {
  final Dio _dio = Dio();

  final _githubRepository = GithubRepository();

  List<Repositries>? _currentUserRepoList;
  List<Repositries> get currentUserRepoList => [..._currentUserRepoList!];

  User? _currentUser = User();
  User? get currentUser => _currentUser;

  CustomException? _currentUserException;
  CustomException? get currentUserException => _currentUserException;
  CustomException? _userRepositriesListException;
  CustomException? get userRepositriesListException =>
      _userRepositriesListException;

  CurrentUserRepoListState _currentUserRepoListState =
      CurrentUserRepoListState.initial;
  CurrentUserRepoListState get currentUserRepoListState =>
      _currentUserRepoListState;

  ActionUserListState _currentActionUserListState = ActionUserListState.initial;
  ActionUserListState get currenActionUserListState =>
      _currentActionUserListState;

  CustomException? _actionUserListException;
  CustomException? get actionUserListException => _actionUserListException;

  CurrentUserState _currentUserState = CurrentUserState.initial;
  CurrentUserState get currentUserState => _currentUserState;

  String? _currentUserName = "";
  String? get currentUserName => _currentUserName;

  List<User> _usersList = [];
  List<User> get usersList => [..._usersList];

  void setCurrentUserName(String name) => _currentUserName = name;

  void setCurrentUserRepoListState(CurrentUserRepoListState state) {
    _currentUserRepoListState = state;
    notifyListeners();
  }

  void setCurrentUserState(CurrentUserState state) {
    _currentUserState = state;
    notifyListeners();
  }

  void setActionUserListState(ActionUserListState state) {
    _currentActionUserListState = state;
    notifyListeners();
  }

  void clearUserList() {
    _usersList.clear();
  }

//Get user repositries list
  Future<void> getuserRepositriesList(String? username) async {
    try {
      setCurrentUserRepoListState(CurrentUserRepoListState.loading);
      List<Repositries> _list = [];
      _list = await _githubRepository.getuserRepositriesList(username);
      _currentUserRepoList = _list;
      _currentUserRepoList!.sort((a, b) => b.stars!.compareTo(a.stars!));
      setCurrentUserRepoListState(CurrentUserRepoListState.loaded);
    } catch (e) {
      if (e.toString().toLowerCase().contains("not found")) {
        _userRepositriesListException =
            CustomException("Repositories Not Found");
      } else {
        _userRepositriesListException = CustomException(e.toString());
        setCurrentUserRepoListState(CurrentUserRepoListState.error);
      }
    }
  }

//Get User Profile
  Future<void> getUserProfile(String? username) async {
    try {
      setCurrentUserState(CurrentUserState.loading);
      User _user;
      _user = await _githubRepository.getUserProfile(username);
      _currentUser = _user;
      setCurrentUserState(CurrentUserState.loaded);
    } catch (e) {
      if (e.toString().toLowerCase().contains("not found")) {
        _currentUserException = CustomException("User Not Found");
      } else {
        _currentUserException = CustomException(e.toString());

        setCurrentUserState(CurrentUserState.error);
      }
    }
  }

// Get User List
  Future<void> getActionUserList(
      String? username, ActionUserListType actionUserListType,
      {String? repoName}) async {
    try {
      setActionUserListState(ActionUserListState.loading);
      List<User> _list = [];

      if (actionUserListType == ActionUserListType.star ||
          actionUserListType == ActionUserListType.forks) {
        _list = await _githubRepository.getRepoActionUserList(
            username, actionUserListType, repoName);
        _usersList = _list;
      } else {
        _list = await _githubRepository.getActionUserList(
            username, actionUserListType);
        _usersList = _list;
      }

      setActionUserListState(ActionUserListState.loaded);
    } catch (e) {
      _actionUserListException = CustomException(e.toString());
      setActionUserListState(ActionUserListState.error);
    }
  }

//Start download
  Future<void> _startDownload(String savePath, String url) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(url, savePath, deleteOnError: true);

      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (e) {
      result['error'] = e.toString();
    }
  }

//Downloading the repository
  void downloadRepository(String? repourl, BuildContext context) async {
    if (repourl != null) {
      String downloadUrl = "$repourl/archive/refs/heads/master.zip";

      showDialog(
          context: context,
          builder: (context) => const LoaderDialog(),
          barrierDismissible: false);
      if (!kIsWeb) {
        Directory? dir;
        if (Platform.isAndroid) {
          dir = await getExternalStorageDirectory();
        } else {
          dir = await getApplicationDocumentsDirectory();
        }
        String fileName = "master";

        final savePath = path.join(
          dir!.path,
          fileName,
        );
        await _startDownload(savePath, downloadUrl);
        File file = File(savePath);

        Uint8List bytes = file.readAsBytesSync();
        Uint8List data = Uint8List.fromList(bytes);
        Navigator.pop(context);
        await FileSaverHelper.saveAndLaunchFile(data, fileName);
      } else {
        await FileSaverHelper.saveAndLaunchFile(Uint8List(1), downloadUrl);
      }
    }
  }

  void copyRepository(String? url) {
    if (url != null) {
      Clipboard.setData(ClipboardData(text: url));
      AlertMessage.showAlertMessage("Link Copied");
    }
  }

  void shareRepository(String? url, BuildContext context) async {
    if (url != null) {
      showDialog(
          context: context,
          builder: (context) => const LoaderDialog(),
          barrierDismissible: false);
      Directory? dir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      String fileName = "master.zip";

      final savePath = path.join(
        dir!.path,
        fileName,
      );
      String downloadUrl = "$url/archive/refs/heads/master.zip";
      await _startDownload(savePath, downloadUrl);

      File file = File(savePath);

      Navigator.of(context).pop();
      ShareExtend.share(file.path, "file", subject: "Hey Thay is my Repo");
    }
  }
}
