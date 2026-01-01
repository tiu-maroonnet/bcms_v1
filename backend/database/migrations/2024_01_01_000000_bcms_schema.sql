-- Core tables
CREATE TABLE company (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  logo VARCHAR(255),
  brand VARCHAR(255),
  brand_logo VARCHAR(255),
  address TEXT,
  phone VARCHAR(50),
  email VARCHAR(255),
  npwp VARCHAR(50),
  bank VARCHAR(100),
  bank_account VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE users_group (
  id SERIAL PRIMARY KEY,
  name_group VARCHAR(100) NOT NULL,
  permission JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  full_name VARCHAR(150),
  group_id INT REFERENCES users_group(id),
  email VARCHAR(150) UNIQUE NOT NULL,
  phone VARCHAR(50),
  password VARCHAR(255) NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE services (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  service_type VARCHAR(50),
  bandwidth_types VARCHAR(50),
  pppoe_profile VARCHAR(100),
  rate_limit_up VARCHAR(50),
  rate_limit_down VARCHAR(50),
  address_list VARCHAR(100),
  max_limit_up VARCHAR(50),
  max_limit_down VARCHAR(50),
  limit_at_up VARCHAR(50),
  limit_at_down VARCHAR(50),
  burst_limit_up VARCHAR(50),
  burst_limit_down VARCHAR(50),
  burst_threshold_up VARCHAR(50),
  burst_threshold_down VARCHAR(50),
  burst_time_up VARCHAR(50),
  burst_time_down VARCHAR(50),
  priority_up VARCHAR(10),
  priority_down VARCHAR(10),
  price NUMERIC(14,2),
  tax_rate NUMERIC(5,2),
  period_start INT,
  period_end INT,
  due_date INT,
  suspension_grace_days INT DEFAULT 7,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  address TEXT,
  email VARCHAR(150),
  phone VARCHAR(50),
  subscription_date DATE,
  customer_type VARCHAR(50),
  pic_name VARCHAR(150),
  pic_phone VARCHAR(50),
  company_name VARCHAR(150),
  billing_email VARCHAR(150),
  billing_address TEXT,
  scan_documents TEXT,
  activation_date DATE,
  status VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE routers (
  id SERIAL PRIMARY KEY,
  host_name VARCHAR(100),
  mikrotik_type VARCHAR(50),
  mikrotik_ip INET,
  api_port INT DEFAULT 8729,
  username VARCHAR(100),
  password_or_cert TEXT,
  tls_enabled BOOLEAN DEFAULT true,
  status VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE customer_conf (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id),
  service_id INT REFERENCES services(id),
  router_id INT REFERENCES routers(id),
  type VARCHAR(20), -- pppoe/static
  username VARCHAR(100),
  password VARCHAR(150),
  service VARCHAR(100),
  ip_address INET,
  mac_address VARCHAR(50),
  router_brand VARCHAR(50),
  router_type VARCHAR(50),
  router_version VARCHAR(50),
  router_sn VARCHAR(100),
  router_foto TEXT,
  status VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id),
  service_id INT REFERENCES services(id),
  amount NUMERIC(14,2),
  tax NUMERIC(14,2),
  discount NUMERIC(14,2) DEFAULT 0,
  total NUMERIC(14,2),
  status VARCHAR(20) DEFAULT 'unpaid',
  period_start DATE,
  period_end DATE,
  due_date DATE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  invoice_id INT REFERENCES invoices(id),
  method VARCHAR(50),
  amount NUMERIC(14,2),
  paid_at TIMESTAMP,
  bukti_bayar TEXT,
  reference VARCHAR(150),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE reminders (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150),
  invoice_id INT REFERENCES invoices(id),
  channel VARCHAR(20),
  template_id VARCHAR(100),
  scheduled_at TIMESTAMP,
  sent_at TIMESTAMP,
  status VARCHAR(20),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ticketing (
  id SERIAL PRIMARY KEY,
  date DATE,
  customer_id INT REFERENCES customers(id),
  nama_pelapor VARCHAR(150),
  contact VARCHAR(100),
  description TEXT,
  action_date DATE,
  technician_name VARCHAR(150),
  status VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE audit_logs (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  action VARCHAR(150),
  resource_type VARCHAR(100),
  resource_id INT,
  payload JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);