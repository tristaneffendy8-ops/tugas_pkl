<template>
  <div>
    <!-- Hero Banner -->
    <section class="relative bg-slate-900 overflow-hidden">
      <!-- Background decorative circles -->
      <div class="absolute top-0 right-0 w-96 h-96 bg-[#f1a80a]/10 rounded-full -translate-y-1/2 translate-x-1/3 blur-3xl pointer-events-none" />
      <div class="absolute bottom-0 left-0 w-64 h-64 bg-[#f1a80a]/5 rounded-full translate-y-1/2 -translate-x-1/4 blur-2xl pointer-events-none" />

      <div class="relative max-w-6xl mx-auto px-6 py-20">
        <div class="flex items-center gap-2 mb-4">
          <div class="w-1 h-6 bg-[#f1a80a] rounded-full" />
          <span class="text-xs font-bold uppercase tracking-widest text-[#f1a80a]">Kontak</span>
        </div>
        <h1 class="text-4xl lg:text-6xl font-extrabold text-white tracking-tight leading-tight mb-4">
          Ayo Ngobrol<br />
          <span class="text-[#f1a80a]">Bareng Kami</span>
        </h1>
        <p class="text-slate-400 text-lg max-w-lg leading-relaxed">
          Punya pertanyaan, saran, atau sekadar ingin say hello? Kami senang mendengar dari kamu.
        </p>
      </div>
    </section>

    <!-- Stats Bar -->
    <section class="bg-[#f1a80a]">
      <div class="max-w-6xl mx-auto px-6 py-5">
        <div class="flex flex-wrap gap-8 justify-around text-center">
          <div>
            <p class="text-white font-extrabold text-2xl">< 24 Jam</p>
            <p class="text-amber-900 text-xs font-semibold mt-0.5">Waktu Respons</p>
          </div>
          <div>
            <p class="text-white font-extrabold text-2xl">100%</p>
            <p class="text-amber-900 text-xs font-semibold mt-0.5">Gratis</p>
          </div>
          <div>
            <p class="text-white font-extrabold text-2xl">Senin–Jumat</p>
            <p class="text-amber-900 text-xs font-semibold mt-0.5">09.00–17.00 WIB</p>
          </div>
          <div>
            <p class="text-white font-extrabold text-2xl">Jakarta</p>
            <p class="text-amber-900 text-xs font-semibold mt-0.5">Indonesia</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Main Content -->
    <section class="max-w-6xl mx-auto px-6 py-16">
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">

        <!-- Left: Kontak Cards -->
        <div class="space-y-8">
          <div>
            <h2 class="text-2xl font-extrabold text-slate-900 mb-2">Cara Menghubungi Kami</h2>
            <p class="text-slate-500 text-sm leading-relaxed">Pilih cara yang paling nyaman buat kamu.</p>
          </div>

          <!-- Contact Cards -->
          <div class="space-y-4">
            <div class="group flex items-center gap-5 p-5 bg-white border border-slate-200 rounded-2xl hover:border-[#f1a80a] hover:shadow-lg hover:shadow-amber-100 transition-all cursor-pointer">
              <div class="w-14 h-14 rounded-2xl bg-amber-50 border-2 border-amber-200 group-hover:bg-[#f1a80a] group-hover:border-[#f1a80a] flex items-center justify-center flex-shrink-0 transition-all">
                <Icon name="mdi:email-fast-outline" class="text-[#f1a80a] group-hover:text-white text-2xl transition-colors" />
              </div>
              <div>
                <p class="text-slate-900 font-bold text-sm">Email Kami</p>
                <p class="text-[#f1a80a] font-semibold text-sm mt-0.5">hello@trainlog.id</p>
                <p class="text-slate-400 text-xs mt-1">Balas dalam 1×24 jam kerja</p>
              </div>
              <Icon name="mdi:arrow-right" class="text-slate-300 group-hover:text-[#f1a80a] ml-auto transition-colors" />
            </div>

            <div class="group flex items-center gap-5 p-5 bg-white border border-slate-200 rounded-2xl hover:border-[#f1a80a] hover:shadow-lg hover:shadow-amber-100 transition-all cursor-pointer">
              <div class="w-14 h-14 rounded-2xl bg-amber-50 border-2 border-amber-200 group-hover:bg-[#f1a80a] group-hover:border-[#f1a80a] flex items-center justify-center flex-shrink-0 transition-all">
                <Icon name="mdi:instagram" class="text-[#f1a80a] group-hover:text-white text-2xl transition-colors" />
              </div>
              <div>
                <p class="text-slate-900 font-bold text-sm">Instagram</p>
                <p class="text-[#f1a80a] font-semibold text-sm mt-0.5">@trainlog.id</p>
                <p class="text-slate-400 text-xs mt-1">DM kami kapan saja</p>
              </div>
              <Icon name="mdi:arrow-right" class="text-slate-300 group-hover:text-[#f1a80a] ml-auto transition-colors" />
            </div>

            <div class="group flex items-center gap-5 p-5 bg-white border border-slate-200 rounded-2xl hover:border-[#f1a80a] hover:shadow-lg hover:shadow-amber-100 transition-all cursor-pointer">
              <div class="w-14 h-14 rounded-2xl bg-amber-50 border-2 border-amber-200 group-hover:bg-[#f1a80a] group-hover:border-[#f1a80a] flex items-center justify-center flex-shrink-0 transition-all">
                <Icon name="mdi:map-marker-outline" class="text-[#f1a80a] group-hover:text-white text-2xl transition-colors" />
              </div>
              <div>
                <p class="text-slate-900 font-bold text-sm">Lokasi</p>
                <p class="text-[#f1a80a] font-semibold text-sm mt-0.5">Jakarta, Indonesia</p>
                <p class="text-slate-400 text-xs mt-1">Jam kerja: Senin–Jumat</p>
              </div>
              <Icon name="mdi:arrow-right" class="text-slate-300 group-hover:text-[#f1a80a] ml-auto transition-colors" />
            </div>
          </div>

          <!-- Social Media -->
          <div class="bg-slate-900 rounded-2xl p-6">
            <p class="text-white font-bold mb-1">Ikuti Kami</p>
            <p class="text-slate-400 text-xs mb-5">Update terbaru seputar fitur dan tips latihan</p>
            <div class="flex gap-3">
              <a href="#" class="flex-1 flex items-center justify-center gap-2 py-2.5 bg-white/10 hover:bg-[#f1a80a] rounded-xl text-white text-xs font-semibold transition-colors group">
                <Icon name="mdi:instagram" class="text-lg" />
                Instagram
              </a>
              <a href="#" class="flex-1 flex items-center justify-center gap-2 py-2.5 bg-white/10 hover:bg-[#f1a80a] rounded-xl text-white text-xs font-semibold transition-colors group">
                <Icon name="mdi:twitter" class="text-lg" />
                Twitter
              </a>
              <a href="#" class="flex-1 flex items-center justify-center gap-2 py-2.5 bg-white/10 hover:bg-[#f1a80a] rounded-xl text-white text-xs font-semibold transition-colors group">
                <Icon name="mdi:youtube" class="text-lg" />
                YouTube
              </a>
            </div>
          </div>
        </div>

        <!-- Right: FAQ -->
        <div class="space-y-8">
          <div>
            <h2 class="text-2xl font-extrabold text-slate-900 mb-2">Pertanyaan Umum</h2>
            <p class="text-slate-500 text-sm leading-relaxed">Mungkin jawabannya sudah ada di sini.</p>
          </div>

          <div class="space-y-3">
            <div class="border border-slate-200 rounded-2xl overflow-hidden">
              <div class="flex items-center gap-4 p-5 bg-white">
                <div class="w-8 h-8 rounded-lg bg-amber-50 border border-amber-200 flex items-center justify-center flex-shrink-0">
                  <Icon name="mdi:help" class="text-[#f1a80a] text-sm" />
                </div>
                <div>
                  <p class="text-slate-900 font-bold text-sm">Apakah TrainLog gratis?</p>
                  <p class="text-slate-500 text-xs mt-1 leading-relaxed">Ya, sepenuhnya gratis tanpa biaya tersembunyi apapun. Gunakan semua fitur tanpa batas.</p>
                </div>
              </div>
            </div>

            <div class="border border-slate-200 rounded-2xl overflow-hidden">
              <div class="flex items-center gap-4 p-5 bg-white">
                <div class="w-8 h-8 rounded-lg bg-amber-50 border border-amber-200 flex items-center justify-center flex-shrink-0">
                  <Icon name="mdi:database-outline" class="text-[#f1a80a] text-sm" />
                </div>
                <div>
                  <p class="text-slate-900 font-bold text-sm">Data tersimpan di mana?</p>
                  <p class="text-slate-500 text-xs mt-1 leading-relaxed">Data disimpan di database lokal perangkatmu. Privasi kamu terjaga sepenuhnya.</p>
                </div>
              </div>
            </div>

            <div class="border border-slate-200 rounded-2xl overflow-hidden">
              <div class="flex items-center gap-4 p-5 bg-white">
                <div class="w-8 h-8 rounded-lg bg-amber-50 border border-amber-200 flex items-center justify-center flex-shrink-0">
                  <Icon name="mdi:devices" class="text-[#f1a80a] text-sm" />
                </div>
                <div>
                  <p class="text-slate-900 font-bold text-sm">Bisa dipakai di HP?</p>
                  <p class="text-slate-500 text-xs mt-1 leading-relaxed">Tentu! TrainLog responsif dan bisa diakses dari perangkat apapun — HP, tablet, atau laptop.</p>
                </div>
              </div>
            </div>

            <div class="border border-slate-200 rounded-2xl overflow-hidden">
              <div class="flex items-center gap-4 p-5 bg-white">
                <div class="w-8 h-8 rounded-lg bg-amber-50 border border-amber-200 flex items-center justify-center flex-shrink-0">
                  <Icon name="mdi:update" class="text-[#f1a80a] text-sm" />
                </div>
                <div>
                  <p class="text-slate-900 font-bold text-sm">Apakah ada update rutin?</p>
                  <p class="text-slate-500 text-xs mt-1 leading-relaxed">Ya, kami terus mengembangkan fitur baru berdasarkan masukan pengguna secara berkala.</p>
                </div>
              </div>
            </div>
          </div>

          <!-- CTA Box -->
          <div class="relative bg-gradient-to-br from-[#f1a80a] to-amber-600 rounded-2xl p-6 overflow-hidden">
            <div class="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -translate-y-8 translate-x-8 pointer-events-none" />
            <div class="absolute bottom-0 left-0 w-20 h-20 bg-white/10 rounded-full translate-y-6 -translate-x-4 pointer-events-none" />
            <div class="relative">
              <Icon name="mdi:message-text-outline" class="text-white text-3xl mb-3" />
              <p class="text-white font-extrabold text-lg leading-tight mb-1">Masih ada pertanyaan?</p>
              <p class="text-amber-100 text-xs mb-5 leading-relaxed">Jangan ragu untuk langsung menghubungi kami via email. Tim kami siap membantu!</p>
              <a
                href="mailto:hello@trainlog.id"
                class="inline-flex items-center gap-2 px-5 py-2.5 bg-white text-[#f1a80a] text-sm font-extrabold rounded-xl hover:bg-amber-50 transition-colors shadow-sm"
              >
                <Icon name="mdi:email-outline" />
                Kirim Email
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>