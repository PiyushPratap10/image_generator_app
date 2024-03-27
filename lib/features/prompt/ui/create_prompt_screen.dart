import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generator_app/features/prompt/bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Generator'),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PromptGeneratingImageLoadState:
              return const Center(child: CircularProgressIndicator());
            case PromptGeneratingImageErrorState:
              return const Center(
                child: Text('Something went wrong'),
              );
            case PromptGeneratingImageSuccessState:
              final succesState = state as PromptGeneratingImageSuccessState;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(succesState.file))),
                    )),
                    Container(
                      height: 240,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter your prompt',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: controller,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 48,
                            width: double.maxFinite,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  promptBloc.add(PromptEnteredEvent(
                                      prompt: controller.text));
                                }
                              },
                              icon: const Icon(Icons.generating_tokens),
                              label: const Text('Generate'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurple)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
