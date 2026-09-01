-- Run in Supabase SQL Editor before accepting form submissions.

create table if not exists public.diagnosis_requests (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  company_name text not null,
  ceo_name text not null,
  email text not null,
  phone text not null,
  industry text not null,
  company_size text not null,
  description text not null,
  consent boolean not null default true
);

alter table public.diagnosis_requests enable row level security;

-- Anonymous visitors may insert only (GitHub Pages / static site).
grant usage on schema public to anon;
grant insert on table public.diagnosis_requests to anon;

create policy "anon_insert_diagnosis_requests"
  on public.diagnosis_requests
  for insert
  to anon
  with check (consent = true);

-- No SELECT / UPDATE / DELETE policies for anon → other people's data stays private.
-- View submitted rows in Supabase Dashboard (service role) or add authenticated admin policies later.
