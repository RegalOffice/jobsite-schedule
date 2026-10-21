-- Jobsite Schedule Board: database setup. Run once in Supabase → SQL Editor.
-- Every record (projects, tasks, delays, budgets, history…) is a JSON document keyed "collection/id".
-- Only signed-in users can read or write; the public anon key alone gets nothing.

create table if not exists public.sched_docs (
  path        text primary key,
  coll        text not null,
  data        jsonb not null,
  updated_at  timestamptz not null default now(),
  updated_by  text
);
create index if not exists sched_docs_coll_idx    on public.sched_docs (coll);
create index if not exists sched_docs_project_idx on public.sched_docs ((data->>'projectId'));

-- signed-in users only (this project doesn't grant new tables to API roles automatically)
grant select, insert, update, delete on public.sched_docs to authenticated;
revoke all on public.sched_docs from anon;

alter table public.sched_docs enable row level security;

drop policy if exists "signed-in read"   on public.sched_docs;
drop policy if exists "signed-in insert" on public.sched_docs;
drop policy if exists "signed-in update" on public.sched_docs;
drop policy if exists "signed-in delete" on public.sched_docs;
create policy "signed-in read"   on public.sched_docs for select to authenticated using (true);
create policy "signed-in insert" on public.sched_docs for insert to authenticated with check (true);
create policy "signed-in update" on public.sched_docs for update to authenticated using (true) with check (true);
create policy "signed-in delete" on public.sched_docs for delete to authenticated using (true);

-- live updates between people who have the board open
alter table public.sched_docs replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.sched_docs;
exception when duplicate_object then null; end $$;
