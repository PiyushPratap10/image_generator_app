import 'package:flutter/material.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Generator'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(
              color: Colors.black54,
            )),
            Container(
              height: 240,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Enter your prompt',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  TextField(controller: controller,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 48
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepPurple
                        ),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 48,
                    width: double.maxFinite,
                    child: ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.generating_tokens), label: const Text('Generate'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
