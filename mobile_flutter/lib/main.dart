import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TimViecLamApp());
}

class TimViecLamApp extends StatelessWidget {
  const TimViecLamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimViecLam',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool _loading = true;
  bool _logged = false;
  String _email = '';

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tvltoken');
    final email = prefs.getString('tvluser') ?? '';
    setState(() {
      _loading = false;
      _logged = token != null && token.isNotEmpty;
      _email = email;
    });
  }

  Future<void> _doLogin(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tvltoken', 'tok_' + DateTime.now().millisecondsSinceEpoch.toString());
    await prefs.setString('tvluser', email);
    setState(() {
      _logged = true;
      _email = email;
    });
  }

  Future<void> _doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tvltoken');
    await prefs.remove('tvluser');
    setState(() {
      _logged = false;
      _email = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_logged) {
      return Dashboard(email: _email, onLogout: _doLogout);
    }

    return LoginPage(onLogin: _doLogin);
  }
}

class LoginPage extends StatefulWidget {
  final Future<void> Function(String email) onLogin;
  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    await Future.delayed(const Duration(milliseconds: 400)); // simulate network delay
    await widget.onLogin(_emailController.text.trim());
    setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Nhập email';
                  if (!v.contains('@')) return 'Email không hợp lệ';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pwController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Nhập mật khẩu';
                  if (v.length < 4) return 'Mật khẩu ít nhất 4 ký tự';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _busy ? null : _submit,
                  child: _busy ? const SizedBox(height:16,width:16,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2)) : const Text('Đăng nhập'),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Ghi chú: đây là demo. Nhập email hợp lệ và mật khẩu ≥4 ký tự.'),
            ],
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  final String email;
  final Future<void> Function() onLogout;
  const Dashboard({super.key, required this.email, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bảng điều khiển')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Xin chào, $email!', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Bạn đã đăng nhập vào Flutter mobile app (mẫu).'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => onLogout(), child: const Text('Đăng xuất'))
          ],
        ),
      ),
    );
  }
}
