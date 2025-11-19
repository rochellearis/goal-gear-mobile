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

<details>
<Summary><b>Tugas 8</b></Summary>

## Perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter dan kapan menggunakannya dalam aplikasi Goal Gear

**`Navigator.push()`**
- Menambahkan halaman baru ke dalam stack navigasi (tumpukan halaman). Halaman sebelumnya tetap tersimpan di dalam stack.
- Pengguna dapat kembali ke halaman sebelumnya dengan menekan tombol back karena halaman lama tetap ada di bawah dan bisa kembali (back) ke sana.

Contoh:
```
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProductFormPage()),
),
```
Kasus diatas menggunakan `Navigator.push()` untuk membuka form pembuatan product yang sementara yang bisa dibatalkan. Pengguna bisa kembali ke halaman sebelumnya (back button).

**`Navigator.pushReplacement()`**
- Mengganti halaman saat ini dengan halaman baru di stack navigasi. Halaman sebelumnya dihapus dari stack. Setelah `pushReplacement`, menekan back tidak akan kembali ke route yang digantikan (karena sudah dihapus).
- Berguna untuk mengganti halaman saat keadaan berubah (mis. setelah login selesai, dsb). 
- Pengguna tidak dapat kembali ke halaman yang diganti, tetapi langsung ke halaman sebelumnya.

Contoh:
```
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => MyHomePage()),
);
```
Dalam kasus diatas, `Navigator.pushReplacement()` mengganti halaman saat ini dengan `MyHomePage()` dan menghapus halaman sebelumnya dari stack,
sehingga pengguna tidak bisa kembali ke halaman lama dengan tombol back.

---

## Pemanfaatan hierarchy widget seperti `Scaffold`, `AppBar`, dan `Drawer` untuk membangun struktur halaman yang konsisten

- Meletakkan `Scaffold` sebagai container utama untuk setiap layar (screens) (`MyHomePage` dan `ProductFormPage`), sehingga setiap layar punya struktur dasar yang konsisten (area AppBar, drawer, body).

- Di tiap `Scaffold`, menambahkan `AppBar` sehingga setiap halaman punya header konsisten: judul, warna latar, dan styling yang terlihat seragam di sebagian besar halaman.

- Menggunakan satu widget `LeftDrawer` terpisah dan memasangnya di properti `drawer` pada `Scaffold` di halaman-halaman yang butuh menu, sehingga isi drawer sama di banyak halaman (reuse komponen).

- `LeftDrawer` berisi `DrawerHeader` dan `ListTile` untuk navigasi, `ListTile` memanggil `Navigator.push` atau `Navigator.pushReplacement`, artinya navigasi dilakukan dari drawer, bukan di setiap halaman secara terpisah.

- Karena `LeftDrawer` dipakai di `MyHomePage` dan `ProductFormPage`, pengguna mendapatkan pengalaman navigasi dan tampilan sidebar yang konsisten di kedua layar.

- Pada `MyHomePage`, memakai `AppBar` dengan warna dari `Theme.of(context).colorScheme.primary`, sementara di `ProductFormPage`, `AppBar` memakai `Colors.indigo`, ini menunjukkan pemanfaatan `AppBar` untuk kontrol tampilan header, walau ada sedikit perbedaan warna antar halaman.

- Konten utama (body) tiap `Scaffold` diatur dengan layout yang jelas: `Column`, `GridView`, `SingleChildScrollView`, dll., sehingga area konten berada di bawah `AppBar` dan di samping drawer secara konsisten.

- Untuk navigasi dari tombol/kartu (`ItemCard`), memanggil `Navigator.push` dan juga menampilkan `SnackBar` lewat `ScaffoldMessenger.of(context)`, memanfaatkan `Scaffold` sebagai host untuk pesan UI (snack bar).

- Di halaman form, memanfaatkan `Scaffold` juga untuk menaruh tombol simpan dan dialog, serta menggunakan gaya input (`OutlineInputBorder, padding`) yang konsisten antar field sehingga form terlihat seragam dengan layout aplikasi lainnya.

---

## Kelebihan penggunaan layout widget seperti `Padding`, `SingleChildScrollView`, dan `ListView` saat menampilkan elemen-elemen form dan contohnya

**`Padding`**
Penggunaan widget Padding dalam desain antarmuka memberikan kelebihan dalam menciptakan ruang kosong yang konsisten di sekitar elemen-elemen form, sehingga meningkatkan keterbacaan dan organisasi visual. Dalam konteks form, Padding membantu memisahkan setiap field input dengan jelas, mengurangi kesan berdesakan, dan memberikan ruang pernapasan yang membuat interface terlihat lebih profesional. Selain itu, padding yang konsisten juga meningkatkan pengalaman pengguna dengan membuat elemen-eu lebih mudah dibaca dan diinteraksi, terutama pada perangkat mobile yang memiliki layar terbatas.
Contoh:
```
Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    decoration: InputDecoration(
      hintText: "Nama Produk",
      labelText: "Nama Produk",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    // ... kode validator dan onChanged
  ),
),
```

**`SingleChildScrollView`**
Widget SingleChildScrollView memberikan kelebihan crucial dalam menangani konten yang melebihi batas layar dengan memungkinkan scrolling vertikal. Pada form yang memiliki banyak field input seperti form tambah produk, penggunaan SingleChildScrollView memastikan semua elemen form tetap dapat diakses tanpa terpotong oleh batas layar perangkat. Hal ini sangat penting untuk menjaga usability aplikasi, terutama pada perangkat dengan layar kecil, karena pengguna dapat dengan mudah menggeser layar untuk mengisi seluruh field form tanpa kesulitan.
Contoh:
```
body: Form(
  key: _formKey,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Semua field form berada di dalam sini
        Padding(...), // Field Nama Produk
        Padding(...), // Field Harga
        // ... dan seterusnya
      ],
    ),
  ),
),
```

**`ListView`**
ListView widget menawarkan kelebihan dalam menampilkan daftar elemen yang efisien dan dapat di-scroll, baik secara vertikal maupun horizontal. Dalam konteks navigation drawer, ListView sangat ideal karena secara otomatis menangani scrolling ketika jumlah menu melebihi tinggi layar, sekaligus mengoptimalkan performa dengan hanya merender elemen yang terlihat di layar. Ini memastikan pengalaman navigasi yang smooth dan konsisten, terlepas dari berapa banyak item menu yang ditambahkan ke dalam drawer.
Contoh:
```
class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(...),
          ListTile(...), // Menu Home
          ListTile(...), // Menu Add Product
        ],
      ),
    );
  }
}
```

---

## Penyesuaian warna tema agar aplikasi Goal Gear memiliki identitas visual yang konsisten dengan brand toko

- Telah menegaskan palet warna utama pada elemen navigasi dan form: AppBar di halaman utama diikat ke `Theme.of(context).colorScheme.primary` sementara AppBar halaman tambah produk dan tombol simpan menggunakan `Colors.indigo` dengan `foregroundColor: Colors.white`, sehingga bar navigasi dan tombol aksi menampilkan warna latar gelap dan teks putih yang konsisten.

- Bagian drawer diberi identitas visual tersendiri melalui `DrawerHeader` yang menggunakan `Colors.blue` sebagai latar dan teks putih tebal untuk judul serta deskripsi, sehingga header drawer menjadi elemen berwarna yang mudah dikenali sebagai bagian dari brand.

- Daftar item pada halaman utama dibuat menggunakan warna aksen per-item (`Colors.blue`, `Colors.green`, `Colors.red`) yang diteruskan ke `ItemCard` sebagai latar, dan setiap kartu menampilkan ikon serta teks berwarna putih untuk menjaga kontras dan keseragaman tampilan pada elemen-elemen berwarna.

- Secara keseluruhan, penggunaan warna latar biru/indigo pada komponen navigasi dan tombol aksi, ditambah penggunaan teks/ikon putih pada latar berwarna serta pewarnaan aksen pada kartu produk, menunjukkan penyesuaian warna yang konsisten untuk membentuk identitas visual toko.

</details>

---

<details>
<Summary><b>Tugas 9</b></Summary>

## Mengapa perlu membuat model Dart saat mengambil/mengirim data JSON dan konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model

Kita perlu membuat Model Dart (seperti kelas `ProductEntry`) saat mengambil atau mengirim data JSON karena model tersebut menyediakan struktur data yang jelas dan tipenya terjamin (Type Safety). Model ini memastikan setiap field memiliki tipe yang tepat, sehingga kesalahan seperti salah mem-parsing angka sebagai string atau menerima `null` yang tidak diharapkan bisa dicegah sebelum aplikasi jalan.

Jika kita hanya menggunakan `Map<String, dynamic>` secara langsung, konsekuensinya adalah:
- Validasi Tipe dan Null-Safety: Dart akan kehilangan kemampuan untuk memeriksa tipe data pada waktu kompilasi (compile-time). Setiap kali mengakses data (misalnya, `product['price']`), maka harus secara manual melakukan casting atau pemeriksaan null-safety (`as int?` atau `!`) yang rentan terhadap runtime error jika data dari server tidak sesuai ekspektasi. Dengan model Dart, jika properti diset sebagai `required int price`, Dart akan memaksa untuk menangani potensi null atau salah tipe pada saat deserialisasi.
- Maintainability dan Keterbacaan: Kode menjadi sulit dipertahankan (maintainable). Jika struktur JSON berubah, maka harus mencari dan mengubah setiap tempat di mana `Map` tersebut digunakan. Dengan model, sudah cukup mengubah definisi kelas model, dan compiler akan menunjukkan di mana kode perlu diperbarui.

---

## Fungsi package `http` dan `CookieRequest` dalam tugas ini dan perbedaan perannya

`package:http` adalah paket dasar di Flutter yang menyediakan fungsi untuk melakukan permintaan HTTP (GET, POST, dll.) ke server tanpa mekanisme penyimpanan sesi atau cookie. Fungsinya adalah sebagai alat komunikasi mentah antara aplikasi Flutter dan server internet. Sangat cocok untuk mengambil data publik atau request one-off yang tidak butuh autentikasi.

`package:pbp_django_auth` yang menyediakan kelas `CookieRequest` adalah wrapper di atas `package:http`. Peran utamanya adalah untuk mengelola session (cookie) secara otomatis. Setiap kali melakukan request (misalnya login, register, atau post data), `CookieRequest` akan mengirimkan cookie sesi ke Django. Sebaliknya, ketika Django mengirim Set-Cookie (misalnya setelah login), `CookieRequest` akan secara otomatis menyimpan cookie tersebut dan menggunakannya untuk request berikutnya. Perbedaan Peran: `http` hanya melakukan transfer data, `CookieRequest` melakukan transfer data sekaligus mengelola status sesi (autentikasi) berdasarkan cookie.

---

## Alasan instance `CookieRequest` perlu untuk dibagikan ke semua komponen di aplikasi Flutter

Instance `CookieRequest` perlu dibagikan ke semua komponen aplikasi Flutter, biasanya melalui Provider (menggunakan `context.watch` atau `context.read`), karena instance tersebut menyimpan status sesi unik pengguna yang sedang login.

Ketika pengguna berhasil login, `CookieRequest` akan menerima dan menyimpan session cookie. Semua request API (seperti mengambil daftar produk, menambahkan produk, atau menghapus produk) harus menggunakan instance `CookieRequest` yang sama ini untuk memastikan bahwa cookie otentikasi dikirim ke Django. Jika setiap komponen membuat instance `CookieRequest` baru, session cookie akan hilang, dan Django akan menganggap pengguna tersebut belum terautentikasi untuk setiap request baru.

---

## Konfigurasi konektivitas agar Flutter dapat berkomunikasi dengan Django

Agar Flutter dapat berkomunikasi dengan Django, diperlukan konfigurasi konektivitas spesifik, terutama saat menjalankan Django di `localhost` dan Flutter di emulator atau perangkat fisik:

**1. `10.0.2.2` pada `ALLOWED_HOSTS`:**
- Mengapa: Ketika aplikasi berjalan di Emulator Android, localhost emulator tersebut menunjuk ke dirinya sendiri, bukan ke mesin pengembangan (tempat Django berjalan). IP `10.0.2.2` adalah alamat IP khusus yang digunakan oleh emulator Android untuk merujuk ke loopback interface (127.0.0.1) dari mesin host (komputer sendiri).
- Konsekuensi Jika Salah: Django akan menolak request dari IP ini dengan `DisallowedHost` error.

**2. CORS (Cross-Origin Resource Sharing):**
- Mengapa: Secara default, browser dan aplikasi ketat dalam menerima sumber daya dari origin (kombinasi protokol, domain, dan port) yang berbeda. Django, dalam mode pengembangan, sering kali dianggap berbeda origin dari aplikasi Flutter, terutama jika Flutter dijalankan dari alamat default `http://localhost:<port_flutter>` dan Django dari `http://localhost:8000`. Kita perlu mengaktifkan CORS (`django-cors-headers`) untuk memberitahu Django bahwa aman untuk melayani request dari origin Flutter.
- Konsekuensi Jika Salah: Request akan diblokir oleh Django/webview dengan CORS Policy Error.

**3. Pengaturan SameSite/Cookie:**
- Mengapa: Django secara default mungkin menggunakan pengaturan cookie ketat (seperti `SameSite=Lax` atau `Strict`) yang dirancang untuk browser. Pengaturan ini dapat menyebabkan session cookie tidak dikirim oleh Flutter (yang bertindak sebagai klien non-browser) dalam request lintas site (meskipun secara teknis request tersebut berasal dari alamat berbeda).
- Konsekuensi Jika Salah: Cookie otentikasi tidak akan diterima atau dikirim balik, menyebabkan login gagal atau pengguna dianggap tidak terautentikasi meskipun sudah login.

**4. Izin Akses Internet di Android:**
- Mengapa: Aplikasi Android, secara default, tidak memiliki izin untuk menggunakan jaringan internet. Izin `android.permission.INTERNET` harus ditambahkan di `AndroidManifest.xml` agar aplikasi dapat membuat request HTTP (seperti yang dilakukan oleh `http` atau `CookieRequest`).
- Konsekuensi Jika Salah: Semua request HTTP akan gagal total tanpa notifikasi yang jelas, seringkali hanya menampilkan pesan timeout atau SocketException.

---

## Mekanisme pengiriman data mulai dair input hingga dapat ditampilkan pada Flutter

Mekanisme pengiriman data dari Flutter ke Django (misalnya, membuat produk baru) dan menampilkannya kembali melibatkan langkah-langkah berikut:

**1. Input dan Pengumpulan Data (Flutter):** Pengguna mengisi formulir di Flutter. Data dikumpulkan menjadi objek Map Dart, kemudian diubah menjadi string JSON menggunakan `dart:convert`.

**2. Pengiriman Data (Flutter):** Objek `CookieRequest` melakukan request POST ke endpoint Django yang sesuai (misalnya, `/create-product-flutter/`), mengirimkan string JSON tersebut sebagai body request bersama dengan session cookie otentikasi.

**3. Penerimaan dan Pemrosesan Data (Django):** Django menerima request POST. Fungsi view menggunakan `@csrf_exempt` (atau validasi CSRF) dan membaca body request. Django kemudian mem-parsing string JSON menjadi objek Python (`dict`) menggunakan `json.loads()`.

**4. Penyimpanan Data (Django):** Data dari `dict` Python divalidasi dan digunakan untuk membuat instance model (misalnya `Product`) baru, kemudian disimpan ke database.

**5. Respon Data (Django):** Setelah berhasil, Django mengirimkan JSON Response (misalnya, `{"status": "success"}`) kembali ke Flutter.

**6. Update UI (Flutter):** Flutter menerima respon sukses. Aplikasi menampilkan notifikasi (SnackBar) dan, yang terpenting, bernavigasi kembali ke halaman utama. Halaman utama kemudian mungkin memuat ulang data dari Django (melalui GET request ke `/get-product-json/`) untuk menampilkan produk baru di daftar.

---

## Mekanisme autentikasi dari login, register, hingga logout

Mekanisme ini berpusat pada penggunaan session cookie yang dikelola oleh `CookieRequest`:

**1. Register/Login (Flutter):** Pengguna mengisi formulir (username, password). `CookieRequest` mengirimkan data kredensial dalam request POST (ke `/register/` atau `/login/`).

**2. Pemrosesan Autentikasi (Django):**
- Django menerima request. Untuk Login, Django memverifikasi kredensial.
- Jika berhasil, Django membuat sesi baru untuk pengguna tersebut dan mengirimkan header `Set-Cookie` (mengandung `sessionid` dan `csrftoken`) kembali ke Flutter.

**3. Penyimpanan Sesi (Flutter):** Objek `CookieRequest` secara otomatis menangkap header `Set-Cookie` dan menyimpan cookie sesi tersebut secara internal.

**4. Tampil Menu (Flutter):** Flutter menerima respon sukses. Komponen `CookieRequest` yang dibagikan melalui Provider kini memiliki cookie yang valid. Aplikasi bernavigasi ke halaman utama atau menu yang memerlukan autentikasi. Karena instance `CookieRequest` yang sama digunakan, menu yang memerlukan autentikasi dapat ditampilkan, dan request API selanjutnya akan otomatis menggunakan cookie yang tersimpan.

**5. Logout (Flutter & Django):** Ketika pengguna menekan Logout, `CookieRequest` mengirimkan request ke endpoint `/logout/`. Django menghancurkan sesi di database. Django kemudian mengirimkan header `Set-Cookie` yang kosong atau kedaluwarsa. `CookieRequest` menghapus cookie sesi yang tersimpan secara internal. Pengguna dianggap telah logout, dan aplikasi dapat bernavigasi kembali ke halaman login.

---

## Implementasi checklist step-by-step

1. **Setup Autentikasi pada Django untuk Flutter**
  Membuat `django-app` bernama `authentication` lalu melakukan `pip install-django-cors-headers` setelah itu menambahkan beberapa variabel CORS dan CSRF cookie pada `settings.py` main project Django.
  Tambahkan `10.0.2.2` pada `ALLOWED_HOSTS` untuk keperluan integrasi ke Django dari emulator Android.
  Buat fungsi login pada `authentication/views.py` dan lakukan URL routing.
  Install package yang disediakan tim asisten dosen, lalu modifikasi root widget untuk menyediakan `CookieRequest` library ke semua child widgets dengan menggunakan `Provider`
  Buat file baru `login.dart` dan isi dengan logic login Flutter. Lalu ubah home menjadi `LoginPage()`.
  Tambahkan fungsi register pada `authentication/views.py` dan lakukan URL routing.
  Buat file baru `register.dart` dan isi dengan logic register Flutter setelah itu import `register.dart()` lalu update fungsi onTap untuk navigasi ke halaman `RegisterPage`

2. **Pembuatan Model Kustom**
  Memanfaatkan website Quicktype dengan membuka endpoint JSON `http://localhost:8000/json/`. Salin data JSON tersebut dan gunakan situs Quicktype untuk mendapatkan models yang diperlukan.
  Setelah mendapatkan kode model melalui Quicktype, buat folder baru `models/` pada `lib/` dan buat file baru `product_entry.dart` dan copy-paste kode yang sudah disalin dari Quicktype.

3. **Penerapan Fetch Data dari Django Untuk Ditampilkan ke Flutter**
  Tambahkan package tambahan `http` dengan melakukan `flutter pub add http` pada proyek Flutter lalu tambahkan `<uses-permission android:name="android.permission.INTERNET" />` pada file `android/app/src/main/AndroidManifest.xml`.
  Tambahkan `import requests` pada `main/views.py` pada proyek Django lalu tambahkan fungsi `proxy_image` untuk mengatasi masalah CORS pada gambar dan lakukan URL routing.
  Buat file baru pada `lib/widgets` dengan nama `product_entry_card.dart` dan pada `lib/screens` dengan nama `product_entry_list.dart`. Setelah itu tambah halaman `product_entry_list.dart` ke `widgets/left_drawer.dart` untuk routing ke product list page.
  Ubah fungsi tombol `All Products` pada halaman utama agar mengarahkan ke halaman `ProductEntryListPage`
  Buat file baru pada `lib/screens` dengan nama `product_detail.dart` yang isinya akan menampilkan detail produk sesuai dengan model.
  Update `news_entry_list.dart` untuk menambahkan navigasi/routing ke halaman detail produk.

4. **Integrasi Form Flutter Dengan Layanan Django**
  Pada proyek Django, buat fungsi `create_product_flutter` pada `main/views.py` untuk melakukan create product lewat Flutter dengan logic yang sama pada web Django lalu lakukan URL routing.
  Pada proyek Flutter, tambah import yang diperlukan pada `productlist_form.dart` lalu hubungkan halaman `productlist_form.dart` dengan `CookieRequest` setelah itu pada `onPressed()`, implementasi response Json dengan model yang sesuai dan lakukan validasi successs dan jika tidak success menambahkan product.

5. **Implementasi Fiture Logout**
  Buat fungsi untuk logout pada `authentication/views.py` (proyek Django) dan tambah import yang diperlukan kemudian tambahkan fungsi `logout` lalu lakukan URL routing pada `authentication/urls.py`.
  Pada `lib/widgets/news_card.dart` tambahkan import yang diperlukan dan ubah metthod `build` untuk menambahkan `CookieRequest` dan ubah perintah `onTap: () {...}` pada widget `Inkwell` menjadi `onTap: () async {...}` agar dapat melakukan logout secara asinkronus.
  Lalu tambahkan navigasi untuk melakukan logout jika tombol logout di-tap/click yang akan meng-logout pengguna.
  Tambah tombol logout pada `menu.dart` dibawah tombol-tombol lainnya. 

</details>

---