// Importación de la librería 'async' para el manejo de asincronía (Futures, Timers, Streams)
import 'dart:async'; // Importación de la librería 'math' para funciones matemáticas y generación de números aleatorios (Random)
import 'dart:math'; // Importación del paquete principal de Flutter que provee los widgets del sistema de diseño Material Design
import 'package:flutter/material.dart';

// Punto de entrada principal de la aplicación Flutter
void main() {
  runApp(const EssenzaApp()); // Ejecuta la aplicación inflando el widget raíz `EssenzaApp` en la pantalla
}

// -----------------------------------------------------------------
// APLICACIÓN PRINCIPAL
// Configuración global del tema, paleta de colores y ruta inicial
// -----------------------------------------------------------------
class EssenzaApp extends StatelessWidget {
  const EssenzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Essenza Perfumerie',
      // Definición del tema visual de Material 3 con colores beige/dorado/marrón
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF8C6D58),
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8C6D58),
          primary: const Color(0xFF8C6D58),
          secondary: const Color(0xFFD4AF37),
          surface: const Color(0xFFFFFFFF),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAF7F2),
          foregroundColor: Color(0xFF332B25),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Serif',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
            color: Color(0xFF332B25),
          ),
        ),
        fontFamily: 'Serif',
      ),
      // Define la pantalla de inicio (Splash)
      home: const PantallaSplash(),
    );
  }
}

// -----------------------------------------------------------------
// MODELOS DE DATOS
// Estructuras de clases y listas estáticas usadas en la app
// -----------------------------------------------------------------

// Modelo inmutable que define las propiedades y atributos de un perfume
class Perfume {
  final String imagen; // Ruta del archivo de imagen en assets
  final String nombre; // Nombre comercial de la fragancia
  final String categoria; // Clasificación por temporada u ocasión
  final String notas; // Notas olfativas principales (p. ej. Floral, Amaderado)
  final String descripcion; // Explicación detallada de la fragancia
  final double precio; // Costo monetario del producto

  // Constructor constante que exige todos los atributos requeridos
  const Perfume({
    required this.imagen,
    required this.nombre,
    required this.categoria,
    required this.notas,
    required this.descripcion,
    required this.precio,
  });
}

// Modelo que almacena la información personal y de envío del cliente
class PerfilCliente {
  final String nombre; // Nombre de pila del usuario
  final String apellido; // Apellidos del usuario
  final String dni; // Documento Nacional de Identidad
  final String email; // Dirección de correo electrónico de contacto
  final String telefono; // Número telefónico de contacto
  final String direccion; // Dirección física para entregas a domicilio
  final String fechaNacimiento; // Fecha de cumpleaños del usuario (DD/MM/AAAA)

  // Constructor nombrando los campos obligatorios
  PerfilCliente({
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.fechaNacimiento,
  });
}

// Modelo que guarda los detalles consolidados de un pedido procesado
class PedidoRealizado {
  final String id; // Identificador único generado aleatoriamente (ej: #ES-12345)
  final DateTime fecha; // Estampa de fecha y hora exacta de realización
  final double montoTotal; // Valor final pagado incluyendo los descuentos
  final String metodoPago; // Pasarela o medio de pago seleccionado
  final int cantidadProductos; // Unidades totales adquiridas en la transacción

  // Constructor con asignación directa requerida de propiedades
  PedidoRealizado({
    required this.id,
    required this.fecha,
    required this.montoTotal,
    required this.metodoPago,
    required this.cantidadProductos,
  });
}

// Lista constante que define los nombres de los filtros por categoría
const List<String> listaCategorias = [
  'Todos',
  'Primavera / Verano',
  'Otoño / Invierno',
  'Noche Exclusiva',
];

// Listado predefinido y estático de perfumes disponibles en la tienda
const List<Perfume> listaPerfumes = [
  Perfume(
    imagen: 'assets/images/perfume_1.png',
    nombre: 'Essenza Dior',
    categoria: 'Primavera / Verano',
    notas: 'Floral & Oriental',
    descripcion: 'Notas sublimes de jazmín nocturno, vainilla de Madagascar y acordes de ámbar misterioso.',
    precio: 45000,
  ),
  Perfume(
    imagen: 'assets/images/perfume_5.png',
    nombre: 'Essenza Rose Gold',
    categoria: 'Primavera / Verano',
    notas: 'Dulce & Floral',
    descripcion: 'Aroma delicado a flores blancas, peonías silvestres y suaves notas de melocotón.',
    precio: 50000,
  ),
  Perfume(
    imagen: 'assets/images/perfume_2.png',
    nombre: 'Essenza Chanel',
    categoria: 'Otoño / Invierno',
    notas: 'Rosadas & Frutales',
    descripcion: 'Gota de elegancia pura elaborada con pétalos frescos de rosa de Bulgaria y destellos de peonías.',
    precio: 52000,
  ),
  Perfume(
    imagen: 'assets/images/perfume_6.png',
    nombre: 'Essenza Dark Oud',
    categoria: 'Otoño / Invierno',
    notas: 'Intenso & Amaderado',
    descripcion: 'Frasco de gala con notas oscuras de madera quemada, vainilla negra y cuero elegante.',
    precio: 72000,
  ),
  Perfume(
    imagen: 'assets/images/perfume_3.png',
    nombre: 'Essenza Coco Chanel',
    categoria: 'Noche Exclusiva',
    notas: 'Cítrico & Amaderado',
    descripcion: 'Inspiración mediterránea con bergamota de Calabria, flor de azahar y un toque sutil de sándalo.',
    precio: 48000,
  ),
  Perfume(
    imagen: 'assets/images/perfume_4.png',
    nombre: 'Essenza Rose',
    categoria: 'Noche Exclusiva',
    notas: 'Amaderado & Especiado',
    descripcion: 'Exclusiva edición de autor con esencia concentrada de Oud, especias orientales y notas de cuero.',
    precio: 68000,
  ),
];

// -----------------------------------------------------------------
// Carga la imagen de asset y si falla intenta cambiar el formato de extensión (.png/.jpg)
// -----------------------------------------------------------------
// Función auxiliar global para manejar la carga segura de imágenes con tolerancia a fallos de extensión
Widget cargarImagen(String ruta, {BoxFit fit = BoxFit.cover}) {
  // Intenta renderizar la imagen desde assets con la ruta especificada
  return Image.asset(
    ruta, // Ruta original proporcionada
    fit: fit, // Modo de ajuste dentro del contenedor
    alignment: Alignment.center, // Centra la imagen dentro de los límites
    errorBuilder: (context, error, stackTrace) {
      // Capturador de error: Si la imagen no se encuentra, calcula una ruta alternativa alternando .png y .jpg
      final rutaAlt = ruta.endsWith('.png') ? ruta.replaceAll('.png', '.jpg') : ruta.replaceAll('.jpg', '.png');
      // Intenta cargar la imagen desde la ruta alternativa generada
      return Image.asset(
        rutaAlt,
        fit: fit,
        alignment: Alignment.center,
        // Segundo respaldador de error: Si la imagen alternativa también falla, muestra un contenedor decorativo
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFFF3ECE4), // Fondo beige suave neutro
            child: const Center(
              // Muestra un icono genérico de una gota/perfume en el centro
              child: Icon(Icons.opacity, size: 40, color: Color(0xFF8C6D58)),
            ),
          );
        },
      );
    },
  );
}

// -----------------------------------------------------------------
// 1. PANTALLA SPLASH CON TIMER Y EFECTO DORADO
// Pantalla de presentación animada con partículas flotantes
// -----------------------------------------------------------------
// Widget con estado para la pantalla de bienvenida / carga inicial
class PantallaSplash extends StatefulWidget {
  const PantallaSplash({super.key});

  @override
  State<PantallaSplash> createState() => _PantallaSplashState();
}

// Estado de PantallaSplash utilizando TickerProvider para animaciones fluidas
class _PantallaSplashState extends State<PantallaSplash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController; // Controlador del ciclo de animación
  final List<_ParticulaPerfume> _particulas = []; // Lista para almacenar las partículas del fondo
  final Random _random = Random(); // Generador de números aleatorios para posiciones
  Timer? _timer; // Temporizador para gestionar el cambio automático de pantalla

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador de animación configurando la duración a 4 segundos
    _animationController = AnimationController(
      vsync: this, // Provee el Ticker del estado actual para evitar consumo fuera de pantalla
      duration: const Duration(seconds: 4), // Tiempo total de un ciclo completo de animación
    )..repeat(); // Inicia la animación y la repite indefinidamente en bucle

    // Genera un conjunto inicial de 20 partículas animadas con parámetros aleatorios
    for (int i = 0; i < 20; i++) {
      _particulas.add(
        _ParticulaPerfume(
          x: _random.nextDouble(), // Posición horizontal relativa entre 0.0 y 1.0
          y: _random.nextDouble(), // Posición vertical relativa entre 0.0 y 1.0
          speed: 0.002 + _random.nextDouble() * 0.003, // Velocidad de caída/ascenso aleatoria
          size: 20 + _random.nextDouble() * 20, // Tamaño variable de la partícula
          opacity: 0.25 + _random.nextDouble() * 0.5, // Nivel de transparencia aleatorio
        ),
      );
    }

    // Define un temporizador de 3 segundos para redirigir automáticamente al usuario
    _timer = Timer(const Duration(seconds: 3), () {
      // Verifica que el widget aún se encuentre activo/montado en el árbol de la app
      if (mounted) {
        // Reemplaza la pantalla Splash por la PantallaPrincipal descartando el Splash del stack
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Destruye y libera los recursos del controlador de animación para evitar fugas de memoria
    _animationController.dispose();
    // Cancela el temporizador activo en caso de que la pantalla se desmonte antes del tiempo
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color doradoSutil = Color(0xFFD4AF37); // Color acento dorado constante

    return Scaffold(
      // Reconstruye la interfaz gráfica en cada fotograma transmitido por el AnimationController
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          // Actualiza las posiciones verticales de cada partícula en cada frame
          for (var p in _particulas) {
            p.y += p.speed; // Incrementa la posición Y según su velocidad individual
            if (p.y > 1.0) p.y = -0.1; // Si supera el borde inferior, reaparece arriba
          }

          // Retorna una pila sobrepuesta con el fondo, las partículas e isotipo central
          return Stack(
            children: [
              // Fondo degradado suave de fondo entero
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, // Inicia el degradado en el borde superior
                    end: Alignment.bottomCenter, // Finaliza en el borde inferior
                    colors: [Color(0xFFFFFDF9), Color(0xFFF5EFE6)], // De blanco crema a beige suave
                  ),
                ),
              ),
              // Renderiza y posiciona dinámicamente cada partícula flotante de la lista
              ..._particulas.map((p) {
                return Positioned(
                  left: p.x * MediaQuery.of(context).size.width, // Escala X al ancho de pantalla
                  top: p.y * MediaQuery.of(context).size.height, // Escala Y al alto de pantalla
                  child: Opacity(
                    opacity: p.opacity, // Transparencia individual
                    child: const Icon(
                      Icons.opacity, // Icono con forma de gota
                      color: doradoSutil, // Color de acento dorado
                    ),
                  ),
                );
              }),
              // Contenido visual e identitario central de la pantalla Splash
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical de la columna
                  children: [
                    // Contenedor circular blanco con sombra dorada que encierra el logo
                    Container(
                      width: 125, // Ancho fijo del círculo
                      height: 125, // Alto fijo del círculo
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Forma circular perfecta
                        color: Colors.white, // Fondo blanco puro
                        border: Border.all(color: doradoSutil.withValues(alpha: 0.6), width: 1.5), // Borde dorado translúcido
                        boxShadow: [
                          BoxShadow(
                            color: doradoSutil.withValues(alpha: 0.2), // Resplandor dorado difuso
                            blurRadius: 30, // Radio de desenfoque de la sombra
                            spreadRadius: 6, // Expansión de la sombra
                          ),
                        ],
                      ),
                      // Icono floral elegante dentro del círculo del isotipo
                      child: const Icon(
                        Icons.local_florist_outlined,
                        size: 60,
                        color: doradoSutil,
                      ),
                    ),
                    const SizedBox(height: 25), // Separador vertical constante
                    // Nombre principal de la marca en mayúsculas
                    const Text(
                      'ESSENZA',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w300, // Fuente estilizada ultra ligera
                        letterSpacing: 8.0, // Espaciado entre letras amplio
                        color: Color(0xFF332B25),
                      ),
                    ),
                    const SizedBox(height: 6), // Separador menor
                    // Subtítulo de la marca
                    const Text(
                      'PERFUMERIE',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 4.0,
                        color: doradoSutil,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40), // Espaciador antes del indicador de carga
                    // Indicador circular giratorio de progreso sutil
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2, // Grosor delgado de la línea de carga
                        color: doradoSutil, // Color del spinner
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Estructura de datos privada de apoyo para parametrizar cada partícula individual
class _ParticulaPerfume {
  double x; // Posición horizontal
  double y; // Posición vertical
  double speed; // Velocidad de traslación
  double size; // Dimensión gráfica del icono
  double opacity; // Transparencia

  // Constructor directo para instanciar propiedades de partícula
  _ParticulaPerfume({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
  });
}

// -----------------------------------------------------------------
// PANTALLA PRINCIPAL
// Maneja el estado global del carrito, cliente, historial e índice de pestañas
// -----------------------------------------------------------------
// Widget con estado que alberga la barra de navegación inferior y el estado global compartido
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

// Estado persistente que contiene la lógica de negocio y colecciones globales de la app
class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _indiceSeleccionado = 0; // Estado del índice activo de la barra de navegación (0 a 3)
  final List<Perfume> _carrito = []; // Lista reactiva global de elementos en el carrito de compras
  final List<PedidoRealizado> _historialPedidos = []; // Registro histórico global de pedidos confirmados
  PerfilCliente? _clienteRegistrado; // Objeto de perfil de cliente (null si no se ha registrado)
  double _porcentajeDescuento = 0.0; // Descuento porcentual aplicable (0.0 = 0%, 0.20 = 20%)

  // Agrega uno o varios ejemplares de un perfume al carrito global y muestra un SnackBar
  void _agregarAlCarrito(Perfume perfume, {int cantidad = 1}) {
    // Actualiza el estado reactivo agregando la cantidad de ítems solicitada
    setState(() {
      for (int i = 0; i < cantidad; i++) {
        _carrito.add(perfume);
      }
    });
    // Despliega una barra de notificación emergente en la parte inferior
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡${perfume.nombre} ($cantidad) añadido a tu bolsa!'),
        backgroundColor: const Color(0xFF8C6D58),
        duration: const Duration(seconds: 2), // Visibilidad por 2 segundos
        behavior: SnackBarBehavior.floating, // Estilo flotante sobre el contenido
      ),
    );
  }

  // Asigna el perfil del cliente registrado y activa de forma automática el 20% de descuento global
  void _guardarPerfil(PerfilCliente perfil) {
    setState(() {
      _clienteRegistrado = perfil; // Guarda el objeto cliente
      _porcentajeDescuento = 0.20; // Habilita el 20% de descuento
    });
  }

  // Simula el procesamiento asíncrono de un pago mediante un flujo de diálogos modales y temporizadores
  void _simularProcesamientoYPago(String metodoPago) {
    Navigator.pop(context); // Cierra la hoja modal de selección de método de pago

    // Muestra un cuadro de diálogo no bloqueante con un spinner de carga
    showDialog(
      context: context,
      barrierDismissible: false, // Impide que el usuario cierre el diálogo tocando fuera
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.white,
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajusta la columna al tamaño mínimo del contenido
            children: [
              CircularProgressIndicator(color: Color(0xFF8C6D58)),
              SizedBox(height: 20),
              Text(
                'Procesando su pago con seguridad...',
                style: TextStyle(fontSize: 14, color: Color(0xFF332B25)),
              ),
            ],
          ),
        ),
      ),
    );

    // Espera 2.5 segundos simulando comunicación con pasarela bancaria
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pop(context); // Cierra el cuadro de diálogo de carga

      // Cálculos matemáticos del total financiero
      final double subtotal = _carrito.fold(0, (sum, item) => sum + item.precio);
      final double montoDescuento = subtotal * _porcentajeDescuento;
      final double totalFinal = subtotal - montoDescuento;
      final int cantidadTotal = _carrito.length;

      // Actualiza el estado agregando el pedido al historial y limpiando la bolsa
      setState(() {
        _historialPedidos.insert(
          0, // Inserta el nuevo pedido al inicio de la lista (más reciente primero)
          PedidoRealizado(
            id: '#ES-${Random().nextInt(90000) + 10000}', // Genera un ID dinámico de 5 dígitos
            fecha: DateTime.now(), // Marca temporal de la transacción
            montoTotal: totalFinal,
            metodoPago: metodoPago,
            cantidadProductos: cantidadTotal,
          ),
        );
        _carrito.clear(); // Vacía completamente la bolsa de compras
      });

      // Muestra el modal final de confirmación de transacción realizada con éxito
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Column(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
              SizedBox(height: 10),
              Text('¡Compra Exitosa!', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'Su pago de \$${totalFinal.toStringAsFixed(0)} ha sido procesado mediante $metodoPago.\n\n'
            'Su pedido se preparará artesanalmente y se enviará a su domicilio en los próximos días.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF66584F), height: 1.4),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8C6D58),
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context), // Cierra el diálogo de éxito
                child: const Text('Aceptar'),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Abre una hoja modal inferior (BottomSheet) para presentar los métodos de pago disponibles
  void _abrirModalMetodosPago() {
    if (_carrito.isEmpty) return; // Cancela si la bolsa no posee artículos

    // Calcula de forma previa el importe financiero para mostrarlo en la cabecera
    final double subtotal = _carrito.fold(0, (sum, item) => sum + item.precio);
    final double montoDescuento = subtotal * _porcentajeDescuento;
    final double totalFinal = subtotal - montoDescuento;

    // Llama al constructor nativo para desplegar la hoja desde el borde inferior
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que la hoja ajuste su altura dinámicamente
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)), // Bordes superiores redondeados
      ),
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75, // Limita la altura al 75% de la pantalla
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seleccione Método de Pago',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF332B25)),
              ),
              const SizedBox(height: 6),
              // Muestra el importe total calculado con formato entero
              Text(
                'Monto final a abonar: \$${totalFinal.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 14, color: Color(0xFF8C6D58), fontWeight: FontWeight.bold),
              ),
              const Divider(height: 20),
              // Lista scrolleable con las distintas opciones de medios de pago disponibles
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.account_balance_wallet, color: Color(0xFF8C6D58)),
                        title: const Text('Mercado Pago'),
                        onTap: () => _simularProcesamientoYPago('Mercado Pago'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.credit_card, color: Color(0xFF8C6D58)),
                        title: const Text('Tarjeta de Crédito'),
                        onTap: () => _simularProcesamientoYPago('Tarjeta de Crédito'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.credit_score, color: Color(0xFF8C6D58)),
                        title: const Text('Tarjeta de Débito'),
                        onTap: () => _simularProcesamientoYPago('Tarjeta de Débito'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_balance, color: Color(0xFF8C6D58)),
                        title: const Text('Banco Nación'),
                        onTap: () => _simularProcesamientoYPago('Banco Nación'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.swap_horiz, color: Color(0xFF8C6D58)),
                        title: const Text('Transferencia bancaria'),
                        onTap: () => _simularProcesamientoYPago('Transferencia bancaria'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.payments, color: Color(0xFF8C6D58)),
                        title: const Text('Efectivo contra entrega'),
                        onTap: () => _simularProcesamientoYPago('Efectivo'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lista conteniendo las instancias de los 4 widgets de vista correspondientes a las pestañas
    final List<Widget> pantallas = [
      VistaInformacion(onAgregar: _agregarAlCarrito),
      VistaMenu(onAgregar: _agregarAlCarrito),
      VistaCarrito(
        carrito: _carrito,
        porcentajeDescuento: _porcentajeDescuento,
        onProcederPago: _abrirModalMetodosPago,
      ),
      VistaSuscripcion(
        clienteExistente: _clienteRegistrado,
        historialPedidos: _historialPedidos,
        onRegistrar: _guardarPerfil,
      ),
    ];

    return Scaffold(
      // SafeArea evita que el contenido se solape con muescas (notches) o barras del sistema
      body: SafeArea(
        // IndexedStack mantiene el estado interno de todas las vistas sin destruirlas al cambiar de pestaña
        child: IndexedStack(
          index: _indiceSeleccionado, // Pestaña actualmente visible
          children: pantallas, // Colección de vistas
        ),
      ),
      // Barra inferior de navegación propia de Material Design 3
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceSeleccionado,
        // Evento que se dispara al tocar cualquiera de los botones del menú de navegación
        onDestinationSelected: (index) {
          setState(() {
            _indiceSeleccionado = index; // Actualiza la pestaña activa
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFF3ECE4), // Color de resaltado del botón activo
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info, color: Color(0xFF8C6D58)),
            label: 'Info',
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view, color: Color(0xFF8C6D58)),
            label: 'Catálogo',
          ),
          // Destino con Badge (Insignia gráfica) para mostrar el recuento actual de productos en el carrito
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _carrito.isNotEmpty, // Visibilidad condicionada a que la bolsa no esté vacía
              label: Text('${_carrito.length}'), // Muestra la cantidad entera agregada
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: _carrito.isNotEmpty,
              label: Text('${_carrito.length}'),
              child: const Icon(Icons.shopping_bag, color: Color(0xFF8C6D58)),
            ),
            label: 'Bolsa',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFF8C6D58)),
            label: 'Perfil / Descuentos',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 2. VISTA INFORMACIÓN Y BANNERS INTERACTIVOS
// Carrusel de ofertas y cuadro de diálogo con detalles de cada banner
// -----------------------------------------------------------------
// Vista de inicio informativa que despliega banners promocionales horizontales
class VistaInformacion extends StatelessWidget {
  final Function(Perfume) onAgregar; // Función Callback recibida para agregar ítems desde el diálogo

  const VistaInformacion({super.key, required this.onAgregar});

  // Despliega un modal informativo detallado al presionar sobre cualquier banner de la lista
  void _mostrarInfoBanner(BuildContext context, Map<String, dynamic> banner) {
    final Perfume perfumeAsociado = banner['producto']; // Obtiene el objeto perfume vinculado al banner

    showDialog(
      context: context,
      barrierColor: Colors.black54, // Fondo oscuro semitransparente tras el diálogo
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Fondo transparente para aplicar borderRadius en el contenedor
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400), // Ancho máximo controlado para tablets/móviles
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // La altura del modal se ajusta a su contenido
              children: [
                // Cabecera del diálogo compuesta por la imagen completa y el botón flotante para cerrar
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      child: Container(
                        height: 300, // Aumentado para que la foto se vea más grande
                        width: double.infinity,
                        color: const Color(0xFFFBF9F6),
                        child: cargarImagen(perfumeAsociado.imagen, fit: BoxFit.cover), // Cambiado a BoxFit.cover
                      ),
                    ),
                    // Botón de cierre en la esquina superior derecha
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.8),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () => Navigator.pop(context), // Cierra el modal de banner
                        ),
                      ),
                    )
                  ],
                ),
                // Cuerpo del cuadro de diálogo con la descripción y precio del producto en oferta
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner['titulo']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8C6D58),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        perfumeAsociado.nombre,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF332B25)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${perfumeAsociado.categoria} • ${perfumeAsociado.notas}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF8C6D58), fontWeight: FontWeight.w600),
                      ),
                      const Divider(height: 20),
                      Text(
                        perfumeAsociado.descripcion,
                        style: const TextStyle(fontSize: 13, color: Color(0xFF66584F), height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      // Fila inferior con el valor del perfume y botón directo para agregarlo al carrito
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${perfumeAsociado.precio.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8C6D58),
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C6D58),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Cierra la tarjeta
                              onAgregar(perfumeAsociado); // Invoca el callback enviando el producto
                            },
                            icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                            label: const Text('Comprar'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definición local de la colección de banners promocionales
    final List<Map<String, dynamic>> banners = [
      {
        'imagen': 'assets/images/banner_1.png',
        'titulo': 'Alta Perfumería de Autor',
        'subtitulo': 'El arte de la alta perfumería artesanal en tu piel.',
        'producto': listaPerfumes[0],
      },
      {
        'imagen': 'assets/images/banner_2.png',
        'titulo': '¡Especial Cumpleaños! 25% OFF',
        'subtitulo': 'Obtén 25% de descuento en tu mes especial presentando tu DNI.',
        'producto': listaPerfumes[1],
      },
      {
        'imagen': 'assets/images/banner_3.png',
        'titulo': 'Colección Especial',
        'subtitulo': 'Fragancias complementarias elaboradas con aceites puros del mundo.',
        'producto': listaPerfumes[3],
      },
    ];

    // Scroll vertical para permitir ver la tarjeta institucional inferior en pantallas pequeñas
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Título estético principal
          const Text(
            'ESSENZA',
            style: TextStyle(
              fontSize: 28,
              letterSpacing: 6.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF332B25),
            ),
          ),
          const Text(
            'PERFUMERIE',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3.0,
              color: Color(0xFF8C6D58),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          // Carrusel/Lista horizontal con scroll para desplegar las tarjetas promocionales
          SizedBox(
            height: 340, // Altura reservada para las tarjetas del carrusel
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Orientación de scroll de izquierda a derecha
              itemCount: banners.length,
              itemBuilder: (context, index) {
                final b = banners[index];
                final bool esBannerTres = (index == 2); // Identifica el tercer banner para ajustar fit de imagen

                // Detecta toques en las tarjetas para lanzar el modal descriptivo
                return GestureDetector(
                  onTap: () => _mostrarInfoBanner(context, b),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82, // Ocupa el 82% del ancho de pantalla
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2825),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias, // Recorta esquenas según el borderRadius
                    child: Stack(
                      children: [
                        // Imagen base de fondo
                        Positioned.fill(
                          child: cargarImagen(
                            b['imagen']!,
                            fit: esBannerTres ? BoxFit.contain : BoxFit.cover,
                          ),
                        ),
                        // Capa oscura con degradado superpuesta para asegurar legibilidad sobre la foto
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.75)],
                              ),
                            ),
                          ),
                        ),
                        // Textos promocionales y llamada a la acción en la parte inferior de la tarjeta
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                b['titulo']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                b['subtitulo']!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Text(
                                    'Toca para más detalles',
                                    style: TextStyle(
                                      color: Color(0xFFD4AF37),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFFD4AF37)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Tarjeta estática de información institucional sobre la boutique física
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE8DFD8)),
            ),
            child: const Column(
              children: [
                Text(
                  'Maison de Parfum',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF332B25)),
                ),
                SizedBox(height: 8),
                Text(
                  'Elaboramos fragancias exclusivas combinando aceites esenciales seleccionados de los mejores rincones del mundo.\n\n'
                  '📍 Av. Alvear 1845, Recoleta\n'
                  '🕒 Atención: Lunes a Sábados de 10:00 a 20:00 hs',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xFF66584F), height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 3. VISTA: MENÚ DE VENTAS CON VISTA DETALLADA
// Catálogo principal filtrable por categorías en cuadrícula
// -----------------------------------------------------------------
// Vista de catálogo interactivo que lista los perfumes en una cuadrícula con filtros
class VistaMenu extends StatefulWidget {
  final Function(Perfume, {int cantidad}) onAgregar;

  const VistaMenu({super.key, required this.onAgregar});

  @override
  State<VistaMenu> createState() => _VistaMenuState();
}

class _VistaMenuState extends State<VistaMenu> {
  String _categoriaSeleccionada = 'Todos'; // Estado para controlar el filtro de categoría activo

  // Navega a la pantalla independiente de detalle del perfume enviando los datos por parámetro
  void _abrirDetalleProducto(Perfume perfume) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaDetallePerfume(
          perfume: perfume,
          onAgregar: widget.onAgregar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filtra la lista global de perfumes evaluando la categoría seleccionada
    final perfumesFiltrados = _categoriaSeleccionada == 'Todos'
        ? listaPerfumes
        : listaPerfumes.where((p) => p.categoria == _categoriaSeleccionada).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('COLECCIÓN EXCLUSIVA')),
      body: Column(
        children: [
          // Selector horizontal de etiquetas de filtro (FilterChips)
          SizedBox(
            height: 52,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: listaCategorias.length,
              itemBuilder: (context, index) {
                final cat = listaCategorias[index];
                final bool seleccionada = cat == _categoriaSeleccionada;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        color: seleccionada ? Colors.white : const Color(0xFF332B25),
                        fontWeight: seleccionada ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    selected: seleccionada, // Marca visualmente si la etiqueta está seleccionada
                    selectedColor: const Color(0xFF8C6D58),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: seleccionada ? const Color(0xFF8C6D58) : const Color(0xFFE8DFD8),
                      ),
                    ),
                    // Evento al presionar un filtro para actualizar el estado del catálogo
                    onSelected: (bool selected) {
                      setState(() {
                        _categoriaSeleccionada = cat; // Actualiza la categoría activa
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Cuadrícula dinámica de dos columnas que dibuja las tarjetas de los perfumes filtrados
          Expanded(
            child: perfumesFiltrados.isEmpty
                ? const Center(
                    child: Text(
                      'No hay fragancias disponibles en esta categoría.',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: perfumesFiltrados.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columnas por fila
                      mainAxisSpacing: 14, // Espacio vertical entre tarjetas
                      crossAxisSpacing: 14, // Espacio horizontal entre tarjetas
                      childAspectRatio: 0.65, // Proporción de aspecto (ancho/alto) de cada tarjeta
                    ),
                    itemBuilder: (context, index) {
                      final perfume = perfumesFiltrados[index];
                      return Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(color: Color(0xFFE8DFD8)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        // Añade efecto de onda táctil e interacción al pulsar
                        child: InkWell(
                          onTap: () => _abrirDetalleProducto(perfume), // Abre pantalla de detalle
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Sección superior de la tarjeta: Imagen (60% del espacio)
                              Expanded(
                                flex: 6,
                                child: Container(
                                  color: const Color(0xFFFBF9F6),
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: cargarImagen(perfume.imagen),
                                  ),
                                ),
                              ),
                              // Sección inferior de la tarjeta: Datos y precio (40% del espacio)
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            perfume.nombre,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis, // Recorta con puntos suspensivos si es largo
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${perfume.categoria} • ${perfume.notas}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 10, color: Color(0xFF8C6D58), fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${perfume.precio.toStringAsFixed(0)}',
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF8C6D58)),
                                          ),
                                          const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF8C6D58)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// PANTALLA DETALLE DEL PERFUME
// Vista completa del producto seleccionado con selector de cantidad
// -----------------------------------------------------------------
// Pantalla completa secundaria que presenta el detalle minucioso de un perfume seleccionado
class PantallaDetallePerfume extends StatefulWidget {
  final Perfume perfume; // Objeto perfume recibido desde el catálogo
  final Function(Perfume, {int cantidad}) onAgregar; // Función callback para enviar la orden de compra

  const PantallaDetallePerfume({
    super.key,
    required this.perfume,
    required this.onAgregar,
  });

  @override
  State<PantallaDetallePerfume> createState() => _PantallaDetallePerfumeState();
}

class _PantallaDetallePerfumeState extends State<PantallaDetallePerfume> {
  int _cantidad = 1; // Contador de unidades seleccionadas por el usuario

  @override
  Widget build(BuildContext context) {
    final perfume = widget.perfume;
    final totalCalculado = perfume.precio * _cantidad; // Cálculo en tiempo real según unidades

    return Scaffold(
      appBar: AppBar(
        title: Text(perfume.nombre),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner superior grande con la fotografía en alta resolución del perfume
            Container(
              height: 400,
              width: double.infinity,
              color: const Color(0xFFFBF9F6),
              child: cargarImagen(perfume.imagen, fit: BoxFit.cover),
            ),
            // Panel inferior con detalles, contador e importe
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fila con categoría etiquetada y notas olfativas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3ECE4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          perfume.categoria,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8C6D58),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Notas: ${perfume.notas}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    perfume.nombre,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF332B25),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8C6D58),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    perfume.descripcion,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF66584F),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Controles incrementales para alterar la cantidad de frascos a llevar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cantidad a comprar:',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF332B25)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE8DFD8)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Botón para decrementar la cantidad con piso mínimo de 1
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () {
                                if (_cantidad > 1) {
                                  setState(() {
                                    _cantidad--;
                                  });
                                }
                              },
                            ),
                            Text(
                              '$_cantidad',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            // Botón para incrementar unidades
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () {
                                setState(() {
                                  _cantidad++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  // Resumen de precio total acumulado y botón final para añadir al carrito
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Precio Total',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            '\$${totalCalculado.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8C6D58),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        width: 180,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8C6D58),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: () {
                            widget.onAgregar(perfume, cantidad: _cantidad); // Ejecuta el callback enviando perfume y cantidad
                            Navigator.pop(context); // Regresa a la vista anterior (catálogo)
                          },
                          icon: const Icon(Icons.shopping_bag_outlined),
                          label: const Text('COMPRAR', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 4. VISTA: CARRITO
// Listado de artículos agregados, cálculo de totales y botón de pago
// -----------------------------------------------------------------
// Vista encargada de mostrar el listado de productos seleccionados, cálculo del total y activación del pago
class VistaCarrito extends StatelessWidget {
  final List<Perfume> carrito; // Colección de perfumes contenidos en la bolsa
  final double porcentajeDescuento; // Descuento activo (0.0 o 0.20)
  final VoidCallback onProcederPago; // Función para detonar la hoja de pagos

  const VistaCarrito({
    super.key,
    required this.carrito,
    required this.porcentajeDescuento,
    required this.onProcederPago,
  });

  @override
  Widget build(BuildContext context) {
    // Cálculo mediante reducción `.fold()` sumando los precios individuales de los perfumes
    final double subtotal = carrito.fold(0, (sum, item) => sum + item.precio);
    final double montoDescuento = subtotal * porcentajeDescuento; // Calcula el monto deducido
    final double totalFinal = subtotal - montoDescuento; // Importe líquido final

    return Scaffold(
      appBar: AppBar(title: const Text('MI BOLSA DE COMPRAS')),
      // Condicional ternario: si el carrito está vacío muestra ilustración informativa, sino la lista de compra
      body: carrito.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 70, color: Color(0xFFD4B9A5)),
                  SizedBox(height: 12),
                  Text('Tu bolsa de compras está vacía', style: TextStyle(color: Color(0xFF66584F), fontSize: 16)),
                ],
              ),
            )
          : Column(
              children: [
                // Lista scrolleable con las tarjetas individuales de cada ítem agregado
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: carrito.length,
                    itemBuilder: (context, index) {
                      final item = carrito[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          title: Text(item.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${item.categoria} • ${item.notas}'),
                          trailing: Text('\$${item.precio.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8C6D58))),
                        ),
                      );
                    },
                  ),
                ),
                // Panel inferior de liquidación monetaria con subtotal, descuento aplicado y total final
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                          Text('\$${subtotal.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      // Despliega la línea verde de descuento únicamente si el porcentaje es mayor a cero
                      if (porcentajeDescuento > 0) ...[
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Descuento Cliente (${(porcentajeDescuento * 100).toInt()}%):',
                              style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '-\$${montoDescuento.toStringAsFixed(0)}',
                              style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total a Pagar:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            '\$${totalFinal.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8C6D58)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Botón principal de checkout para invocar el flujo modal de medios de pago
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8C6D58),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: onProcederPago, // Invoca el callback pasado desde PantallaPrincipal
                          child: const Text('PROCEDER AL PAGO', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// -----------------------------------------------------------------
// 5. VISTA PERFIL / DESCUENTOS CON HISTORIAL DE COMPRAS
// Formulario para solicitar descuento y sección del historial de compras
// -----------------------------------------------------------------
// Vista de gestión de cuenta que combina el formulario de registro y el historial de compras
class VistaSuscripcion extends StatefulWidget {
  final PerfilCliente? clienteExistente; // Datos del perfil actual si ya fue completado
  final List<PedidoRealizado> historialPedidos; // Lista de compras pasadas
  final Function(PerfilCliente) onRegistrar; // Función Callback para persistir los datos ingresados

  const VistaSuscripcion({
    super.key,
    required this.clienteExistente,
    required this.historialPedidos,
    required this.onRegistrar,
  });

  @override
  State<VistaSuscripcion> createState() => _VistaSuscripcionState();
}

class _VistaSuscripcionState extends State<VistaSuscripcion> {
  // Clave global para identificar y validar de manera reactiva el formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para vincular y extraer las entradas del usuario en los campos
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _cumpleController = TextEditingController();

  // Despliega el selector de fecha nativo (DatePicker) para capturar el cumpleaños
  Future<void> _seleccionarCumple(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Fecha sugerida al abrir
      firstDate: DateTime(1930), // Límite mínimo de año
      lastDate: DateTime.now(), // Límite máximo (fecha actual)
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8C6D58), // Color de acento para la cabecera del calendario
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    // Si el usuario confirma una fecha válida, formatea y actualiza la caja de texto
    if (picked != null) {
      setState(() {
        _cumpleController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // Comprueba la validez de las entradas, arma la entidad PerfilCliente y dispara el callback
  void _guardarFormulario() {
    // Dispara la validación de todos los TextFormField contenidos dentro del Form
    if (_formKey.currentState!.validate()) {
      final nuevoPerfil = PerfilCliente(
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        dni: _dniController.text,
        email: _emailController.text,
        telefono: _telefonoController.text,
        direccion: _direccionController.text,
        fechaNacimiento: _cumpleController.text,
      );

      widget.onRegistrar(nuevoPerfil); // Envía los datos capturados a PantallaPrincipal

      // Notificación de confirmación exitosa
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Registro guardado! Se ha aplicado un 20% OFF a tu bolsa.'),
          backgroundColor: Color(0xFF8C6D58),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CLUB ESSENZA')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Evaluación condicional: Si el cliente ya existe muestra la tarjeta con sus datos, si no, el formulario
            widget.clienteExistente != null
                ? _construirPerfilGuardado(widget.clienteExistente!)
                : Form(
                    key: _formKey, // Enlace con la clave global de validación
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Banner publicitario invitando a registrarse para obtener el beneficio
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3ECE4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.card_giftcard, size: 40, color: Color(0xFF8C6D58)),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('¡20% OFF en todas tus compras!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    Text('Regístrate con tus datos y obtén tu beneficio exclusivo automáticamente.', style: TextStyle(fontSize: 12, color: Colors.black54)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Campos de entrada de datos con validaciones requeridas de campo no vacío
                        TextFormField(
                          controller: _nombreController,
                          decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _apellidoController,
                          decoration: const InputDecoration(labelText: 'Apellido', border: OutlineInputBorder()),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _dniController,
                          keyboardType: TextInputType.number, // Abre teclado numérico
                          decoration: const InputDecoration(labelText: 'DNI', border: OutlineInputBorder()),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress, // Abre teclado con símbolo @ y dominio
                          decoration: const InputDecoration(labelText: 'Correo Electrónico', border: OutlineInputBorder()),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _telefonoController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(labelText: 'Teléfono', border: OutlineInputBorder()),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _direccionController,
                          decoration: const InputDecoration(labelText: 'Dirección de Entrega', border: OutlineInputBorder()),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        // Campo de cumpleaños de solo lectura que dispara el DatePicker al hacer tap
                        TextFormField(
                          controller: _cumpleController,
                          readOnly: true, // Deshabilita la edición mediante el teclado virtual
                          onTap: () => _seleccionarCumple(context), // Abre el calendario
                          decoration: const InputDecoration(
                            labelText: 'Fecha de Cumpleaños',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.cake, color: Color(0xFF8C6D58)),
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 20),
                        // Botón de envío del formulario
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C6D58),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            ),
                            onPressed: _guardarFormulario,
                            child: const Text('REGISTRARME Y ACTIVAR DESCUENTO', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 24),
            // Renderizado de la sección de historial de pedidos pasados
            _construirSeccionHistorial(),
          ],
        ),
      ),
    );
  }

  // Construye la vista de resumen gráfica con las credenciales registradas del usuario
  Widget _construirPerfilGuardado(PerfilCliente c) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8DFD8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFF3ECE4),
                child: Icon(Icons.person, color: Color(0xFF8C6D58)),
              ),
              SizedBox(width: 12),
              Text(
                'Perfil de Socio Essenza',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF332B25)),
              ),
            ],
          ),
          const Divider(height: 25),
          _itemPerfil('Nombre Completo', '${c.nombre} ${c.apellido}'),
          _itemPerfil('DNI', c.dni),
          _itemPerfil('Email', c.email),
          _itemPerfil('Teléfono', c.telefono),
          _itemPerfil('Dirección', c.direccion),
          _itemPerfil('Fecha de Nacimiento', c.fechaNacimiento),
          const SizedBox(height: 15),
          // Indicador verde de confirmación de descuento activo
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified, color: Colors.green),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Beneficio Activo: 20% OFF aplicado automáticamente en tu bolsa.',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Genera el bloque que ennumera el historial de compras finalizadas
  Widget _construirSeccionHistorial() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8DFD8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long, color: Color(0xFF8C6D58)),
              SizedBox(width: 10),
              Text(
                'Historial de Compras',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF332B25)),
              ),
            ],
          ),
          const Divider(height: 20),
          // Evaluador para mostrar mensaje alternativo cuando no hay pedidos previos
          widget.historialPedidos.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Aún no has registrado compras.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true, // Ajusta el tamaño de la lista interna a sus elementos
                  physics: const NeverScrollableScrollPhysics(), // Desactiva el scroll propio para evitar conflictos con el scroll padre
                  itemCount: widget.historialPedidos.length,
                  itemBuilder: (context, index) {
                    final p = widget.historialPedidos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text(
                                '${p.fecha.day.toString().padLeft(2, '0')}/${p.fecha.month.toString().padLeft(2, '0')}/${p.fecha.year} • ${p.metodoPago}',
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                          Text(
                            '\$${p.montoTotal.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8C6D58), fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  // Método auxiliar reutilizable para dibujar pares de información (Clave - Valor) en la vista del perfil
  Widget _itemPerfil(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(valor, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF332B25))),
        ],
      ),
    );
  }
}