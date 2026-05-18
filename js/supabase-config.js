// Configuracion del cliente Supabase para el frontend
const SUPABASE_URL = 'https://disufhicxshjudewytwe.supabase.co'
const SUPABASE_KEY = 'sb_publishable_kkftoax2-WzWDUnjEk416w_QFQDDHL5'

const { createClient } = window.supabase
const supabaseClient = createClient(SUPABASE_URL, SUPABASE_KEY)
