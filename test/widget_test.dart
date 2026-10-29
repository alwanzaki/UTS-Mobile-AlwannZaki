   import 'package:flutter_test/flutter_test.dart';
   import 'package:tokopedia_clone/main.dart';

   void main() {
     testWidgets('Aplikasi menampilkan Beranda', (WidgetTester tester) async {
       await tester.pumpWidget(const TokopediaCloneApp());
       expect(find.text('Cari di Tokopedia'), findsOneWidget);
     });
   }