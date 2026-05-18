// Configuracion del cliente Supabase para el frontend
const SUPABASE_URL = 'https://nfdiupwzzxseuymcejbh.supabase.co'
const SUPABASE_KEY = 'sb_publishable_pLeL23jDPkXEwxBI_Q1ZpQ_pZ40CrVn'

const { createClient } = window.supabase
const supabaseClient = createClient(SUPABASE_URL, SUPABASE_KEY)
