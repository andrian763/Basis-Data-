CREATE OR REPLACE PROCEDURE laporan_harian_semua_transaksi()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD; -- Variabel untuk menyimpan baris hasil
BEGIN
    -- Menampilkan header laporan
    RAISE NOTICE 'Laporan Harian Semua Transaksi Rekap:';

    -- Loop melalui setiap baris hasil dan tampilkan
    FOR rec IN
        SELECT
            tanggal,
            SUM(jumlah_transaksi) AS total_transaksi,
            SUM(total_harga) AS total_pendapatan
        FROM (
            -- Rekap dari tabel pesanan
            SELECT
                DATE(tanggal_pesanan) AS tanggal,
                COUNT(pesanan_id) AS jumlah_transaksi,
                SUM(total_harga) AS total_harga
            FROM public.pesanan
            GROUP BY DATE(tanggal_pesanan)

            UNION ALL

            -- Rekap dari tabel konsultasi
            SELECT
                DATE(tanggal) AS tanggal,
                COUNT(konsultasi_id) AS jumlah_transaksi,
                SUM(harga_konsul) AS total_harga
            FROM public.konsultasi
            JOIN public.dokter ON konsultasi.dokter_id = dokter.dokter_id
            GROUP BY DATE(tanggal)
        ) AS subquery
        GROUP BY tanggal
        ORDER BY tanggal
    LOOP
        -- Menampilkan hasil baris demi baris
        RAISE NOTICE 'Tanggal: %, Total Transaksi: %, Total Pendapatan: %',
            rec.tanggal, rec.total_transaksi, rec.total_pendapatan;
    END LOOP;
END;
$$;

CALL laporan_harian_semua_transaksi();

CREATE OR REPLACE VIEW laporan_harian_transaksi_view AS
SELECT
    tanggal,
    SUM(jumlah_transaksi) AS total_transaksi,
    SUM(total_harga) AS total_pendapatan
FROM (
    -- Rekap dari tabel pesanan
    SELECT
        DATE(tanggal_pesanan) AS tanggal,
        COUNT(pesanan_id) AS jumlah_transaksi,
        SUM(total_harga) AS total_harga
    FROM public.pesanan
    GROUP BY DATE(tanggal_pesanan)

    UNION ALL

    -- Rekap dari tabel konsultasi
    SELECT
        DATE(tanggal) AS tanggal,
        COUNT(konsultasi_id) AS jumlah_transaksi,
        SUM(harga_konsul) AS total_harga
    FROM public.konsultasi
    JOIN public.dokter ON konsultasi.dokter_id = dokter.dokter_id
    GROUP BY DATE(tanggal)
) AS subquery
GROUP BY tanggal
ORDER BY tanggal;

SELECT * FROM laporan_harian_transaksi_view;

