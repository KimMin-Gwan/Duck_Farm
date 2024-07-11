import 'package:cheese/src/bloc/image_upload/image_upload_bloc.dart';
import 'package:cheese/src/model/user_model.dart';
import 'package:cheese/src/ui/agreement_raw_widget.dart';
import 'package:cheese/src/ui/bias_following_widget.dart';
import 'package:cheese/src/ui/change_password_widget.dart';
import 'package:cheese/src/ui/complete_sign_up_widget.dart';
import 'package:cheese/src/ui/first_visitor_widget.dart';
import 'package:cheese/src/ui/forget_password_widget.dart';
import 'package:cheese/src/ui/image_detail_widget.dart';
import 'package:cheese/src/ui/image_list_by_category_schedule_widget.dart';
import 'package:cheese/src/ui/image_list_category_widget.dart';
import 'package:cheese/src/ui/login_try_widget.dart';
import 'package:cheese/src/ui/login_widget.dart';
import 'package:cheese/src/ui/member_info_widget.dart';
import 'package:cheese/src/ui/member_login_widget.dart';
import 'package:cheese/src/ui/password_create_widget.dart';
import 'package:cheese/src/ui/upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/ui/home_widget.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/resources/core_repository.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/bloc/image_upload/image_upload_bloc.dart';
import 'package:cheese/src/test_page.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final UserRepository userRepository = UserRepository();
  final CoreRepository coreRepository = CoreRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CoreBloc>(
            create: (BuildContext context) => CoreBloc(userRepository, coreRepository),
          ),
          BlocProvider<ImageUploadBloc>(
            create: (BuildContext context) => ImageUploadBloc(),
          ),
        ],
        child: const MaterialApp(
          title: 'Cheese_proto',
          home: StartCheese()
        ));
  }
}

class StartCheese extends StatelessWidget {
  const StartCheese({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CoreBloc>(context).add(NoneBiasHomeDataEvent.none_date());
    return HomePage();
  }
}

