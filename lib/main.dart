import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const EssenzaApp());
}

// -----------------------------------------------------------------
// APLICACIÓN PRINCIPAL
// -----------------------------------------------------------------
class EssenzaApp extends StatelessWidget {
  const EssenzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Essenza Perfumerie',
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
      home: const PantallaSplash(),
    );
  }
}

// -----------------------------------------------------------------
// MODELOS DE DATOS
// -----------------------------------------------------------------
class Perfume {
  final String imagen;
  final String nombre;
  final String categoria;
  final String notas;
  final String descripcion;
  final double precio;

  const Perfume({
    required this.imagen,
    required this.nombre,
    required this.categoria,
    required this.notas,
    required this.descripcion,
    required this.precio,
  });
}

class PerfilCliente {
  final String nombre;
  final String apellido;
  final String dni;
  final String email;
  final String telefono;
  final String direccion;
  final String fechaNacimiento;

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

class PedidoRealizado {
  final String id;
  final DateTime fecha;
  final double montoTotal;
  final String metodoPago;
  final int cantidadProductos;

  PedidoRealizado({
    required this.id,
    required this.fecha,
    required this.montoTotal,
    required this.metodoPago,
    required this.cantidadProductos,
  });
}

const List<String> listaCategorias = [
  'Todos',
  'Primavera / Verano',
  'Otoño / Invierno',
  'Noche Exclusiva',
];

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
// HELPER PARA CARGA DE IMÁGENES
// -----------------------------------------------------------------
Widget cargarImagen(String ruta, {BoxFit fit = BoxFit.cover}) {
  return Image.asset(
    ruta,
    fit: fit,
    alignment: Alignment.center,
    errorBuilder: (context, error, stackTrace) {
      final rutaAlt = ruta.endsWith('.png') ? ruta.replaceAll('.png', '.jpg') : ruta.replaceAll('.jpg', '.png');
      return Image.asset(
        rutaAlt,
        fit: fit,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFFF3ECE4),
            child: const Center(
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
// -----------------------------------------------------------------
class PantallaSplash extends StatefulWidget {
  const PantallaSplash({super.key});

  @override
  State<PantallaSplash> createState() => _PantallaSplashState();
}

class _PantallaSplashState extends State<PantallaSplash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<_ParticulaPerfume> _particulas = [];
  final Random _random = Random();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    for (int i = 0; i < 20; i++) {
      _particulas.add(
        _ParticulaPerfume(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          speed: 0.002 + _random.nextDouble() * 0.003,
          size: 20 + _random.nextDouble() * 20,
          opacity: 0.25 + _random.nextDouble() * 0.5,
        ),
      );
    }

    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color doradoSutil = Color(0xFFD4AF37);

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          for (var p in _particulas) {
            p.y += p.speed;
            if (p.y > 1.0) p.y = -0.1;
          }

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFFDF9), Color(0xFFF5EFE6)],
                  ),
                ),
              ),
              ..._particulas.map((p) {
                return Positioned(
                  left: p.x * MediaQuery.of(context).size.width,
                  top: p.y * MediaQuery.of(context).size.height,
                  child: Opacity(
                    opacity: p.opacity,
                    child: const Icon(
                      Icons.opacity,
                      color: doradoSutil,
                    ),
                  ),
                );
              }),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: doradoSutil.withValues(alpha: 0.6), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: doradoSutil.withValues(alpha: 0.2),
                            blurRadius: 30,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.local_florist_outlined,
                        size: 60,
                        color: doradoSutil,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'ESSENZA',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 8.0,
                        color: Color(0xFF332B25),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'PERFUMERIE',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 4.0,
                        color: doradoSutil,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: doradoSutil,
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

class _ParticulaPerfume {
  double x;
  double y;
  double speed;
  double size;
  double opacity;

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
// -----------------------------------------------------------------
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _indiceSeleccionado = 0;
  final List<Perfume> _carrito = [];
  final List<PedidoRealizado> _historialPedidos = [];
  PerfilCliente? _clienteRegistrado;
  double _porcentajeDescuento = 0.0;

  void _agregarAlCarrito(Perfume perfume, {int cantidad = 1}) {
    setState(() {
      for (int i = 0; i < cantidad; i++) {
        _carrito.add(perfume);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡${perfume.nombre} ($cantidad) añadido a tu bolsa!'),
        backgroundColor: const Color(0xFF8C6D58),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _guardarPerfil(PerfilCliente perfil) {
    setState(() {
      _clienteRegistrado = perfil;
      _porcentajeDescuento = 0.20;
    });
  }

  void _simularProcesamientoYPago(String metodoPago) {
    Navigator.pop(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.white,
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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

    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pop(context);

      final double subtotal = _carrito.fold(0, (sum, item) => sum + item.precio);
      final double montoDescuento = subtotal * _porcentajeDescuento;
      final double totalFinal = subtotal - montoDescuento;
      final int cantidadTotal = _carrito.length;

      setState(() {
        _historialPedidos.insert(
          0,
          PedidoRealizado(
            id: '#ES-${Random().nextInt(90000) + 10000}',
            fecha: DateTime.now(),
            montoTotal: totalFinal,
            metodoPago: metodoPago,
            cantidadProductos: cantidadTotal,
          ),
        );
        _carrito.clear();
      });

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
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _abrirModalMetodosPago() {
    if (_carrito.isEmpty) return;

    final double subtotal = _carrito.fold(0, (sum, item) => sum + item.precio);
    final double montoDescuento = subtotal * _porcentajeDescuento;
    final double totalFinal = subtotal - montoDescuento;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
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
              Text(
                'Monto final a abonar: \$${totalFinal.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 14, color: Color(0xFF8C6D58), fontWeight: FontWeight.bold),
              ),
              const Divider(height: 20),
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
      body: SafeArea(
        child: IndexedStack(
          index: _indiceSeleccionado,
          children: pantallas,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceSeleccionado,
        onDestinationSelected: (index) {
          setState(() {
            _indiceSeleccionado = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFF3ECE4),
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
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _carrito.isNotEmpty,
              label: Text('${_carrito.length}'),
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
// -----------------------------------------------------------------
class VistaInformacion extends StatelessWidget {
  final Function(Perfume) onAgregar;

  const VistaInformacion({super.key, required this.onAgregar});

  void _mostrarInfoBanner(BuildContext context, Map<String, dynamic> banner) {
    final Perfume perfumeAsociado = banner['producto'];

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
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
              mainAxisSize: MainAxisSize.min,
              children: [
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
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.8),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    )
                  ],
                ),
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
                              Navigator.pop(context);
                              onAgregar(perfumeAsociado);
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
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

          SizedBox(
            height: 340,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                final b = banners[index];
                final bool esBannerTres = (index == 2);

                return GestureDetector(
                  onTap: () => _mostrarInfoBanner(context, b),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
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
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: cargarImagen(
                            b['imagen']!,
                            fit: esBannerTres ? BoxFit.contain : BoxFit.cover,
                          ),
                        ),
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
// -----------------------------------------------------------------
class VistaMenu extends StatefulWidget {
  final Function(Perfume, {int cantidad}) onAgregar;

  const VistaMenu({super.key, required this.onAgregar});

  @override
  State<VistaMenu> createState() => _VistaMenuState();
}

class _VistaMenuState extends State<VistaMenu> {
  String _categoriaSeleccionada = 'Todos';

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
    final perfumesFiltrados = _categoriaSeleccionada == 'Todos'
        ? listaPerfumes
        : listaPerfumes.where((p) => p.categoria == _categoriaSeleccionada).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('COLECCIÓN EXCLUSIVA')),
      body: Column(
        children: [
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
                    selected: seleccionada,
                    selectedColor: const Color(0xFF8C6D58),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: seleccionada ? const Color(0xFF8C6D58) : const Color(0xFFE8DFD8),
                      ),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _categoriaSeleccionada = cat;
                      });
                    },
                  ),
                );
              },
            ),
          ),
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
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.65,
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
                        child: InkWell(
                          onTap: () => _abrirDetalleProducto(perfume),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
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
                                            overflow: TextOverflow.ellipsis,
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
// -----------------------------------------------------------------
class PantallaDetallePerfume extends StatefulWidget {
  final Perfume perfume;
  final Function(Perfume, {int cantidad}) onAgregar;

  const PantallaDetallePerfume({
    super.key,
    required this.perfume,
    required this.onAgregar,
  });

  @override
  State<PantallaDetallePerfume> createState() => _PantallaDetallePerfumeState();
}

class _PantallaDetallePerfumeState extends State<PantallaDetallePerfume> {
  int _cantidad = 1;

  @override
  Widget build(BuildContext context) {
    final perfume = widget.perfume;
    final totalCalculado = perfume.precio * _cantidad;

    return Scaffold(
      appBar: AppBar(
        title: Text(perfume.nombre),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              color: const Color(0xFFFBF9F6),
              child: cargarImagen(perfume.imagen, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            widget.onAgregar(perfume, cantidad: _cantidad);
                            Navigator.pop(context);
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
// -----------------------------------------------------------------
class VistaCarrito extends StatelessWidget {
  final List<Perfume> carrito;
  final double porcentajeDescuento;
  final VoidCallback onProcederPago;

  const VistaCarrito({
    super.key,
    required this.carrito,
    required this.porcentajeDescuento,
    required this.onProcederPago,
  });

  @override
  Widget build(BuildContext context) {
    final double subtotal = carrito.fold(0, (sum, item) => sum + item.precio);
    final double montoDescuento = subtotal * porcentajeDescuento;
    final double totalFinal = subtotal - montoDescuento;

    return Scaffold(
      appBar: AppBar(title: const Text('MI BOLSA DE COMPRAS')),
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
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8C6D58),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: onProcederPago,
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
// -----------------------------------------------------------------
class VistaSuscripcion extends StatefulWidget {
  final PerfilCliente? clienteExistente;
  final List<PedidoRealizado> historialPedidos;
  final Function(PerfilCliente) onRegistrar;

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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _cumpleController = TextEditingController();

  Future<void> _seleccionarCumple(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8C6D58),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _cumpleController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _guardarFormulario() {
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

      widget.onRegistrar(nuevoPerfil);

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
            widget.clienteExistente != null
                ? _construirPerfilGuardado(widget.clienteExistente!)
                : Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'DNI', border: OutlineInputBorder()),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
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
                        TextFormField(
                          controller: _cumpleController,
                          readOnly: true,
                          onTap: () => _seleccionarCumple(context),
                          decoration: const InputDecoration(
                            labelText: 'Fecha de Cumpleaños',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.cake, color: Color(0xFF8C6D58)),
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 20),
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
            _construirSeccionHistorial(),
          ],
        ),
      ),
    );
  }

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
          widget.historialPedidos.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Aún no has registrado compras.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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