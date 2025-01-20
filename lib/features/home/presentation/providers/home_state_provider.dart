import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/home.dart';

final homeStateProvider =
    StateProvider<HomeState>((ref) => const HomeState(tabIndex: 0));
