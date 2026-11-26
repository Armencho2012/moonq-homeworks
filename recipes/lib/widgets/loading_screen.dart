import 'package:material_ui/material_ui.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.amber,),
          SizedBox(height: 10),
          Text('Բեռնվում է.....')
        ],
      ),
    );
  }
}