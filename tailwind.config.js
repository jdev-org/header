/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html', './src/**/*.{js,ts,vue}'],
  theme: {
    extend: {
      colors: {
        primary: 'var(--georchestra-header-primary)',
        'primary-light': 'var(--georchestra-header-primary-light)',
      },
    },
  },
  variants: {
    display: ['group-hover'],
  },
  plugins: [],
}
