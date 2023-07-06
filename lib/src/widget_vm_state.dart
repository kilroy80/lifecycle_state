import 'package:flutter/widgets.dart';
import 'package:lifecycle_state/src/view_model_mixin.dart';

abstract class ViewModelState<T extends StatefulWidget, VM extends ViewModelMixin>
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
    _viewModel.dispose();
    super.dispose();
  }
}