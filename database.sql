-- Jalankan file ini sekali di MySQL sebelum menjalankan aplikasi
-- mysql -u root -p < database.sql

CREATE DATABASE IF NOT EXISTS jadwal_latihan
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE jadwal_latihan;

CREATE TABLE IF NOT EXISTS jadwal (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  judul       VARCHAR(255)                                         NOT NULL,
  deskripsi   TEXT                                                 DEFAULT '',
  tipe        ENUM('harian','mingguan','bulanan')                  NOT NULL DEFAULT 'harian',
  hari        VARCHAR(50)                                          DEFAULT '',
  waktu       VARCHAR(10)                                          DEFAULT '',
  durasi      INT                                                  DEFAULT 60,
  kategori    VARCHAR(100)                                         DEFAULT 'latihan',
  status      ENUM('aktif','selesai','ditunda')                    DEFAULT 'aktif',
  warna       VARCHAR(20)                                          DEFAULT '#6366f1',
  created_at  TIMESTAMP                                            DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP                                            DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
