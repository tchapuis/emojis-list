module.exports = {
  purge: [
    './components/**/*.{vue,js}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './plugins/**/*.{js,ts}',
    './nuxt.config.{js,ts}'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        primary: {
          lighter: '#4F90A1',
          light: '#5482AB',
          DEFAULT: '#516395',
          dark: '#5454AB',
          darker: '#654FA1'
        }
      }
    }
  },
  variants: {
    extend: {}
  },
  plugins: []
}
