# Guide technique

## Technologies utilisees

- Vue 3 (composant web)
- Vite
- TypeScript
- Tailwind CSS

## Documentation de reference

- Vue 3 : https://vuejs.org/
- Vite : https://vitejs.dev/
- TypeScript : https://www.typescriptlang.org/docs/
- Tailwind CSS : https://tailwindcss.com/docs

## Developper

## Version Node.js

Utiliser Node.js 18+ (LTS recommande).

### Plugins VS Code

- Vue - Official (Volar)
- TypeScript Vue Plugin (Volar)

### Installation

```bash
npm install
```

### Formatter

Utiliser le formatter avant commit :

```bash
npm run format
```

### Lancer le serveur de dev

```bash
npm run dev
```

### Tester l'authentification

L'authentification repose sur la constante `AUTH_API_URL` dans `src/auth.ts`.

Elle charge le contenu du `whoami` fourni par la console geOrchestra (exemple :
`https://my.georchestra.fr/whoami`).

Vous pouvez alors adapter ou reprendre le contenu du fichier `/public/whoami.json`, qui est le fichier local utilise par defaut.

Pour pointer vers un autre endpoint, personnaliser `AUTH_API_URL`.

## Deployer

Builder le bundle et recuperer `header.js` dans `dist/assets` :

```bash
npm run build
```

Utiliser ensuite le nouveau `dist/assets/header.js`.

## Documentation

Cette documentation reprend le template :
https://github.com/georchestra/georchestra_documentation_template

Voir ce depot pour les details d'utilisation et de build.
