import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_for_jooca/utilities.dart';
import 'package:test_for_jooca/view/home_displayView.dart';
import 'package:test_for_jooca/view/home_loadingView.dart';

import '../viewModel/home_viewModel.dart';
import 'home_errorView.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _controller = TextEditingController(text: "");

  late HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = ref.read(homeViewModelProvider);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: widthFactor * 300,
        leading: Padding(
          padding: EdgeInsets.only(left: widthFactor * 15),
          child: TextField(
            obscureText: false,
            controller: _controller,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.grey,
              hintText: "Enter location name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0, style: BorderStyle.none,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: widthFactor * 16, vertical: heightFactor * 20),
            ),
          ),
        ),
        actions: <Widget>[
          Consumer(builder: (context, ref, child) {
            final state = ref.watch(homeViewModelProvider);

            return IconButton(
              icon: Icon(
                Icons.input,
                color: state.isLoading ? Colors.grey.withOpacity(0.6) : Colors.black,
              ),
              onPressed: () {
                if(state.isLoading) {
                  return;
                }

                if(_controller.text.isEmpty) {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        content: const Text('Please enter location name'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                
                FocusManager.instance.primaryFocus?.unfocus();
                viewModel.fetchData(_controller.text);
              },
            );
          }),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer(builder: (context, ref, child) {
        final state = ref.watch(homeViewModelProvider);

        if (state.isLoading) {
          return const LoadingView();
        }

        if (state.errorResponse != null) {
          return ErrorView(errorResponse: state.errorResponse);
        }

        if (state.weatherData == null) {
          return const Center(
            child: Text('No weather data'),
          );
        }else {
          return Column(
            children: [
              Padding(padding: EdgeInsets.only(top: heightFactor * 10)),
              Expanded(child: DisplayView(weatherData: state.weatherData!)),
              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom)),
            ],
          );
        }
      },
    );
  }
}


