// Connection settings for the Supabase project that stores the schedule.
// The anon key is meant to be public: the database only answers signed-in users (see supabase/setup.sql).
window.SCHED_CONFIG = {
  url: "",      // e.g. "https://abcdefghijklmnop.supabase.co"  (Supabase → Project Settings → API → Project URL)
  anonKey: "",  // Supabase → Project Settings → API → anon public key
  email: "scheduler@bancroftconstruction.com" // the shared login's email; everyone signs in with its password
};
