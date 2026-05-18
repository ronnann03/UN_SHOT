function filterMenu(cat, btn) {
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  document.querySelectorAll('.menu-section').forEach(sec => {
    sec.style.display = (cat === 'all' || sec.dataset.cat === cat) ? 'block' : 'none';
  });
}
