// UNSHOT Bar - Funciones utiles compartidas

function formatDate(dateStr) {
  if (!dateStr) return '-'
  const d = new Date(dateStr + 'T00:00:00')
  return d.toLocaleDateString('es-PE', { day: '2-digit', month: 'short', year: 'numeric' })
}

function formatTime(timeStr) {
  if (!timeStr) return '-'
  return timeStr.substring(0, 5)
}

function badgeEstado(estado) {
  const map = {
    'Confirmada': 'badge-confirmada',
    'Pendiente':  'badge-pendiente',
    'Cancelada':  'badge-cancelada'
  }
  const cls = map[estado] || 'badge-pendiente'
  return `<span class="estado-badge ${cls}">${estado}</span>`
}
