# Technical guide

## Technologies used

- Vue 3 web component
- Vite build tool
- TypeScript
- Tailwind CSS

## Reference documentation

- Vue 3: [https://vuejs.org/](https://vuejs.org/)
- Vite: [https://vitejs.dev/](https://vitejs.dev/)
- TypeScript: [https://www.typescriptlang.org/docs/](https://www.typescriptlang.org/docs/)
- Tailwind CSS: [https://tailwindcss.com/docs](https://tailwindcss.com/docs)

## Develop

## Node.js version

Use Node.js 18+ (LTS recommended).

### VS Code plugins

- Vue - Official (Volar)
- TypeScript Vue Plugin (Volar)

### Installation

```bash
npm install
```

### Formatting

Use the formatter before commits:

```bash
npm run format
```

### Run the dev server

```bash
npm run dev
```

### Test authentication

Authentication relies on the `AUTH_API_URL` constant in `src/auth.ts`. It fetches
the `whoami` payload provided by the geOrchestra console (example:
`https://my.georchestra.fr/whoami`). You can copy that JSON into
`/public/whoami.json`, which is the default local file used by the header.

To point to another endpoint, customize `AUTH_API_URL`.

## Deploy

Build the production bundle and retrieve `header.js` from `dist/assets`:

```bash
npm run build
```

Finally, use the new `dist/assets/header.js`.

## Documentation

This documentation is based on the template:
https://github.com/georchestra/georchestra_documentation_template

See that repository for detailed usage and build instructions.
