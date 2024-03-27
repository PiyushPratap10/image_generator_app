import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_generator_app/features/prompt/repos/prompt_repo.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(promptInitialEvent);
    on<PromptEnteredEvent>(promptEnteredEvent);
  }

  FutureOr<void> promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadState());
    Uint8List? file = await PromptRepo.generateImage(event.prompt);
    if (file != null) {
      emit(PromptGeneratingImageSuccessState(file: file));
    } else {
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> promptInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) async {
    try {
      
      ByteData imageData = await rootBundle.load(
          'assets/images/tanjiro and nezuko.jpg'); // Adjust the path as per your pubspec.yaml file

      
      Uint8List file = imageData.buffer.asUint8List();

      emit(PromptGeneratingImageSuccessState(file: file));
    } catch (e) {
      print(e);
    }
  }
}
