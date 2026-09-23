-- 발 통증 일기: 테이블을 "로그인한 본인만" 읽고 쓸 수 있게 잠근다.
-- Supabase 대시보드 → SQL Editor 에 붙여 넣고 실행.
-- ★ 먼저 Authentication → Users 에서 내 계정을 만들고, 그 계정의 UUID 를 아래 <MY_USER_ID> 두 곳에 넣을 것.

-- 1) 소유자 컬럼. 새 행은 로그인한 사용자 id 가 자동으로 들어간다.
alter table public.records add column if not exists user_id uuid default auth.uid();
alter table public.hosps   add column if not exists user_id uuid default auth.uid();

-- 2) 지금까지의 기록을 내 계정 소유로.
update public.records set user_id = '<MY_USER_ID>' where user_id is null;
update public.hosps   set user_id = '<MY_USER_ID>' where user_id is null;
alter table public.records alter column user_id set not null;
alter table public.hosps   alter column user_id set not null;

-- 3) 기존 정책이 있었다면(전체 허용 등) 모두 제거.
do $$ declare p record; begin
  for p in select policyname, tablename from pg_policies
           where schemaname = 'public' and tablename in ('records','hosps') loop
    execute format('drop policy %I on public.%I', p.policyname, p.tablename);
  end loop;
end $$;

-- 4) RLS 켜고 "본인 행만" 정책. anon(로그인 안 한 요청)에는 정책이 없으므로 아무것도 못 본다.
alter table public.records enable row level security;
alter table public.hosps   enable row level security;
create policy "own rows" on public.records for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own rows" on public.hosps for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- 5) 이중 안전장치: anon 역할의 테이블 권한 자체를 회수.
revoke all on public.records, public.hosps from anon;

-- 확인: 아래가 두 테이블 모두 rowsecurity = true, 정책 1개씩이면 성공.
select tablename, rowsecurity from pg_tables where schemaname='public' and tablename in ('records','hosps');
select tablename, policyname, roles from pg_policies where schemaname='public' and tablename in ('records','hosps');
