import 'package:flutter/widgets.dart';
import 'package:lifecycle_state/src/view_model.dart';

abstract class ViewState<T extends StatefulWidget>
    extends State<T> {

  late final ViewModel _viewModel;
  ViewModel get viewModel => _viewModel;

  ViewModel createViewModel();

  @mustCallSuper
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
    debugPrint('ViewState dispose');
  }
}