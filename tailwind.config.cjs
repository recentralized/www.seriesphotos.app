/** @type {import('tailwindcss').Config} */
module.exports = {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  darkMode: 'class',
	theme: {
    colors: {
      'back': '#222222',
      'secondary': '#AFAFAF',
      'primary': '#FFFFFF'
    },
    fontFamily: {
      sans: ['"Ringside Regular SSm A", "Ringside Regular SSm B"', 'sans-serif'],
    },
		extend: {},
	},
  plugins: [
    require('@tailwindcss/typography')
  ],
}
