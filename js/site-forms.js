function firstElement(ids) {
  for (const id of ids) {
    const el = document.getElementById(id)
    if (el) return el
  }
  return null
}

function fieldValue(ids) {
  const el = firstElement(ids)
  if (!el) return ''
  return typeof el.value === 'string' ? el.value.trim() : ''
}

function normalizeChoice(value, placeholders) {
  if (!value) return ''
  return placeholders.includes(value) ? '' : value
}

function setElementDisplay(id, display) {
  const el = document.getElementById(id)
  if (el) el.style.display = display
}

function setText(id, text) {
  const el = document.getElementById(id)
  if (el) el.textContent = text
}

function showError(id, message) {
  const el = document.getElementById(id)
  if (!el) return
  el.textContent = message
  el.style.display = 'block'
}

function hideError(id) {
  const el = document.getElementById(id)
  if (!el) return
  el.textContent = ''
  el.style.display = 'none'
}

function requireSupabase(errorId) {
  if (typeof supabaseClient !== 'undefined') return true
  showError(errorId, 'No se encontro la configuracion de Supabase.')
  return false
}

async function findClientByEmail(email) {
  if (!email) return null

  const { data, error } = await supabaseClient
    .from('clientes')
    .select('id_cliente, nombre, apellido, telefono, email')
    .eq('email', email)
    .limit(1)

  if (error) throw error
  return data && data.length > 0 ? data[0] : null
}

async function ensureClient(nombre, apellido, email, telefono) {
  const existingClient = await findClientByEmail(email)

  if (existingClient) {
    const payload = {
      nombre,
      apellido,
      telefono: telefono || null
    }

    const shouldUpdate =
      existingClient.nombre !== nombre ||
      existingClient.apellido !== apellido ||
      (existingClient.telefono || '') !== (telefono || '')

    if (shouldUpdate) {
      const { error } = await supabaseClient
        .from('clientes')
        .update(payload)
        .eq('id_cliente', existingClient.id_cliente)

      if (error) throw error
    }

    return existingClient.id_cliente
  }

  const { data, error } = await supabaseClient
    .from('clientes')
    .insert([{
      nombre,
      apellido,
      email: email || null,
      telefono: telefono || null
    }])
    .select('id_cliente')

  if (error) throw error
  return data[0].id_cliente
}

async function saveContactDetails(payload) {
  const { error } = await supabaseClient
    .from('contactos')
    .insert([payload])

  if (error && !isMissingContactsTableError(error)) {
    throw error
  }
}

function isMissingContactsTableError(error) {
  if (!error) return false

  return error.code === '42P01' ||
    error.code === 'PGRST205' ||
    String(error.message || '').includes("Could not find the table 'public.contactos'")
}

window.confirmarReserva = async function confirmarReserva() {
  if (!requireSupabase('reserveError')) return

  const nombre = fieldValue(['rNombre'])
  const apellido = fieldValue(['rApellido'])
  const email = fieldValue(['rEmail'])
  const telefono = fieldValue(['rPhone'])
  const fecha = fieldValue(['rDate'])
  const horaRaw = normalizeChoice(fieldValue(['rTime']), ['Selecciona hora'])
  const personas = normalizeChoice(fieldValue(['rPeople']), ['¿Cuantos son?', '¿Cuántos son?'])
  const ocasion = normalizeChoice(fieldValue(['rOccasion']), ['Tipo de visita'])
  const errId = 'reserveError'
  const btn = document.getElementById('reserveSubmit')

  hideError(errId)

  if (!nombre || !apellido || !fecha || !horaRaw || !personas) {
    showError(errId, 'Completa los campos: nombre, apellido, fecha, hora y personas.')
    return
  }

  const horaMap = {
    '6:00 PM': '18:00:00',
    '7:00 PM': '19:00:00',
    '8:00 PM': '20:00:00',
    '9:00 PM': '21:00:00',
    '10:00 PM': '22:00:00',
    '11:00 PM': '23:00:00'
  }

  btn.disabled = true
  btn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Guardando...'

  try {
    const idCliente = await ensureClient(nombre, apellido, email, telefono)

    const { error } = await supabaseClient
      .from('reservas')
      .insert([{
        id_cliente: idCliente,
        fecha,
        hora: horaMap[horaRaw] || '20:00:00',
        num_personas: parseInt(personas, 10),
        ocasion: ocasion || null,
        estado: 'Pendiente'
      }])

    if (error) throw error

    setElementDisplay('reserveFormWrap', 'none')
    setText('reserveSuccessMsg', `${nombre}, tu reserva para el ${fecha} a las ${horaRaw} fue registrada. ¡Te esperamos!`)
    setElementDisplay('reserveSuccess', 'block')
  } catch (error) {
    showError(errId, 'Error al guardar: ' + error.message)
  } finally {
    btn.disabled = false
    btn.innerHTML = '<i class="bi bi-calendar-check me-2"></i>Confirmar Reserva'
  }
}

window.nuevaReserva = function nuevaReserva() {
  setElementDisplay('reserveFormWrap', 'block')
  setElementDisplay('reserveSuccess', 'none')

  const ids = ['rNombre', 'rApellido', 'rEmail', 'rPhone', 'rDate', 'rTime', 'rPeople', 'rOccasion']
  ids.forEach(id => {
    const el = document.getElementById(id)
    if (el) el.value = ''
  })

  hideError('reserveError')
}

window.enviarContacto = async function enviarContacto() {
  if (!requireSupabase('contactErr') && !requireSupabase('contactError')) return

  const nombre = fieldValue(['cfNombre', 'fname'])
  const apellido = fieldValue(['cfApellido', 'flast'])
  const email = fieldValue(['cfEmail', 'femail'])
  const telefono = fieldValue(['cfTelefono', 'fphone'])
  const motivo = normalizeChoice(fieldValue(['cfReason', 'freason']), ['Selecciona un motivo'])
  const fechaVisita = fieldValue(['fdate'])
  const personas = normalizeChoice(fieldValue(['fpeople']), ['¿Cuantos son?', '¿Cuántos son?'])
  const mensaje = fieldValue(['cfMsg', 'fmsg'])
  const terms = firstElement(['terms'])
  const errId = document.getElementById('contactErr') ? 'contactErr' : 'contactError'
  const btn = document.querySelector('#contactForm .btn-submit')

  hideError(errId)

  if (!nombre || !apellido || !email) {
    showError(errId, 'Nombre, apellido y correo son obligatorios.')
    return
  }

  if (terms && !terms.checked) {
    showError(errId, 'Debes aceptar las comunicaciones para enviar el formulario.')
    return
  }

  btn.disabled = true
  btn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Enviando...'

  try {
    const idCliente = await ensureClient(nombre, apellido, email, telefono)

    await saveContactDetails({
      id_cliente: idCliente,
      nombre,
      apellido,
      email,
      telefono: telefono || null,
      motivo: motivo || null,
      fecha_visita: fechaVisita || null,
      personas: personas || null,
      mensaje: mensaje || null
    })

    setElementDisplay('contactForm', 'none')
    setElementDisplay('contactSuccess', 'block')
    setElementDisplay('successMsg', 'block')
  } catch (error) {
    showError(errId, 'Error al guardar: ' + error.message)
  } finally {
    btn.disabled = false
    btn.innerHTML = '<i class="bi bi-send me-2"></i>Enviar Mensaje'
  }
}
