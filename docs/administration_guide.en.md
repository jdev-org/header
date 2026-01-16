# Administration guide

## Configuration file

Set a JSON configuration file with the `config-file` attribute:

```html
<geor-header config-file="/config.json"></geor-header>
```

It can define:

```json
{
  "config": {},
  "navigation": {},
  "i18n": {}
}
```

Full configuration is described in `src/config-interfaces.ts`.

## Available configuration parameters

Top-level keys:

| Key | Type | Description | Notes |
| --- | --- | --- | --- |
| `config` | object | Header behavior and UI settings. | Merged with defaults. |
| `navigation` | object | Menu structure. | See Navigation tables. |
| `menu` | array | Legacy single menu array. | Maps to `navigation.menus[0]`. |
| `i18n` | object | Custom translations. | Merged with built-in strings. |

Config object fields:

| Field | Type | Description | Default/Notes |
| --- | --- | --- | --- |
| `logoUrl` | string | Logo image URL. | Falls back to embedded SVG if missing. |
| `minimizedLogoUrl` | string | Alternative logo for 768-1024px. | Optional. |
| `logoTitle` | string | Logo title text. | Not used in current UI. |
| `hideLogin` | boolean | Hide login button. | Default `false`. |
| `stylesheet` | string | External CSS URL applied to header. | Datadir stylesheet can override. |
| `iconsUrl` | string | Icon font stylesheet URL. | Optional. |
| `lang` | string | Force UI language. | Uses browser language otherwise. |
| `login.url` | string | Login URL. | Default `:currentUrl`. |
| `login.params` | array | Query params to add to login URL. | Array of single-key objects. |
| `login.customClass` | string | Extra CSS class on login/account button. | Optional. |
| `login.showAccountBtnText` | boolean | Show "Login" text instead of icon. | Optional. |
| `logoutUrl` | string | Logout URL. | Default `/logout`. |
| `logoutExternalUrl` | string | Logout URL for external auth users. | Falls back to `logoutUrl`. |
| `displayFullnameInAccountBtn` | boolean | Show full name in account button. | Default `true`. |

Navigation fields:

| Field | Type | Description | Notes |
| --- | --- | --- | --- |
| `class` | string | CSS class for the nav container. | e.g. `justify-between`. |
| `menus` | array | Array of menu groups. | Each group is an array of items. |

Menu item fields (apply to `link`, `separator`, `dropdown`):

| Field | Type | Description | Notes |
| --- | --- | --- | --- |
| `type` | string | `link` (default), `separator`, `dropdown`. | Omit for links. |
| `hasRole` | string | Roles allowed to view the item. | Comma-separated, supports `*`. |
| `blockedRole` | string | Roles that hide the item. | Comma-separated. |
| `hideMobile` | boolean | Hide the item on mobile. | Optional. |

Link fields:

| Field | Type | Description | Notes |
| --- | --- | --- | --- |
| `label` | string | Visible label. | Can be replaced by `i18n`. |
| `url` | string | Target URL. | Required for links. |
| `i18n` | string | i18n key for label. | Optional. |
| `activeAppUrl` | string | Active tab matcher. | `start`, `exact`, `includes`, `end` prefixes supported. |
| `icon` | string | Icon class name. | Depends on `iconsUrl`. |
| `disabled` | boolean | Disable clicking. | Optional. |

Dropdown fields:

| Field | Type | Description | Notes |
| --- | --- | --- | --- |
| `label` | string | Dropdown label. | Can be replaced by `i18n`. |
| `i18n` | string | i18n key for label. | Optional. |
| `items` | array | List of link items. | Single level only. |

## Config section

Example:

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

Note: a stylesheet defined in the geOrchestra `datadir` (default.properties) takes
precedence over the config file.

## Navigation

Navigation is defined as menu groups. Each group becomes a horizontal block on desktop.
Use multiple groups and `navigation.class` (e.g. `justify-between`) to split left/right.

Menu items can be `link` (default), `separator`, or `dropdown`. Dropdowns are single-level.

Example:

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

Legacy: `menu` is still accepted and maps to `navigation.menus[0]`.

## Active tab matching

If multiple `activeAppUrl` patterns match, the longest match wins. This keeps the
active tab aligned with the current page.

## i18n

Add custom translations on top of defaults:

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

## URL variables

Variables are available in `login.url`, `login.params`, `logoutUrl`, menu item `url`,
and `logoutExternalUrl`:

- `:lang3` -> alpha-3 language code
- `:origin` -> `window.location.origin`
- `:currentUrl` -> `window.location.href`

`login.url` must be a valid absolute URL, so it typically starts with `:origin`.

## Login URL with CAS

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
