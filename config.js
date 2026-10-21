// Connection settings for the Supabase project that stores the schedule.
// The anon key is meant to be public: the database only answers signed-in users (see supabase/setup.sql).
window.SCHED_CONFIG = {
  url: "https://inzfsmqqvpkrreypvciw.supabase.co",      // e.g. "https://abcdefghijklmnop.supabase.co"  (Supabase → Project Settings → API → Project URL)
  anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImluemZzbXFxdnBrcnJleXB2Y2l3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQ4MTI2MjQsImV4cCI6MjEwMDM4ODYyNH0._6Y-jGkf4wv6cEL51mGCCnt2_SXN2cNglovdrHtkzQU",  // Supabase → Project Settings → API → anon public key
  email: "scheduler@bancroftconstruction.com" // the shared login's email; everyone signs in with its password
};
