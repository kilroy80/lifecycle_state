import 'package:flutter/widgets.dart';
import 'package:lifecycle_state/src/view_model.dart';

abstract class ViewModelState<T extends StatefulWidget, VM extends ViewModel>
    extends State<T> {

  late final VM _viewModel;
  VM get viewModel => _viewModel;

  VM createViewModel();

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _viewModel = createViewModel();
  }

  @mustCallSuper
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}