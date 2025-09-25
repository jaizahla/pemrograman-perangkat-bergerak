import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman Formulir',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormMahasiswaPage(),
    );
  }
}

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});
  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();

//boleh null 2 ini tipe data utama nya
  DateTime? tglLahir; //tanda tanya ngsih tau klo variabel tgl lahir ini oleh null
  TimeOfDay? jamBimbingan;

  String get tglLahirLabel => tglLahir == null //getter untuk ngambil nilai, ini tdk tersedia scr publik jd pk getter biar lebih mudah
      ? 'Pilih Tanggal Lahir' //mksd dr tanda tanya (ini salah satu bentuk penulisan lain dr if else pengganti nya pk tnda tanya) klo true bakal nampilin pilih tgl lahir,klo false nnt akan nampilin option yg dibawah pilih tgl lahir
      : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';
  String get jamLabel => jamBimbingan == null
      ? 'Pilih Jam Bimbingan'
      : '${jamBimbingan!.hour}:${jamBimbingan!.minute}';

      @override
void dispose() {
  cNama.dispose();
  cNpm.dispose();
  cEmail.dispose();
  cAlamat.dispose();
  super.dispose();
}
Future<void> _pickDate() async { //async dgn await berhubungan
  final res = await showDatePicker(
    context: context,
    firstDate: DateTime(2001),
    initialDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );
  if (res != null) setState(() => tglLahir = res); //ngecek apkh ress nya berisi atau engga klo berisi bakal set state
  }

Future<void> _pickJamBimbingan() async {
  final res = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (res != null) setState(() => jamBimbingan = res);
}

void simpan() {
  if (!_formKey.currentState!.validate() || //tanda seru brrt kebalikan nya, si if ini ngecek validasi nya dilakuin atau tidak
      tglLahir == null ||
      jamBimbingan == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar( //ngasih tau data blm lengkap klo validasi ada yg ga sesuai
      const SnackBar(content: Text('Data belum lengkap')),
    );
    return; // lalu akan return
  }
  showDialog( //jika tdk terjadi apa2 maka akan menampilkan dialog
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Ringkasan Data'),
      content: Text(
        'Nama : ${cNama.text}\nNPM: ${cNpm.text}\nEmail: ${cEmail.text} \nAlamat: ${cAlamat.text} \nTanggalLahir: $tglLahirLabel\nJam Bimbingan: $jamLabel',
      ),
    ),
  );
}
@override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Formulir Mahasiswa')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(labelText: 'Nama'),
              validator: (value) =>
              value == null || value.isEmpty ? 'Nama harus diisi' : null,
            ),
            TextFormField(
              controller: cNpm,
              decoration: const InputDecoration(labelText: 'NPM'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email harus diisi';
                final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                return ok ? null : 'Format email salah';
              },
            ),
            TextFormField(
              controller: cEmail,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {

              value == null || value.isEmpty ? 'Email harus diisi' : null,
            ),
            TextFormField(
              controller: cAlamat,
              decoration: const InputDecoration(labelText: 'Alamat'),
              maxLines: 3,
              validator: (value) =>
              value == null || value.isEmpty ? 'Alamat harus diisi' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(tglLahirLabel),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text(jamLabel),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _simpan,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    ),
  );