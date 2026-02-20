# Guide d'installation

## Integration datadir

Le datadir geOrchestra contient une section dediee au header :
https://github.com/georchestra/datadir/tree/master/header

Ces parametres permettent de configurer le header depuis le datadir, notamment
le script a charger et l'usage du header legacy.

## Parametres datadir (default.properties)

Resume simple des reglages du header :

| Parametre | Description | Defaut |
| --- | --- | --- |
| `headerScript` | URL du script du composant header. | `https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js` |
| `headerHeight` | Hauteur du header en px. | `80` |
| `useLegacyHeader` | Conserver le header historique en iframe. | `false` |
| `headerUrl` | URL du header legacy (utilisee si `useLegacyHeader=true`). | `/header/` |

## Remplacement du legacy

Le nouveau composant header remplace le header legacy.

Pour l'utiliser, definir `useLegacyHeader=true` dans `default.properties` du datadir.

## Usage

Le composant web est distribue sous forme de fichier JS statique sur la branche `dist`.
Il est accessible via un CDN comme JsDelivr :

https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js

1. Ajouter une balise script pointant vers le JS :

```html
<script src="https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js"></script>
```

2. Inserer le composant header :

```html
<geor-header></geor-header>
```

Note : contrairement aux iframes il n'est pas necessaire de definir une hauteur, le composant
gere sa taille et decale le contenu de page.

Le mode iframe legacy reste disponible avec `legacy-header` et `legacy-url` :

```html
<geor-header legacy-header="true" legacy-url="/header/" legacy-style="width: 100%"></geor-header>
```

### Attributs disponibles

| Attribut | Description | Exemple | Nouveau header | Header legacy (iframe) |
| --- | --- | --- | --- | --- |
| `active-app` | Definir l'onglet actif dans le menu. | `<geor-header active-app='console'>` |  | v |
| `config-file` | Chemin du fichier de config du nouveau header. | `<geor-header config-file="/config.json">` | v |  |
| `stylesheet` | Ajouter une feuille de style au nouveau header. | `<geor-header stylesheet="mystylesheet.css">` | v |  |
| `height` | Definir la hauteur en pixels. | `<geor-header height="80">` | v | v |
| `legacy-header` | Activer le header legacy en iframe. | `<geor-header legacy-header="true">` |  | v |
| `legacy-url` | URL de l'iframe legacy. Requiert `legacy-header`. | `<geor-header legacy-header="true" legacy-url="/header/">` |  | v |
| `logo-url` | URL du logo pour le nouveau header. | `<geor-header logo-url="https://linktomylogo.com">` | v |  |
| `custom-nonce` | Nonce CSP pour les liens injectes. | `<geor-header custom-nonce="nonce">` | v |  |

## Feuille de style custom

```css
header {
  --georchestra-header-primary: #e20714;
  --georchestra-header-primary-light: white;
}
.admin-dropdown > li.active {
  background-color: red;
  color: white;
}
```

## Nonce CSP

Si votre CSP exige un nonce pour les scripts inline, definir la valeur sur le script et le composant :

```html
<script src="https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js" nonce="your-nonce-value"></script>
<geor-header custom-nonce="your-nonce-value"></geor-header>
```
