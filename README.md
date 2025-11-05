# Goal Gear

A project developed with Flutter.

---

## Deskripsi Singkat

Goal Gear adalah aplikasi toko perlengkapan football versi mobile yang dikembangkan menggunakan Flutter. Aplikasi ini menampilkan daftar produk yang memungkinkan pengguna untuk melihat detail produk seperti nama, harga, deskripsi, thumbnail, kategori, dan lain-lain dengan tampilan yang responsif dan interaktif.

---

<details>
<Summary><b>Tugas 7</b></Summary>

## Widget Tree pada Flutter & Hubungan antar Widget

Dalam Flutter, widget tree adalah struktur hierarki yang menggambarkan bagaimana widget saling berhubungan dan tersusun di dalam antarmuka aplikasi. Setiap elemen di layar seperti text, tombol, gambar, atau tata letak merupakan sebuah widget, dan semua widget tersebut disusun membentuk pohon, di mana setiap widget bisa memiliki satu atau lebih widget lain di dalamnya. Pohon ini wimulai dari widget akar (biasanya `MaterialApp`) yang menjadi induk utama bagi seluruh tampilan aplikasi.

Hubungan parent-child (induk-anak) dalam widget tree menggambarkan bagaimana satu widget membungkus atau menampung widget lain. Widget parent bertanggung awab mengatur posisi, ukuran, atau perilaku dari widget child di dalamnya. Misalnya, widget `Column` dapat menjadi parent yang menampung beberapa child seperti `Text`, `Icon`, dan `Button`. Dalam hal ini, `Column` menentukan bagaimana anak-anaknya disusun secara vertikan. Namun, meskipun parent mengatur tata letak atau perilaku umum, setiap child tetap memiliki sifat dan fungsi masing-masing.

---

## Widget yang digunakan dalam project ini dan fungsinya

**Widget Aplikasi & Root**
- MyApp (StatelessWidget) : widget root aplikasi, membungkus seluruh app dan mengembalikan `MaterialApp` dengan tema dan halaman awal.
- MaterialApp : container tingkat-atas untuk aplikasi Material, mengatur title, tema (ThemeData) dan `home` (halaman awal).
- ThemeData : mendefinisikan skema warna dan tema visual aplikasi, mengatur primarySwatch dan colorScheme.
- MyHomePage (StatelessWidget) : custom widget yang menjadi halaman utama (`home`) dan menata seluruh layout tampilan utama.

**Widget Layout & Struktur**
- Scaffold : kerangka dasar halaman (menyediakan area `appBar`, `body`, dll.) untuk tata letak standar aplikasi.
- AppBar : bar di bagian atas layar yang menampilkan judul aplikasi dan latar warna dari tema.
- Padding : memberikan jarak/ruang di sekitar child (dipakai untuk memberi padding pada `body`).
- Column : menata anak-anaknya secara vertikal (dipakai berkali-kali untuk menyusun elemen vertikal).
- Row : menata anak-anaknya secara horizontal (dipakai untuk menempatkan tiga `InfoCard` berjejer).
- SizedBox : spacer sederhana untuk memberi jarak vertikal (mis. `SizedBox(height: 16.0)`).
- Center : memusatkan child secara horizontal/vertikal dalam ruang yang tersedia.
- GridView.count : menampilkan koleksi item dalam layout grid dengan jumlah kolom tetap (`crossAxisCount: 3`). di sini dipakai untuk menampilkan `ItemCard` dalam 3 kolom dan `shrinkWrap: true` agar tinggi grid mengikuti konten.

**Widget Material & Surface**
- Card : material card dengan elevasi/bayangan; dipakai di `InfoCard` untuk tampilan kotak informasi.
- Container : kotak serbaguna untuk mengatur ukuran, padding, dan styling internal (dipakai di `InfoCard` dan `ItemCard` untuk layout dan padding).
- Material : surface material yang memberi latar berwarna dan properti seperti `borderRadius` untuk tampilan `ItemCard`.

**Widget Interaksi & Feedback**
- InkWell : membuat area tappable dengan efek ripple; menangani callback `onTap` untuk menampilkan aksi saat ditekan.
- ScaffoldMessenger (berinteraksi melalui `ScaffoldMessenger.of(context)`) : mekanisme untuk menampilkan `SnackBar pada Scaffold` yang sesuai.
- SnackBar : widget pesan singkat yang muncul dari bawah layar, dipakai untuk memberi umpan balik saat `ItemCard` ditekan.

**Widget Konten**
- Text : widget untuk menampilkan teks (dipakai di judul AppBar, welcome text, InfoCard, ItemCard, dll.).
- Icon : menampilkan ikon (mengambil `IconData` dari `Icons.*` sesuai `ItemHomepage`).

**Widget Kustom & Data Model**
- InfoCard (custom StatelessWidget) : widget khusus untuk menampilkan pasangan `title` dan `content` dalam bentuk kartu kecil (menggabungkan `Card`, `Container`, `Column`, `Text`).
- ItemCard (custom StatelessWidget) : kartu item pada grid yang menampilkan ikon + nama, kombinasi `Material` (sebagai surface berwarna), `InkWell` (efek tekan), `Container`, `Column`, `Icon`, dan `Text`.
- ItemHomepage (data class) : bukan widget, melainkan model/data holder sederhana yang menyimpan `name`, `icon`, dan `color` untuk tiap item homepage.

**Utilities & Context Access**
- `MediaQuery.of(context).size.width` (bukan widget, tapi dipakai di `Container`) : mengambil lebar layar untuk menyesuaikan ukuran `InfoCard`.
- `Theme.of(context)` (bukan widget, tapi dipakai di `AppBar`) : mengakses tema aplikasi untuk warna dan styling.

---

## Fungsi Widget `MaterialApp`

`MaterialApp` adalah widget tingkat-atas yang menyediakan konfigurasi dan infrastruktur dasar untuk aplikasi yang menggunakan desain Material. Secara praktis ia mengemas banyak hal penting dalam satu tempat: tema (`ThemeData`) yang dipakai oleh seluruh widget Material, navigasi (`Navigator` dan routing), lokalitas/terjemahan (`Localizations`), `MediaQuery` (informasi ukuran layar dan orientasi), serta kontrol-perilaku global seperti `ScaffoldMessenger` untuk `SnackBar`, `Overlay`, dan opsi debug. Dengan menaruh semua ini di satu widget, widget-widget di bawahnya (mis. `Scaffold`, `AppBar`, `Text`, `Icon`, `InkWell`) bisa mengakses konfigurasi dan layanan tersebut lewat `BuildContext`—mis. `Theme.of(context)` atau `Navigator.of(context)`.

Karena `MaterialApp` menyediakan banyak inherited widget dan service penting itu, ia sering dijadikan widget root. Meletakkan `MaterialApp` di atas hirarki memastikan tema, routing, lokalitas, dan behavior Material lainnya tersedia untuk seluruh subtree tanpa perlu mengonfigurasinya ulang di tiap halaman. Ini membuat kode lebih konsisten dan lebih mudah dikelola: perubahan tema, daftar route, atau delegate lokalitas cukup dilakukan di satu tempat dan langsung memengaruhi seluruh aplikasi.

Sebagai catatan, kalau ingin tampilan bergaya iOS, bisa memakai `CupertinoApp`, atau kalau butuh kontrol minimal tanpa fitur Material lengkap, ada `WidgetsApp`. Namun untuk aplikasi Flutter yang mengadopsi gaya Material (komponen, ripple effect, elevation, dsb.), `MaterialApp` menjadi pilihan standar karena mempermudah integrasi dan memberikan behavior yang diharapkan dari ekosistem Material.

---

## Perbedan `StatelessWidget` dan `StatefulWidget` dan kapan memilihnya

**`StatelessWidget`** adalah widget yang tidak menyimpan state internal. Begitu dibuat, propertinya tidak bisa diubah lagi (immutable). Semua data yang ditampilkan harus berasal dari luar melalui parameter constructor. Widget ini hanya akan dibangun ulang ketika parent-nya ikut rebuild. Karena sederhana, `StatelessWidget` sangat ringan dan efisien. Contohnya: teks statis, ikon, atau tombol yang hanya memanggil fungsi dari parent tanpa mengubah tampilan sendiri.

**`StatefulWidget`** adalah widget yang bisa menyimpan state yang berubah-ubah. Widget ini terdiri dari dua bagian terpisah: bagian `StatefulWidget` yang immutable dan bagian `State` yang mutable. Ketika data berubah, kita memanggil `setState()` untuk meminta Flutter membangun ulang tampilan. `StatefulWidget` memiliki lifecycle yang lengkap, sehingga cocok untuk inisialisasi data, mendengarkan stream, mengatur timer, atau membersihkan resource. Contohnya: form input, animasi, toggle switch, atau komponen yang perlu mengambil data dari internet.

**Kapan memilih salah satunya?**
- Gunakan `StatelessWidget` ketika komponen benar-benar statis atau semua datanya berasal dari parent.
- Gunakan `StatefulWidget` ketika komponen perlu menyimpan data internal yang bisa berubah, seperti input pengguna, status loading, atau animasi.

---

## Pentingnya `BuildContext` di Flutter serta penggunaannya di metode `build`

`BuildContext` adalah sebuah handle (pegangan) yang menghubungkan kode widget dengan element-nya di pohon elemen. Ini bukan widget, juga bukan pohon itu sendiri, melainkan representasi dari posisi spesifik di mana sebuah widget dibangun.
- Unik untuk Setiap Widget Instance: Setiap kali widget dibuat (misalnya melalui metode build dari `StatelessWidget` atau `State` pada `StatefulWidget`), Flutter akan memberikan `BuildContext` yang unik untuk instance tersebut.
- Stabil dalam Siklus Hidup: `BuildContext` tidak berubah selama lifecycle dari elemen tersebut, meskipun widgetnya bisa di-rebuild.
- Hierarkis: `BuildContext` menyimpan referensi ke leluhur (ancestor) di atasnya dalam hierarki. Dengan kata lain, `context` tahu siapa induk atau nenek moyangnya.

`BuildContext` adalah jembatan utama yang memungkinkan sebuah widget berinteraksi dengan lingkungannya, terutama dengan widget-widget leluhur di atasnya. Tanpa `context`, widget akan terisolasi sepenuhnya, ia tidak tahu tema apa yang digunakan, ukuran layar berapa, navigator mana yang aktif, atau bahkan tidak bisa berpindah halaman.

Dengan `context`, widget dapat melakukan pencarian ke atas (ancestor lookup) di dalam pohon elemen untuk menemukan informasi atau layanan yang disediakan oleh leluhurnya.

Beberapa contoh penggunaan umum `BuildContext`:
1. Mengambil Tema (Theme):
`Theme.of(context)` artinya “carikan aku objek `Theme` terdekat di pohon ini agar aku tahu warna dan gaya yang digunakan.”
Flutter akan menelusuri pohon dari context saat ini ke atas hingga menemukan `InheritedWidget` bertipe `Theme`.
2. Navigasi (Navigator):
`Navigator.of(context).push(...)` artinya “temukan `Navigator` terdekat di atas pohon, lalu tambahkan halaman baru ke stack navigasi-nya.”
3. Mengambil Informasi Perangkat (MediaQuery):
`MediaQuery.of(context).size` akan mencari `MediaQuery` yang biasanya berada di paling atas (dibungkus oleh `MaterialApp`) untuk mengetahui ukuran layar perangkat.
4. State Management (Provider / InheritedWidget):
`Provider.of<MyModel>(context)` meminta context untuk mencari ancestor yang menyediakan data `MyModel`. Ini adalah dasar cara kerja state management berbasis inherited widgets.
5. Menampilkan SnackBar (ScaffoldMessenger):
`ScaffoldMessenger.of(context).showSnackBar(...)` mencari `ScaffoldMessenger` terdekat yang dikelola oleh `MaterialApp` untuk menampilkan pesan di layar.

---

## Konsep "hot reload" di Flutter dan bedanya dengan "hot restart"

**Hot Reload**
Hot Reload adalah fitur pengembangan Flutter yang memungkinkan developer memperbarui kode aplikasi secara instan tanpa kehilangan state yang sedang berjalan. Ketika Anda melakukan hot reload, Flutter hanya mengkompilasi ulang kode yang diubah dan menyuntikkannya ke Dart Virtual Machine (VM) yang sedang berjalan. Proses ini sangat cepat (biasanya 1-2 detik) karena tidak perlu membangun aplikasi dari awal.

Keuntungan utama hot reload adalah preservasi state aplikasi. Semua data seperti input form, posisi scroll, nilai variabel, status animasi, dan state bisnis lainnya tetap terjaga. Ini membuat proses development sangat efisien karena Anda bisa terus menguji alur tertentu tanpa harus mengulangi langkah-langkah dari awal.

Kapan menggunakan hot reload:
- Mengubah UI/tampilan visual
- Memperbaiki bug kecil
- Menyesuaikan styling (warna, font, padding)
- Mengubah teks atau konten statis
- Mengoptimalkan layout

**Hot Restart**
Hot Restart adalah proses yang lebih komprehensif yang merestart seluruh aplikasi dari nol. Dart VM direset, kode dikompilasi ulang sepenuhnya, dan aplikasi dijalankan kembali dari method `main()`. Semua state aplikasi akan dikembalikan ke kondisi awal, persis seperti ketika aplikasi pertama kali dijalankan.

Proses ini membutuhkan waktu sedikit lebih lama (biasanya 3-5 detik) dibanding hot reload karena harus menginisialisasi ulang semua komponen dan dependencies. Namun, hot restart tetap lebih cepat daripada full rebuild yang diperlukan di platform native.

Kapan menggunakan hot restart:
- Mengubah kode inisialisasi di main() method
- Menambahkan atau mengubah package dependencies
- Modifikasi pada global state management
- Ketika state aplikasi menjadi corrupt atau tidak konsisten
- Perubahan pada konfigurasi theme atau routes level aplikasi

</details>

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
