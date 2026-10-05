import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Carga la pantalla Splash de Essenza correctamente', (WidgetTester tester) async {
    // Carga la aplicación
    await tester.pumpWidget(const EssenzaApp());

    // Verifica que aparezca el nombre de la marca
    expect(find.text('ESSENZA'), findsOneWidget);
    expect(find.text('Perfumería de Alta Gama'), findsOneWidget);
  });
}
