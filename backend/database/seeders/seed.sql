INSERT INTO company (name, logo, brand, brand_logo, address, phone, email, npwp, bank, bank_account)
VALUES ('PT. Trira Inti Utama', '/storage/logo.png', 'Maroon-NET', '/storage/brand.png',
'Ruko Kemanggisan Blok O4 No. 6 Metland Cibitung, Kab. Bekasi, Jawa Barat - 17530',
'021-12345678','info@triraintiutama.id','50.520.877.7-413.000','Mandiri','156-00-2388849-0');

INSERT INTO users_group (name_group, permission)
VALUES 
('administrator', '{"*":true}'),
('supervisor', '{"billing":true,"support":true,"ticket":true}'),
('teller', '{"payments":true,"billing":true}'),
('support', '{"ticket":true,"customers":true}');

INSERT INTO users (name, full_name, group_id, email, phone, password, status)
VALUES
('admin','Super Admin',1,'admin@maroon-net.id','0811111111','$2y$12$Kb9q9YVw9mhuJq0nF6Kn0OzxQkZI2s8QzJrYV1hkedT1fD3Hkq1b2','active'),
('supervisor','Lead Ops',2,'supervisor@maroon-net.id','0812222222','$2y$12$Kb9q9YVw9mhuJq0nF6Kn0OzxQkZI2s8QzJrYV1hkedT1fD3Hkq1b2','active');

INSERT INTO services (name, service_type, bandwidth_types, pppoe_profile, rate_limit_up, rate_limit_down, address_list, max_limit_up, max_limit_down, price, tax_rate, period_start, period_end, due_date, suspension_grace_days)
VALUES
('Home 20 Mbps','residensial','broadband','pppoe-home','20M','20M','home-active','20M','20M',250000,11,1,30,10,7),
('Soho 50 Mbps','Soho/UMKM','broadband','pppoe-soho','50M','50M','soho-active','50M','50M',450000,11,1,30,10,7),
('Corporate 100 Mbps','corporate','dedicated','pppoe-corp','100M','100M','corp-active','100M','100M',2500000,11,1,30,10,7);

INSERT INTO customers (name, address, email, phone, subscription_date, customer_type, status)
VALUES
('Budi Santoso','Jl. Mawar 1','budi@example.com','08123456789','2024-01-01','personal','active'),
('PT Suka Maju','Jl. Melati 2','billing@sukamaju.co.id','0219876543','2024-02-01','company','active');

INSERT INTO routers (host_name, mikrotik_type, mikrotik_ip, api_port, username, password_or_cert, tls_enabled, status)
VALUES
('RTR-Core-1','CCR2004','10.0.0.1',8729,'apiuser','4Sehat&5Sempurna',true,'active');

INSERT INTO customer_conf (customer_id, service_id, router_id, type, username, password, service, ip_address, mac_address, router_brand, router_type, router_version, router_sn, status)
VALUES
(1,1,1,'pppoe','budi001','4Sehat&5Sempurna','pppoe','0.0.0.0','AA:BB:CC:DD:EE:01','MikroTik','hAP ac2','7.10','SN123','active'),
(2,3,1,'static','corp001','4Sehat&5Sempurna','static','203.0.113.10','AA:BB:CC:DD:EE:02','MikroTik','CCR2004','7.10','SN456','active');

INSERT INTO invoices (customer_id, service_id, amount, tax, discount, total, status, period_start, period_end, due_date)
VALUES
(1,1,250000,27500,0,277500,'unpaid','2024-03-01','2024-03-30','2024-03-10'),
(2,3,2500000,275000,0,2775000,'unpaid','2024-03-01','2024-03-30','2024-03-10');

INSERT INTO reminders (name, invoice_id, channel, template_id, scheduled_at, status)
VALUES
('H-7','1','email','tpl_new_bill','2024-03-03','pending'),
('H-3','1','whatsapp','tpl_new_bill','2024-03-07','pending');

INSERT INTO ticketing (date, customer_id, nama_pelapor, contact, description, action_date, technician_name, status)
VALUES
('2024-03-01',1,'Budi','08123456789','Koneksi lambat','2024-03-01','Tech A','open');

INSERT INTO audit_logs (user_id, action, resource_type, resource_id, payload)
VALUES (1,'seed','system','0','{}');