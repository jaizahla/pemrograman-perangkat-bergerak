import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Input Data Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormMahasiswa(),
    );
  }
}

class FormMahasiswa extends StatefulWidget {
  const FormMahasiswa({super.key});

  @override
  State<FormMahasiswa> createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();

  String? _jenisKelamin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Input Data Mahasiswa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Input Nama
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input Email (validasi domain unsika.ac.id)
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  if (!RegExp(r'^[\w-\.]+@unsika\.ac\.id$')
                      .hasMatch(value)) {
                    return "Email harus menggunakan domain @unsika.ac.id";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input Nomor HP (hanya angka, min 10 digit)
              TextFormField(
                controller: _hpController,
                decoration: const InputDecoration(
                  labelText: "Nomor HP",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor HP tidak boleh kosong";
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Nomor HP hanya boleh angka";
                  }
                  if (value.length < 10) {
                    return "Nomor HP minimal 10 digit";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Dropdown Jenis Kelamin
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Jenis Kelamin",
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(),
                ),
                value: _jenisKelamin,
                items: const [
                  DropdownMenuItem(
                      value: "Laki-laki", child: Text("Laki-laki")),
                  DropdownMenuItem(
                      value: "Perempuan", child: Text("Perempuan")),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pilih jenis kelamin";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Tombol Simpan
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Simpan"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Data berhasil disimpan!")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}