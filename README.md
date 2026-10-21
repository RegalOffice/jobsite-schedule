# Jobsite Schedule Board

Bancroft Construction's shared job schedule: linked tasks with critical path, work calendar,
deadlines and notes, delay log, AIA-based billing forecast with earned value, version history,
and PDF/Excel export. One page (`index.html`), hosted on GitHub Pages, data in Supabase.

Everyone signs in with one shared password, then types their name so the change history shows who
did what. The password is checked by Supabase on the server; the database answers only signed-in
users, so the public page and its public anon key on their own can't read or change anything.

## One-time setup (Supabase)

1. **Create the table.** Supabase → SQL Editor → run `supabase/setup.sql`.
2. **Create the shared login.** Authentication → Users → *Add user* → *Create new user*:
   - Email: `scheduler@bancroftconstruction.com` (or any address; it must match `email` in `config.js`)
   - Password: the shared password
   - Tick **Auto Confirm User**
3. **Turn off sign-ups (important).** Authentication → Sign In / Providers → Email → turn off
   **Allow new users to sign up**. Otherwise anyone could create their own login.
4. **Connect the page.** Project Settings → API: copy the **Project URL** and the **anon public**
   key into `config.js`.
5. **Bring over the existing data** (only once): run `migration/import-data.sql` in the SQL Editor.
   That file holds real job and billing figures and is deliberately not in git.

To change the password later: Authentication → Users → the shared user → *Reset password* /
*Update user*. Everyone signed in stays signed in until they click **Sign out**.

## Editing the board

The board's code lives in `src/app.html`; the login and database layer in `src/platform.html`.
After changing either, rebuild and push:

```
powershell -ExecutionPolicy Bypass -File build.ps1
git add -A && git commit -m "…" && git push
```

GitHub Pages republishes within a minute or two.

## Notes

- Supabase pauses free projects after a week without activity; if the board says the database isn't
  responding, restore the project from the Supabase dashboard.
- History records each person by the name they typed at sign-in.
