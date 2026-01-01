# BCMS (Maroon-NET)

## Prasyarat
- Ubuntu 24.04
- Docker & docker-compose
- Git
- Domain & DNS (untuk HTTPS)
- Port: 80/443 (nginx), 3000 (dev), 5432 (db), 6379 (redis)

## Langkah instalasi server (bare metal)
1) Update OS
```bash
sudo apt update && sudo apt upgrade -y
```
2) Install Docker & docker-compose
```bash
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
```
3) Clone repo
```bash
git clone https://github.com/a3ramz-code/bcms_v1.git
cd bcms_v1
```
4) Salin env
```bash
cp backend/.env.example backend/.env
cp frontend/.env.local.example frontend/.env.local
```
5) Set credential (ubah sesuai produksi)
- DB password: `4Sehat&5Sempurna`
- APP_KEY: `php artisan key:generate` (dalam container atau lokal)

6) Jalankan stack
```bash
docker-compose up -d --build
```

7) Migrasi & seed
```bash
docker-compose exec app php artisan migrate --path=database/migrations/2024_01_01_000000_bcms_schema.sql
docker-compose exec app php artisan db:seed --class=Database\\Seeders\\DatabaseSeeder
# atau jalankan seed SQL:
cat backend/database/seeders/seed.sql | docker-compose exec -T db psql -U bcms -d bcms
```

8) Akses
- Frontend: http://localhost:3000
- API base: http://localhost/api
- Login admin: `admin@maroon-net.id` / (password hash pada seed -> set manual ke `4Sehat&5Sempurna` jika diperlukan)
  ```bash
  docker-compose exec app php artisan tinker
  >>> \App\Models\User::where('email','admin@maroon-net.id')->update(['password'=>bcrypt('4Sehat&5Sempurna')]);
  ```

## Konfigurasi Nginx + HTTPS (Let’s Encrypt)
- Pasang certbot (opsional) atau gunakan reverse proxy lain.
- Update `docker/nginx.conf` server_name dan path sertifikat.

## Monitoring & Queue
- Horizon: tambahkan route /horizon (pastikan auth)
- Queue workers: container `queue` dan `horizon` sudah disiapkan.

## Backup
- DB: `pg_dump bcms > backup.sql`
- Automasi: jadwalkan cron/gha/artisan command.

## Notes keamanan
- Ganti semua secret di .env
- MikroTik API user dengan least-privilege
- Pastikan TLS untuk API RouterOS (port 8729)