-- Membuat tabel admin_
CREATE TABLE admin_ (
    admin_id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Menambahkan kolom admin_id dan last_edited ke tabel obat
ALTER TABLE obat
ADD COLUMN admin_id INT,
ADD COLUMN last_edited TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT fk_obat_admin
FOREIGN KEY (admin_id) REFERENCES admin_(admin_id)
ON DELETE SET NULL;

-- Membuat trigger untuk memperbarui last_edited pada tabel obat
CREATE OR REPLACE FUNCTION update_last_edited_obat()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_edited = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_last_edited_obat
BEFORE UPDATE ON obat
FOR EACH ROW
EXECUTE FUNCTION update_last_edited_obat();

-- Menambahkan kolom admin_id dan last_edited ke tabel dokter
ALTER TABLE dokter
ADD COLUMN admin_id INT,
ADD COLUMN last_edited TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT fk_dokter_admin
FOREIGN KEY (admin_id) REFERENCES admin_(admin_id)
ON DELETE SET NULL;

-- Membuat trigger untuk memperbarui last_edited pada tabel dokter
CREATE OR REPLACE FUNCTION update_last_edited_dokter()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_edited = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_last_edited_dokter
BEFORE UPDATE ON dokter
FOR EACH ROW
EXECUTE FUNCTION update_last_edited_dokter();
