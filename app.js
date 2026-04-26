const { createApp } = Vue

createApp({
  data() {
    return {
      view: 'list',
      products: [],
      filteredProducts: [],
      search: '',
      totalCount: 0,
      justAdded: false,

      filters: {
        category: '',
        maxPrice: 100000
      },

      form: {
        name: '',
        description: '',
        price: '',
        image_url: '',
        category: 'unisex',
        colors: []  // each: { image_url } — URL only, no name, no hex
      },
      errors: {},
      successMsg: '',

      modal: {
        open: false,
        product: null,
        slideIndex: 0,   // 0 = main image, 1,2,3... = color variants
        zoomed: false,
        deletingProduct: false
      }
    }
  },

  computed: {
    // All images for the slideshow: main image first, then color variant URLs
    allImages() {
      if (!this.modal.product) return []
      const colors = this.parseColors(this.modal.product.colors)
      const extras = colors.map(c => c.image_url).filter(Boolean)
      return [this.modal.product.image_url, ...extras]
    },

    // Currently displayed image in the modal
    modalImage() {
      return this.allImages[this.modal.slideIndex] || ''
    }
  },

  mounted() {
    this.fetchProducts()
    document.addEventListener('keydown', e => {
      if (e.key === 'Escape') {
        if (this.modal.zoomed) { this.modal.zoomed = false; return }
        this.closeModal()
      }
      if (this.modal.open && !this.modal.zoomed) {
        if (e.key === 'ArrowRight') this.slideNext()
        if (e.key === 'ArrowLeft')  this.slidePrev()
      }
    })
  },

  methods: {

    // ── Navigation ───────────────────────────────────────────
    switchToList() {
      this.view = 'list'
      this.search = ''
      this.fetchProducts()
    },

    // ── Fetch (jQuery — required by assignment) ──────────────
    fetchProducts() {
      const url = this.search
        ? `http://127.0.0.1:5000/products?search=${encodeURIComponent(this.search)}`
        : 'http://127.0.0.1:5000/products'

      $.ajax({
        url,
        method: 'GET',
        success: (data) => {
          this.products = data
          this.totalCount = data.length
          this.applyFilters()
        },
        error: (err) => console.error('Fetch error:', err)
      })
    },

    onSearchInput() { this.fetchProducts() },

    clearSearch() {
      this.search = ''
      this.fetchProducts()
    },

    // ── Filters ──────────────────────────────────────────────
    setCategory(cat) {
      this.filters.category = cat
      this.applyFilters()
    },

    applyFilters() {
      this.filteredProducts = this.products.filter(p => {
        const matchCat   = !this.filters.category || p.category === this.filters.category
        const matchPrice = Number(p.price) <= Number(this.filters.maxPrice)
        return matchCat && matchPrice
      })
    },

    resetFilters() {
      this.filters.category = ''
      this.filters.maxPrice  = 100000
      this.applyFilters()
    },

    // ── Parse colors JSON ────────────────────────────────────
    parseColors(colorsField) {
      if (!colorsField) return []
      try {
        const parsed = JSON.parse(colorsField)
        return Array.isArray(parsed) ? parsed : []
      } catch { return [] }
    },

    // ── Add/remove color URL rows in form ────────────────────
    addColorVariant() {
      this.form.colors.push({ image_url: '' })
    },

    removeColorVariant(index) {
      this.form.colors.splice(index, 1)
    },

    // ── Modal open/close ─────────────────────────────────────
    openModal(product) {
      this.modal.product    = product
      this.modal.slideIndex = 0
      this.modal.zoomed     = false
      this.modal.open       = true
    },

    closeModal() {
      this.modal.open   = false
      this.modal.zoomed = false
    },

    // ── Slideshow navigation ─────────────────────────────────
    slideNext() {
      if (this.allImages.length <= 1) return
      this.modal.slideIndex = (this.modal.slideIndex + 1) % this.allImages.length
    },

    slidePrev() {
      if (this.allImages.length <= 1) return
      this.modal.slideIndex = (this.modal.slideIndex - 1 + this.allImages.length) % this.allImages.length
    },

    // ── Delete product ───────────────────────────────────────
    deleteProduct() {
      if (!confirm(`Delete "${this.modal.product.name}" permanently?`)) return
      this.modal.deletingProduct = true

      fetch(`http://127.0.0.1:5000/products/${this.modal.product.id}`, {
        method: 'DELETE'
      })
        .then(res => res.json())
        .then(data => {
          if (data.error) {
            alert('Error: ' + data.error)
          } else {
            this.closeModal()
            this.fetchProducts()
            this.totalCount--
          }
        })
        .catch(err => console.error('Delete error:', err))
        .finally(() => { this.modal.deletingProduct = false })
    },

    // ── 3D tilt on cards ─────────────────────────────────────
    tiltCard(event) {
      const card = event.currentTarget
      const rect = card.getBoundingClientRect()
      const rotX = ((event.clientY - rect.top  - rect.height / 2) / (rect.height / 2)) * -7
      const rotY = ((event.clientX - rect.left - rect.width  / 2) / (rect.width  / 2)) *  7
      card.style.transform = `perspective(800px) rotateX(${rotX}deg) rotateY(${rotY}deg) scale(1.02)`
    },

    resetTilt(event) {
      event.currentTarget.style.transform = 'perspective(800px) rotateX(0deg) rotateY(0deg) scale(1)'
    },

    // ── Form validation ──────────────────────────────────────
    validate() {
      this.errors = {}
      if (!this.form.name.trim())        this.errors.name        = 'Name is required.'
      if (!this.form.description.trim()) this.errors.description = 'Description is required.'
      if (!this.form.price || this.form.price <= 0) this.errors.price = 'Price must be greater than zero.'
      if (!this.form.image_url.trim())   this.errors.image_url   = 'Image URL is required.'
      return Object.keys(this.errors).length === 0
    },

    // ── Submit new product ───────────────────────────────────
    submitForm() {
      this.successMsg = ''
      if (!this.validate()) return

      const payload = {
        name:        this.form.name.trim(),
        description: this.form.description.trim(),
        price:       parseFloat(this.form.price),
        image_url:   this.form.image_url.trim(),
        category:    this.form.category || 'unisex',
        // Save only image_url per color — no name, no hex
        colors:      JSON.stringify(
          this.form.colors
            .filter(c => c.image_url.trim())
            .map(c => ({ image_url: c.image_url.trim() }))
        )
      }

      fetch('http://127.0.0.1:5000/products', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      })
        .then(res => res.json())
        .then(data => {
          if (data.error) {
            alert('Server error: ' + data.error)
          } else {
            this.successMsg = 'Product added to catalog!'
            this.totalCount++
            this.justAdded = true
            this.form = { name: '', description: '', price: '', image_url: '', category: 'unisex', colors: [] }
            this.errors = {}
          }
        })
        .catch(err => console.error('Submit error:', err))
    }
  },

  watch: {
    'modal.open'(val) {
      document.body.style.overflow = val ? 'hidden' : ''
    }
  }

}).mount('#app')