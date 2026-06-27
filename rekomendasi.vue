<script lang="ts" setup>
interface RekoItem {
  judul: string;
  deskripsi: string;
  waktu?: string;
  hari?: string;
  durasi: number;
  kategori: string;
  warna: string;
}

interface Rekomendasi {
  harian: RekoItem[];
  mingguan: RekoItem[];
  bulanan: RekoItem[];
}

const { data: rekomendasi } = await useFetch<Rekomendasi>("/api/rekomendasi");
const selectedTipe = ref<"harian" | "mingguan" | "bulanan">("mingguan");
const toast = ref({ show: false, message: "", type: "success" });
const loading = ref<number | null>(null);

function showToast(message: string, type: "success" | "error" = "success") {
  toast.value = { show: true, message, type };
  setTimeout(() => (toast.value.show = false), 3000);
}

async function tambahkanJadwal(item: RekoItem, index: number) {
  loading.value = index;
  try {
    await $fetch("/api/jadwal", {
      method: "POST",
      body: { ...item, tipe: selectedTipe.value },
    });
    showToast(`"${item.judul}" ditambahkan!`);
  } catch {
    showToast("Gagal menambahkan jadwal", "error");
  } finally {
    loading.value = null;
  }
}

async function tambahkanSemua() {
  const list = rekomendasi.value?.[selectedTipe.value] || [];
  for (const item of list) {
    await $fetch("/api/jadwal", { method: "POST", body: { ...item, tipe: selectedTipe.value } });
  }
  showToast(`Semua program ${selectedTipe.value} berhasil diimpor!`);
}

function tipeLabel(tipe: string) {
  return { harian: "Harian", mingguan: "Mingguan", bulanan: "Bulanan" }[tipe] || tipe;
}

function kategoriIcon(kat: string) {
  const icons: Record<string, string> = {
    kardio: "mdi:run", kekuatan: "mdi:dumbbell", yoga: "mdi:yoga",
    hiit: "mdi:lightning-bolt", pemanasan: "mdi:fire", recovery: "mdi:sleep",
    latihan: "mdi:weight-lifter", rencana: "mdi:clipboard-list",
  };
  return icons[kat] || "mdi:calendar";
}
</script>

<template>
  <div>
    <!-- Toast -->
    <Transition name="slide-up">
      <div
        v-if="toast.show"
        :class="[
          'fixed bottom-6 right-6 z-[100] px-5 py-3 rounded-xl text-sm font-semibold shadow-xl flex items-center gap-2',
          toast.type === 'success' ? 'bg-slate-900 text-white' : 'bg-red-600 text-white'
        ]"
      >
        <Icon :name="toast.type === 'success' ? 'mdi:check-circle' : 'mdi:alert-circle'" class="text-lg" />
        {{ toast.message }}
      </div>
    </Transition>

    <!-- Hero -->
    <section class="bg-[#f1f1f1] border-b border-slate-200">
      <div class="max-w-6xl mx-auto px-6 py-14">
        <NuxtLink to="/" class="inline-flex items-center gap-1.5 text-sm text-slate-500 hover:text-slate-800 mb-5 transition-colors font-medium">
          <Icon name="mdi:arrow-left" class="text-sm" />
          Kembali ke Jadwal
        </NuxtLink>
        <span class="inline-block text-xs font-bold uppercase tracking-widest text-[#f1a80a] mb-3">
          Program Siap Pakai
        </span>
        <h1 class="text-4xl lg:text-5xl font-extrabold text-slate-900 tracking-tight leading-tight mb-3">
          Rekomendasi Jadwal
        </h1>
        <p class="text-slate-500 text-lg max-w-xl leading-relaxed">
          Template program latihan yang sudah dirancang. Pilih yang cocok, tambahkan ke jadwalmu, dan mulai hari ini.
        </p>
      </div>
    </section>

    <section class="max-w-6xl mx-auto px-6 py-10">
      <!-- Tipe Selector -->
      <div class="flex gap-3 mb-2 flex-wrap">
        <button
          v-for="tipe in ['harian', 'mingguan', 'bulanan'] as const"
          :key="tipe"
          @click="selectedTipe = tipe"
          :class="[
            'flex items-center gap-2 px-5 py-2.5 rounded-xl text-sm font-bold transition-all border',
            selectedTipe === tipe
              ? 'bg-slate-900 text-white border-slate-900'
              : 'bg-white text-slate-600 border-slate-200 hover:border-slate-400 hover:text-slate-900'
          ]"
        >
          <Icon
            :name="tipe === 'harian' ? 'mdi:weather-sunny' : tipe === 'mingguan' ? 'mdi:calendar-week' : 'mdi:calendar-month'"
          />
          {{ tipeLabel(tipe) }}
        </button>
      </div>

      <!-- Info strip -->
      <div class="bg-amber-50 border border-amber-200 rounded-xl px-5 py-3.5 mb-8 flex items-center gap-3">
        <Icon name="mdi:information-outline" class="text-[#f1a80a] text-xl flex-shrink-0" />
        <p class="text-sm text-amber-800 font-medium">
          <span v-if="selectedTipe === 'harian'">Cocok dilakukan setiap hari — ringan tapi konsisten.</span>
          <span v-else-if="selectedTipe === 'mingguan'">Program 7 hari dengan variasi latihan yang seimbang antara kekuatan dan kardio.</span>
          <span v-else>Progresif selama 4 minggu — dari fondasi sampai puncak intensitas, lalu deload.</span>
        </p>
      </div>

      <!-- Cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-5 mb-8">
        <div
          v-for="(item, i) in rekomendasi?.[selectedTipe] || []"
          :key="i"
          class="group bg-white border border-slate-200 hover:border-slate-300 hover:shadow-md rounded-2xl overflow-hidden transition-all"
        >
          <div class="h-1.5" :style="{ backgroundColor: item.warna }" />
          <div class="p-5">
            <div class="flex items-start gap-3 mb-3">
              <div
                class="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0"
                :style="{ backgroundColor: item.warna + '20' }"
              >
                <Icon :name="kategoriIcon(item.kategori)" class="text-xl" :style="{ color: item.warna }" />
              </div>
              <div class="flex-1 min-w-0">
                <h3 class="text-slate-900 font-bold text-sm leading-snug">{{ item.judul }}</h3>
                <span class="text-xs text-slate-400 capitalize">{{ item.kategori }}</span>
              </div>
            </div>

            <p class="text-slate-500 text-xs leading-relaxed mb-4">{{ item.deskripsi }}</p>

            <div class="flex items-center justify-between">
              <div class="flex gap-3 text-xs text-slate-400">
                <span v-if="item.hari" class="flex items-center gap-1">
                  <Icon name="mdi:calendar-outline" class="text-xs" />{{ item.hari }}
                </span>
                <span v-if="item.waktu" class="flex items-center gap-1">
                  <Icon name="mdi:clock-outline" class="text-xs" />{{ item.waktu }}
                </span>
                <span class="flex items-center gap-1">
                  <Icon name="mdi:timer-outline" class="text-xs" />{{ item.durasi }} mnt
                </span>
              </div>

              <button
                @click="tambahkanJadwal(item, i)"
                :disabled="loading === i"
                class="flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold bg-[#f1a80a] hover:bg-[#e09b07] text-white transition-colors disabled:opacity-60"
              >
                <Icon :name="loading === i ? 'mdi:loading' : 'mdi:plus'" :class="loading === i ? 'animate-spin' : ''" />
                {{ loading === i ? 'Menambah...' : 'Tambahkan' }}
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Impor Semua -->
      <div class="bg-[#f1f1f1] border border-slate-200 rounded-2xl p-6 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
        <div>
          <h3 class="text-slate-900 font-bold mb-1">Impor Program Lengkap</h3>
          <p class="text-slate-500 text-sm">
            Tambahkan seluruh program {{ tipeLabel(selectedTipe) }} ({{ rekomendasi?.[selectedTipe]?.length || 0 }} jadwal) sekaligus ke daftar jadwalmu.
          </p>
        </div>
        <button
          @click="tambahkanSemua"
          class="flex-shrink-0 flex items-center gap-2 px-6 py-3 bg-slate-900 hover:bg-slate-800 text-white text-sm font-bold rounded-xl transition-colors shadow-sm"
        >
          <Icon name="mdi:download-outline" />
          Impor Semua
        </button>
      </div>
    </section>
  </div>
</template>

<style scoped>
.slide-up-enter-active, .slide-up-leave-active { transition: all 0.3s; }
.slide-up-enter-from, .slide-up-leave-to { opacity: 0; transform: translateY(1rem); }
</style>
