# Guide d'administration

## Fichier de configuration

Configurer un fichier JSON via l'attribut `config-file` :

```html
<geor-header config-file="/config.json"></geor-header>
```

Structure :

```json
{
  "config": {},
  "navigation": {},
  "i18n": {}
}
```

La configuration complete est detaillee dans `src/config-interfaces.ts`.

## Parametres de configuration disponibes

Cles de premier niveau :

| Cle | Type | Description | Notes |
| --- | --- | --- | --- |
| `config` | objet | Comportement et options UI du header. | Fusionne avec les valeurs par defaut. |
| `navigation` | objet | Structure des menus. | Voir les tableaux Navigation. |
| `menu` | tableau | Menu legacy unique. | Mappe vers `navigation.menus[0]`. |
| `i18n` | objet | Traductions custom. | Fusionne avec les libelles integres. |

Champs de l'objet config :

| Champ | Type | Description | Defaut/Notes |
| --- | --- | --- | --- |
| `logoUrl` | string | URL du logo. | Fallback sur le SVG integre. |
| `minimizedLogoUrl` | string | Logo alternatif pour 768-1024px. | Optionnel. |
| `logoTitle` | string | Texte de titre pour le logo. | Non utilise dans l'UI actuelle. |
| `hideLogin` | boolean | Masquer le bouton login. | Defaut `false`. |
| `stylesheet` | string | URL CSS appliquee au header. | La feuille datadir peut ecraser. |
| `iconsUrl` | string | URL de feuille d'icones. | Optionnel. |
| `lang` | string | Forcer la langue UI. | Sinon langue navigateur. |
| `login.url` | string | URL de login. | Defaut `:currentUrl`. |
| `login.params` | tableau | Parametres query pour login. | Tableau d'objets a cle unique. |
| `login.customClass` | string | Classe CSS sur le bouton login/compte. | Optionnel. |
| `login.showAccountBtnText` | boolean | Afficher le texte "Login". | Optionnel. |
| `logoutUrl` | string | URL de logout. | Defaut `/logout`. |
| `logoutExternalUrl` | string | URL logout pour auth externe. | Fallback sur `logoutUrl`. |
| `displayFullnameInAccountBtn` | boolean | Afficher le nom complet. | Defaut `true`. |

Champs de navigation :

| Champ | Type | Description | Notes |
| --- | --- | --- | --- |
| `class` | string | Classe CSS du container nav. | ex. `justify-between`. |
| `menus` | tableau | Tableau de groupes de menus. | Chaque groupe est un tableau d'items. |

Champs communs des items (link, separator, dropdown) :

| Champ | Type | Description | Notes |
| --- | --- | --- | --- |
| `type` | string | `link` (defaut), `separator`, `dropdown`. | Omettre pour les liens. |
| `hasRole` | string | Roles autorises a voir l'item. | Separes par virgules, supporte `*`. |
| `blockedRole` | string | Roles qui masquent l'item. | Separes par virgules. |
| `hideMobile` | boolean | Masque l'item sur mobile. | Optionnel. |

Champs d'un lien :

| Champ | Type | Description | Notes |
| --- | --- | --- | --- |
| `label` | string | Libelle visible. | Peut etre remplace par `i18n`. |
| `url` | string | URL cible. | Requis pour les liens. |
| `i18n` | string | Cle i18n pour le libelle. | Optionnel. |
| `activeAppUrl` | string | Regle d'onglet actif. | Prefixes `start`, `exact`, `includes`, `end`. |
| `icon` | string | Nom de classe d'icone. | Depend de `iconsUrl`. |
| `disabled` | boolean | Desactive le clic. | Optionnel. |

Champs d'un dropdown :

| Champ | Type | Description | Notes |
| --- | --- | --- | --- |
| `label` | string | Libelle du dropdown. | Peut etre remplace par `i18n`. |
| `i18n` | string | Cle i18n du libelle. | Optionnel. |
| `items` | tableau | Liste de liens. | Un seul niveau. |

## Section config

Exemple :

```json
{
  "config": {
    "stylesheet": "https://data.lillemetropole.fr/public/georchestra.css",
    "logoUrl": "https://data.lillemetropole.fr/public/logo-mel.jpg",
    "hideLogin": false,
    "lang": "es"
  }
}
```

Note : une feuille de style definie dans le `datadir` geOrchestra
(default.properties) est prioritaire.

## Navigation

La navigation est definie par groupes de menus. Chaque groupe devient un bloc
horizontal sur desktop. Utiliser plusieurs groupes et `navigation.class`
(ex. `justify-between`) pour separer gauche/droite.

Les items peuvent etre `link` (par defaut), `separator` ou `dropdown`. Les
dropdowns ne sont pas imbriques.

Exemple :

```json
{
  "navigation": {
    "class": "justify-between",
    "menus": [
      [
        {
          "label": "Map stuff:",
          "url": "",
          "disabled": true
        },
        {
          "label": "WMS/WFS",
          "i18n": "customi18n",
          "url": "/geoserver/web",
          "activeAppUrl": "includes:/geoserver",
          "icon": "iconoir-map"
        }
      ],
      [
        {
          "type": "dropdown",
          "label": "A dropdown",
          "items": [
            {
              "label": "Console",
              "i18n": "users",
              "url": "/console/manager/home",
              "activeAppUrl": "/console",
              "icon": "iconoir-globe"
            }
          ]
        }
      ]
    ]
  }
}
```

Legacy : `menu` est toujours accepte et mappe vers `navigation.menus[0]`.

## Matching de l'onglet actif

Si plusieurs `activeAppUrl` correspondent, la condition la plus longue l'emporte.

## i18n

Ajouter des traductions custom en plus des valeurs par defaut :

```json
{
  "i18n": {
    "en": {
      "customi18nkey": "WMS/WFS service"
    },
    "fr": {
      "customi18nkey": "Service WMS/WFS"
    },
    "es": {
      "customi18nkey": "Servicio WMS/WFS"
    }
  }
}
```

## Variables d'URL

Variables disponibles dans `login.url`, `login.params`, `logoutUrl`, l'`url` des
items de menu et `logoutExternalUrl` :

- `:lang3` -> code langue alpha-3
- `:origin` -> `window.location.origin`
- `:currentUrl` -> `window.location.href`

`login.url` doit etre une URL absolue valide, donc demarre generalement par
`:origin`.

## Login URL avec CAS

```json
{
  "login": {
    "url": "/cas/login",
    "params": [
      { "service": ":currentUrl" }
    ]
  }
}
```
