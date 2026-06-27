<script lang="ts" setup>
interface Jadwal {
  id: number;
  judul: string;
  deskripsi: string;
  tipe: "harian" | "mingguan" | "bulanan";
  hari: string;
  waktu: string;
  durasi: number;
  kategori: string;
  status: "aktif" | "selesai" | "ditunda";
  warna: string;
  created_at: string;
}

const filterTipe = ref<string>("semua");
const showModal = ref(false);
const showDeleteConfirm = ref(false);
const editMode = ref(false);
const selectedId = ref<number | null>(null);
const toast = ref({ show: false, message: "", type: "success" });

const form = ref({
  judul: "",
  deskripsi: "",
  tipe: "harian" as "harian" | "mingguan" | "bulanan",
  hari: "",
  waktu: "",
  durasi: 60,
  kategori: "latihan",
  status: "aktif" as "aktif" | "selesai" | "ditunda",
  warna: "#f1a80a",
});

const { data: jadwalList, refresh } = await useFetch<Jadwal[]>("/api/jadwal");

const hariOptions = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"];
const kategoriOptions = ["latihan", "kardio", "kekuatan", "yoga", "hiit", "pemanasan", "recovery", "rencana"];
const warnaOptions = ["#f1a80a", "#ef4444", "#10b981", "#3b82f6", "#8b5cf6", "#f97316", "#06b6d4", "#64748b"];

const filteredJadwal = computed(() => {
  if (!jadwalList.value) return [];
  if (filterTipe.value === "semua") return jadwalList.value;
  return jadwalList.value.filter((j) => j.tipe === filterTipe.value);
});

const stats = computed(() => {
  const list = jadwalList.value || [];
  return {
    total: list.length,
    aktif: list.filter((j) => j.status === "aktif").length,
    selesai: list.filter((j) => j.status === "selesai").length,
    ditunda: list.filter((j) => j.status === "ditunda").length,
  };
});

function showToast(message: string, type: "success" | "error" = "success") {
  toast.value = { show: true, message, type };
  setTimeout(() => (toast.value.show = false), 3000);
}

function openAddModal() {
  editMode.value = false;
  form.value = {
    judul: "", deskripsi: "", tipe: "harian", hari: "", waktu: "",
    durasi: 60, kategori: "latihan", status: "aktif", warna: "#f1a80a",
  };
  showModal.value = true;
}

function openEditModal(jadwal: Jadwal) {
  editMode.value = true;
  selectedId.value = jadwal.id;
  form.value = {
    judul: jadwal.judul, deskripsi: jadwal.deskripsi, tipe: jadwal.tipe,
    hari: jadwal.hari, waktu: jadwal.waktu, durasi: jadwal.durasi,
    kategori: jadwal.kategori, status: jadwal.status, warna: jadwal.warna,
  };
  showModal.value = true;
}

async function saveJadwal() {
  if (!form.value.judul.trim()) {
    showToast("Judul wajib diisi!", "error");
    return;
  }
  try {
    if (editMode.value && selectedId.value) {
      await $fetch(`/api/jadwal/${selectedId.value}`, { method: "PUT", body: form.value });
      showToast("Jadwal berhasil diperbarui!");
    } else {
      await $fetch("/api/jadwal", { method: "POST", body: form.value });
      showToast("Jadwal berhasil ditambahkan!");
    }
    showModal.value = false;
    await refresh();
  } catch {
    showToast("Terjadi kesalahan. Coba lagi!", "error");
  }
}

async function toggleStatus(jadwal: Jadwal) {
  const nextStatus: Record<string, "aktif" | "selesai" | "ditunda"> = {
    aktif: "selesai", selesai: "ditunda", ditunda: "aktif",
  };
  try {
    await $fetch(`/api/jadwal/${jadwal.id}`, {
      method: "PUT",
      body: { ...jadwal, status: nextStatus[jadwal.status] },
    });
    await refresh();
  } catch {
    showToast("Gagal update status", "error");
  }
}

function confirmDelete(id: number) {
  selectedId.value = id;
  showDeleteConfirm.value = true;
}

async function deleteJadwal() {
  if (!selectedId.value) return;
  try {
    await $fetch(`/api/jadwal/${selectedId.value}`, { method: "DELETE" });
    showToast("Jadwal berhasil dihapus!");
    showDeleteConfirm.value = false;
    await refresh();
  } catch {
    showToast("Gagal menghapus jadwal", "error");
  }
}

function statusBadge(status: string) {
  return {
    aktif: "bg-blue-50 text-blue-700 border border-blue-200",
    selesai: "bg-green-50 text-green-700 border border-green-200",
    ditunda: "bg-amber-50 text-amber-700 border border-amber-200",
  }[status] || "";
}

function statusLabel(status: string) {
  return { aktif: "Aktif", selesai: "Selesai", ditunda: "Ditunda" }[status] || status;
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

    <!-- Hero Section -->
    <section class="bg-[#f1f1f1] border-b border-slate-200">
      <div class="max-w-6xl mx-auto px-6 py-14 flex flex-col lg:flex-row items-center gap-10">
        <div class="flex-1">
          <span class="inline-block text-xs font-bold uppercase tracking-widest text-[#f1a80a] mb-3">
            Manajemen Latihan
          </span>
          <h1 class="text-4xl lg:text-5xl font-extrabold text-slate-900 tracking-tight leading-tight mb-4">
            Jadwal Latihanmu,<br/>Satu Tempat.
          </h1>
          <p class="text-slate-500 text-lg mb-6 max-w-md leading-relaxed">
            Catat rutinitas harian, mingguan, dan bulanan. Pantau progres dan tetap konsisten setiap hari.
          </p>
          <div class="flex gap-3">
            <button
              @click="openAddModal"
              class="px-5 py-2.5 bg-[#f1a80a] hover:bg-[#e09b07] text-white font-semibold rounded-lg text-sm transition-colors shadow-sm"
            >
              + Tambah Jadwal
            </button>
            <NuxtLink
              to="/rekomendasi"
              class="px-5 py-2.5 bg-white hover:bg-slate-50 text-slate-700 font-semibold rounded-lg text-sm border border-slate-200 transition-colors"
            >
              Lihat Rekomendasi
            </NuxtLink>
          </div>
        </div>

        <!-- Stats di hero -->
        <div class="flex-shrink-0 grid grid-cols-2 gap-3 w-full lg:w-auto">
          <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm text-center min-w-[120px]">
            <p class="text-3xl font-extrabold text-slate-900">{{ stats.total }}</p>
            <p class="text-xs text-slate-400 font-medium mt-1">Total Jadwal</p>
          </div>
          <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm text-center min-w-[120px]">
            <p class="text-3xl font-extrabold text-blue-600">{{ stats.aktif }}</p>
            <p class="text-xs text-slate-400 font-medium mt-1">Sedang Aktif</p>
          </div>
          <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm text-center min-w-[120px]">
            <p class="text-3xl font-extrabold text-green-600">{{ stats.selesai }}</p>
            <p class="text-xs text-slate-400 font-medium mt-1">Selesai</p>
          </div>
          <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm text-center min-w-[120px]">
            <p class="text-3xl font-extrabold text-amber-500">{{ stats.ditunda }}</p>
            <p class="text-xs text-slate-400 font-medium mt-1">Ditunda</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Filter & List Section -->
    <section class="max-w-6xl mx-auto px-6 py-10">
      <!-- Filter Bar -->
      <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
        <div>
          <h2 class="text-2xl font-extrabold text-slate-900">Daftar Jadwal</h2>
          <p class="text-slate-400 text-sm mt-0.5">
            {{ filteredJadwal.length }} jadwal {{ filterTipe !== 'semua' ? tipeLabel(filterTipe) : '' }} ditemukan
          </p>
        </div>
        <div class="flex gap-2 flex-wrap">
          <button
            v-for="tipe in ['semua', 'harian', 'mingguan', 'bulanan']"
            :key="tipe"
            @click="filterTipe = tipe"
            :class="[
              'px-4 py-2 rounded-lg text-sm font-semibold transition-colors border',
              filterTipe === tipe
                ? 'bg-slate-900 text-white border-slate-900'
                : 'bg-white text-slate-600 border-slate-200 hover:border-slate-400 hover:text-slate-900'
            ]"
          >
            {{ tipe === 'semua' ? 'Semua' : tipeLabel(tipe) }}
          </button>
        </div>
      </div>

      <!-- Empty State -->
      <div v-if="filteredJadwal.length === 0" class="border-2 border-dashed border-slate-200 rounded-2xl py-20 text-center">
        <div class="w-16 h-16 rounded-2xl bg-slate-100 flex items-center justify-center mx-auto mb-4">
          <Icon name="mdi:calendar-blank-outline" class="text-slate-400 text-3xl" />
        </div>
        <p class="text-slate-700 font-semibold mb-1">Belum ada jadwal</p>
        <p class="text-slate-400 text-sm mb-5">Buat jadwal pertamamu atau impor dari rekomendasi.</p>
        <div class="flex gap-3 justify-center">
          <button
            @click="openAddModal"
            class="px-5 py-2 bg-[#f1a80a] hover:bg-[#e09b07] text-white text-sm font-semibold rounded-lg transition-colors"
          >
            + Tambah Jadwal
          </button>
          <NuxtLink
            to="/rekomendasi"
            class="px-5 py-2 bg-white text-slate-700 text-sm font-semibold rounded-lg border border-slate-200 hover:bg-slate-50 transition-colors"
          >
            Lihat Rekomendasi
          </NuxtLink>
        </div>
      </div>

      <!-- Jadwal Grid -->
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
        <div
          v-for="jadwal in filteredJadwal"
          :key="jadwal.id"
          class="group bg-white border border-slate-200 hover:border-slate-300 rounded-2xl overflow-hidden shadow-sm hover:shadow-md transition-all"
        >
          <!-- Color bar atas -->
          <div class="h-1.5 w-full" :style="{ backgroundColor: jadwal.warna }" />

          <div class="p-5">
            <!-- Header Card -->
            <div class="flex items-start justify-between mb-3">
              <div class="flex items-center gap-2.5 flex-1 min-w-0">
                <div
                  class="w-9 h-9 rounded-xl flex items-center justify-center flex-shrink-0"
                  :style="{ backgroundColor: jadwal.warna + '20' }"
                >
                  <Icon :name="kategoriIcon(jadwal.kategori)" class="text-lg" :style="{ color: jadwal.warna }" />
                </div>
                <div class="min-w-0">
                  <h3 class="text-slate-900 font-bold text-sm leading-tight truncate">{{ jadwal.judul }}</h3>
                  <p class="text-slate-400 text-xs mt-0.5 capitalize">{{ jadwal.kategori }}</p>
                </div>
              </div>
              <!-- Action buttons -->
              <div class="flex items-center gap-1 ml-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button
                  @click="openEditModal(jadwal)"
                  class="p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 hover:text-slate-700 transition-colors"
                  title="Edit"
                >
                  <Icon name="mdi:pencil-outline" class="text-sm" />
                </button>
                <button
                  @click="confirmDelete(jadwal.id)"
                  class="p-1.5 rounded-lg hover:bg-red-50 text-slate-400 hover:text-red-500 transition-colors"
                  title="Hapus"
                >
                  <Icon name="mdi:trash-can-outline" class="text-sm" />
                </button>
              </div>
            </div>

            <!-- Deskripsi -->
            <p v-if="jadwal.deskripsi" class="text-slate-500 text-xs leading-relaxed mb-4 line-clamp-2">
              {{ jadwal.deskripsi }}
            </p>

            <!-- Meta -->
            <div class="flex flex-wrap gap-2 mb-4">
              <span class="text-xs px-2.5 py-1 rounded-lg bg-slate-100 text-slate-600 font-medium">
                {{ tipeLabel(jadwal.tipe) }}
              </span>
              <span v-if="jadwal.hari" class="text-xs px-2.5 py-1 rounded-lg bg-slate-100 text-slate-600">
                {{ jadwal.hari }}
              </span>
              <span v-if="jadwal.waktu" class="text-xs px-2.5 py-1 rounded-lg bg-slate-100 text-slate-600 flex items-center gap-1">
                <Icon name="mdi:clock-outline" class="text-xs" />{{ jadwal.waktu }}
              </span>
              <span class="text-xs px-2.5 py-1 rounded-lg bg-slate-100 text-slate-600 flex items-center gap-1">
                <Icon name="mdi:timer-outline" class="text-xs" />{{ jadwal.durasi }} mnt
              </span>
            </div>

            <!-- Status Toggle -->
            <button
              @click="toggleStatus(jadwal)"
              :class="['text-xs px-3 py-1.5 rounded-lg font-semibold transition-colors', statusBadge(jadwal.status)]"
              title="Klik untuk ganti status"
            >
              {{ statusLabel(jadwal.status) }}
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Modal Form -->
    <Teleport to="body">
      <Transition name="fade">
        <div
          v-if="showModal"
          class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm"
          @click.self="showModal = false"
        >
          <div class="bg-white border border-slate-200 rounded-2xl w-full max-w-lg shadow-2xl">
            <div class="flex items-center justify-between px-6 py-5 border-b border-slate-100">
              <h2 class="text-slate-900 font-bold text-lg">
                {{ editMode ? 'Edit Jadwal' : 'Tambah Jadwal Baru' }}
              </h2>
              <button @click="showModal = false" class="text-slate-400 hover:text-slate-700 transition-colors">
                <Icon name="mdi:close" class="text-xl" />
              </button>
            </div>

            <div class="px-6 py-5 space-y-4 max-h-[70vh] overflow-y-auto">
              <!-- Judul -->
              <div>
                <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Judul *</label>
                <input
                  v-model="form.judul"
                  type="text"
                  placeholder="Contoh: Morning Run 5K"
                  class="w-full border border-slate-200 rounded-xl px-4 py-2.5 text-slate-900 text-sm placeholder-slate-400 focus:outline-none focus:border-[#f1a80a] focus:ring-2 focus:ring-[#f1a80a]/20 transition-all"
                />
              </div>

              <!-- Deskripsi -->
              <div>
                <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Deskripsi</label>
                <textarea
                  v-model="form.deskripsi"
                  rows="2"
                  placeholder="Ceritakan detail latihanmu..."
                  class="w-full border border-slate-200 rounded-xl px-4 py-2.5 text-slate-900 text-sm placeholder-slate-400 focus:outline-none focus:border-[#f1a80a] focus:ring-2 focus:ring-[#f1a80a]/20 transition-all resize-none"
                />
              </div>

              <!-- Tipe -->
              <div>
                <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Tipe Jadwal</label>
                <div class="grid grid-cols-3 gap-2">
                  <button
                    v-for="t in ['harian', 'mingguan', 'bulanan']"
                    :key="t"
                    @click="form.tipe = t as any"
                    :class="[
                      'py-2.5 rounded-xl text-sm font-semibold border transition-all',
                      form.tipe === t
                        ? 'bg-slate-900 text-white border-slate-900'
                        : 'bg-white text-slate-600 border-slate-200 hover:border-slate-400'
                    ]"
                  >
                    {{ tipeLabel(t) }}
                  </button>
                </div>
              </div>

              <!-- Hari -->
              <div v-if="form.tipe === 'mingguan'">
                <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Hari</label>
                <select
                  v-model="form.hari"
                  class="w-full border border-slate-200 rounded-xl px-4 py-2.5 text-slate-900 text-sm focus:outline-none focus:border-[#f1a80a] focus:ring-2 focus:ring-[#f1a80a]/20 transition-all bg-white"
                >
                  <option value="">Pilih hari...</option>
                  <option v-for="h in hariOptions" :key="h" :value="h">{{ h }}</option>
                </select>
              </div>

              <!-- Waktu & Durasi -->
              <div class="grid grid-cols-2 gap-3">
                <div>
                  <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Waktu</label>
                  <input
                    v-model="form.waktu"
                    type="time"
                    class="w-full border border-slate-200 rounded-xl px-4 py-2.5 text-slate-900 text-sm focus:outline-none focus:border-[#f1a80a] focus:ring-2 focus:ring-[#f1a80a]/20 transition-all"
                  />
                </div>
                <div>
                  <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Durasi (mnt)</label>
                  <input
                    v-model.number="form.durasi"
                    type="number" min="5" max="300"
                    class="w-full border border-slate-200 rounded-xl px-4 py-2.5 text-slate-900 text-sm focus:outline-none focus:border-[#f1a80a] focus:ring-2 focus:ring-[#f1a80a]/20 transition-all"
                  />
                </div>
              </div>

              <!-- Kategori -->
              <div>
                <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Kategori</label>
                <select
                  v-model="form.kategori"
                  class="w-full border border-slate-200 rounded-xl px-4 py-2.5 text-slate-900 text-sm focus:outline-none focus:border-[#f1a80a] focus:ring-2 focus:ring-[#f1a80a]/20 transition-all bg-white capitalize"
                >
                  <option v-for="k in kategoriOptions" :key="k" :value="k" class="capitalize">{{ k }}</option>
                </select>
              </div>

              <!-- Warna -->
              <div>
                <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Warna Label</label>
                <div class="flex gap-2.5">
                  <button
                    v-for="w in warnaOptions"
                    :key="w"
                    @click="form.warna = w"
                    class="w-7 h-7 rounded-full transition-all hover:scale-110"
                    :style="{ backgroundColor: w }"
                    :class="form.warna === w ? 'ring-2 ring-offset-2 ring-slate-400 scale-110' : ''"
                  />
                </div>
              </div>

              <!-- Status (edit only) -->
              <div v-if="editMode">
                <label class="text-xs font-bold text-slate-700 uppercase tracking-wide mb-1.5 block">Status</label>
                <div class="grid grid-cols-3 gap-2">
                  <button
                    v-for="s in ['aktif', 'selesai', 'ditunda']"
                    :key="s"
                    @click="form.status = s as any"
                    :class="[
                      'py-2 rounded-xl text-xs font-semibold border transition-all',
                      form.status === s ? statusBadge(s) : 'bg-white text-slate-500 border-slate-200 hover:border-slate-400'
                    ]"
                  >
                    {{ statusLabel(s) }}
                  </button>
                </div>
              </div>
            </div>

            <div class="flex gap-3 px-6 py-4 border-t border-slate-100">
              <button
                @click="showModal = false"
                class="flex-1 py-2.5 rounded-xl text-sm font-semibold bg-slate-100 text-slate-600 hover:bg-slate-200 transition-colors"
              >
                Batal
              </button>
              <button
                @click="saveJadwal"
                class="flex-1 py-2.5 rounded-xl text-sm font-semibold bg-[#f1a80a] hover:bg-[#e09b07] text-white transition-colors shadow-sm"
              >
                {{ editMode ? 'Simpan Perubahan' : 'Tambah Jadwal' }}
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Delete Confirm -->
    <Teleport to="body">
      <Transition name="fade">
        <div
          v-if="showDeleteConfirm"
          class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm"
          @click.self="showDeleteConfirm = false"
        >
          <div class="bg-white border border-slate-200 rounded-2xl w-full max-w-sm shadow-2xl p-6 text-center">
            <div class="w-14 h-14 rounded-2xl bg-red-50 flex items-center justify-center mx-auto mb-4">
              <Icon name="mdi:trash-can-outline" class="text-red-500 text-2xl" />
            </div>
            <h3 class="text-slate-900 font-bold text-lg mb-2">Hapus Jadwal?</h3>
            <p class="text-slate-500 text-sm mb-6 leading-relaxed">
              Jadwal yang dihapus tidak bisa dikembalikan. Yakin ingin melanjutkan?
            </p>
            <div class="flex gap-3">
              <button
                @click="showDeleteConfirm = false"
                class="flex-1 py-2.5 rounded-xl text-sm font-semibold bg-slate-100 text-slate-600 hover:bg-slate-200 transition-colors"
              >
                Batal
              </button>
              <button
                @click="deleteJadwal"
                class="flex-1 py-2.5 rounded-xl text-sm font-semibold bg-red-600 hover:bg-red-500 text-white transition-colors"
              >
                Ya, Hapus
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s, transform 0.2s; }
.fade-enter-from, .fade-leave-to { opacity: 0; transform: scale(0.98); }
.slide-up-enter-active, .slide-up-leave-active { transition: all 0.3s; }
.slide-up-enter-from, .slide-up-leave-to { opacity: 0; transform: translateY(1rem); }
</style>
