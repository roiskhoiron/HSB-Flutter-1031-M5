# Assessment Mission 6 🚀 Habitly

Halo student HSB-1031! 👋  

Terima kasih sudah menyelesaikan Mission 6 pada Bootcamp Flutter Batch 1.

Aplikasi sudah persisten dan provider utama berfungsi, namun implementasi Riverpod belum konsisten di seluruh state aplikasi (tema/navigation masih di luar provider pattern), serta error/loading state masih minimal.

---

## 📊 Aspek Penilaian

| Aspek Penilaian | Detail Item Penilaian | Poin Maksimal |
|-----------------|----------------------|---------------|
| Feature Completeness | Semua fitur sesuai instruction | 20 |
| Riverpod Implementation | StateNotifier/Notifier usage, state flow | 15 |
| Hive Integration | Persistensi data & adapter | 15 |
| Architecture & Structure | Separation of concerns | 15 |
| Clean Code | Naming, readability, modularity | 10 |
| Error Handling | Try-catch, fallback state | 10 |
| UI States | Loading, Empty, Error state | 10 |
| Maintainability | Scalability & structure | 5 |

---

## 📝 Raport Skor

| Aspek Penilaian | Skor Dicapai | Komentar Ramah & Kritis |
|-----------------|-------------|--------------------------|
| Feature Completeness | 17/20 | Habit CRUD dan persistence tersedia, namun flow state belum sepenuhnya modern Riverpod. |
| Riverpod Implementation | 12/15 | Provider inti ada, tetapi theme/global state masih `ValueNotifier`. |
| Hive Integration | 14/15 | Adapter + open box sudah benar. |
| Architecture & Structure | 12/15 | Ada pemisahan providers/pages/models, namun struktur page cukup gemuk dan berulang. |
| Clean Code | 9/10 | Naming cukup baik, tetapi ada duplicate import dan route yang tidak dipakai. |
| Error Handling | 8/10 | Operasi provider minim handling exception/failure feedback. |
| UI States | 10/10 | Loading/empty state list habit sudah ada. |
| Maintainability | 4/5 | Dasar maintainable oke, butuh konsistensi state strategy. |

**Total Skor: 86 / 100 🎯**

---

## 2️⃣ Temuan Detail per File

### ✅ Hal yang Sudah Bagus
- `lib/providers/habit_provider.dart` sudah memusatkan CRUD habit ke notifier.
- Data tersimpan di Hive dan dipakai ulang saat app berjalan.
- UI list habit sudah menangani empty/loading state dengan cukup baik.

### ⚠️ Perlu Peningkatan
- `main.dart` theme masih `ValueNotifier` global, tidak Riverpod.
- Tidak ada guard pada adapter registration.
- Beberapa operasi notifier belum melaporkan kegagalan ke UI.

---

## 3️⃣ Inline Review Simulation

lib/main.dart

Line 20:  
❌ Theme dikelola `ValueNotifier` global, bukan provider Riverpod.
Suggestion: Buat `themeProvider` agar seluruh state aplikasi konsisten dan mudah diuji.

Severity: Medium  
Impact: State management jadi campuran dan memperbesar technical debt.

lib/main.dart

Line 26:  
⚠️ `Hive.registerAdapter(HabitAdapter())` dipanggil tanpa `Hive.isAdapterRegistered` guard.
Suggestion: Tambahkan guard untuk mencegah exception saat reinitialize.

Severity: Medium  
Impact: Potensi runtime error pada lifecycle tertentu.

lib/providers/habit_provider.dart

Line 17:  
⚠️ `build()` langsung return `AsyncData` tanpa fase loading/error handling eksplisit.
Suggestion: Gunakan `AsyncNotifier` atau set loading state saat bootstrap agar lifecycle lebih robust.

Severity: Low  
Impact: Sulit membedakan state awal vs data sudah siap saat app scale up.

lib/pages/home_page_main.dart

Line 23:  
⚠️ `setState` untuk bottom navigation masih dipakai di screen yang juga mengandalkan provider.
Suggestion: Untuk konsistensi arsitektur, simpan index tab pada provider sederhana.

Severity: Low  
Impact: Pattern state campuran membuat debugging lebih sulit.

---

## 💡 Saran Pengembangan Berikutnya

1. Migrasikan theme/navigation state ke Riverpod provider agar arsitektur konsisten.
2. Tambahkan error handling terstruktur di notifier untuk feedback kegagalan Hive.
3. Rapikan route/import yang tidak dipakai agar codebase lebih bersih.

---

## 🧠 Kesimpulan Teknis

Implementasi sudah functional dan cukup rapi untuk level intermediate, tetapi belum sepenuhnya mencapai standar Mission 6 untuk konsistensi state management modern dan robustness lifecycle.
