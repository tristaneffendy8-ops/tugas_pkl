<template>
  <div class="min-h-screen bg-white font-Montserrat flex flex-col">
    <!-- Navbar -->
    <header class="border-b border-slate-200 bg-white sticky top-0 z-50">
      <nav class="max-w-6xl mx-auto px-6 py-4 flex items-center">
        <NuxtLink to="/" class="flex items-center gap-2 mr-auto">
          <div class="w-9 h-9 rounded-lg bg-[#f1a80a] flex items-center justify-center shadow-sm">
            <Icon name="mdi:calendar-check" class="text-white text-lg" />
          </div>
          <span class="text-xl font-extrabold text-slate-900 tracking-tight">Schelening</span>
        </NuxtLink>
        <ul class="flex gap-1 text-sm font-semibold">
          <li>
            <NuxtLink
              to="/"
              class="px-4 py-2 rounded-lg text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition-colors"
              active-class="text-slate-900 bg-slate-100"
            >
              Beranda
            </NuxtLink>
          </li>
          <li>
            <NuxtLink
              to="/rekomendasi"
              class="px-4 py-2 rounded-lg text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition-colors"
              active-class="text-slate-900 bg-slate-100"
            >
              Rekomendasi Jadwal
            </NuxtLink>
          </li>
          <li>
            <NuxtLink
              to="/contact"
              class="px-4 py-2 rounded-lg text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition-colors"
              active-class="text-slate-900 bg-slate-100"
            >
              Kontak
            </NuxtLink>
          </li>
        </ul>
      </nav>
    </header>

    <!-- Page Content -->
    <main class="flex-1">
      <slot />
    </main>

    <!-- Footer -->
    <footer class="border-t border-slate-200 bg-[#f1f1f1] mt-16">
      <div class="max-w-6xl mx-auto px-6 py-12">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-10 mb-10">
          <!-- Brand -->
          <div>
            <div class="flex items-center gap-2 mb-3">
              <div class="w-8 h-8 rounded-lg bg-[#f1a80a] flex items-center justify-center">
                <Icon name="mdi:calendar-check" class="text-white text-base" />
              </div>
              <span class="text-lg font-extrabold text-slate-900">TrainLog</span>
            </div>
            <p class="text-slate-500 text-sm leading-relaxed">
              Catat, rencanakan, dan pantau jadwal latihanmu setiap hari. Konsistensi adalah kunci.
            </p>
          </div>

          <!-- Navigasi -->
          <div>
            <p class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-4">Navigasi</p>
            <ul class="space-y-2">
              <li>
                <NuxtLink to="/" class="text-slate-600 hover:text-[#f1a80a] text-sm transition-colors">
                  Jadwal Saya
                </NuxtLink>
              </li>
              <li>
                <NuxtLink to="/rekomendasi" class="text-slate-600 hover:text-[#f1a80a] text-sm transition-colors">
                  Rekomendasi Program
                </NuxtLink>
              </li>
              <li>
                <NuxtLink to="/contact" class="text-slate-600 hover:text-[#f1a80a] text-sm transition-colors">
                  Hubungi Kami
                </NuxtLink>
              </li>
            </ul>
          </div>

          <!-- Tips -->
          <div>
            <p class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-4">Tips Latihan</p>
            <ul class="space-y-2 text-sm text-slate-500">
              <li class="flex items-start gap-2">
                <Icon name="mdi:check" class="text-[#f1a80a] mt-0.5 flex-shrink-0" />
                Latihan minimal 3x seminggu
              </li>
              <li class="flex items-start gap-2">
                <Icon name="mdi:check" class="text-[#f1a80a] mt-0.5 flex-shrink-0" />
                Pemanasan 5–10 menit sebelum mulai
              </li>
              <li class="flex items-start gap-2">
                <Icon name="mdi:check" class="text-[#f1a80a] mt-0.5 flex-shrink-0" />
                Istirahat cukup untuk pemulihan otot
              </li>
              <li class="flex items-start gap-2">
                <Icon name="mdi:check" class="text-[#f1a80a] mt-0.5 flex-shrink-0" />
                Minum air minimal 2 liter per hari
              </li>
            </ul>
          </div>
        </div>

        <div class="border-t border-slate-200 pt-6 flex flex-col sm:flex-row items-center justify-between gap-2">
          <p class="text-xs text-slate-400">© 2026 TrainLog. Dibuat untuk membantu kamu lebih konsisten.</p>
          <p class="text-xs text-slate-400">Built with <span class="text-[#f1a80a] font-semibold">Nuxt 4</span> + <span class="text-[#f1a80a] font-semibold">Tailwind CSS</span></p>
        </div>
      </div>
    </footer>
  </div>
</template>
