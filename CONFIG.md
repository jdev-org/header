# Configuration file

A configuration file can be set to customize the header.

Inside it, you can set the following properties:

```json
{
  "config": {},
  "navigation": {},
  "i18n": {}
}
```

## Config

Config can contains old tag attributes :

```json
  "config": {
    "stylesheet": "https://data.lillemetropole.fr/public/georchestra.css",
    "logoUrl": "https://data.lillemetropole.fr/public/logo-mel.jpg",
    "hideLogin": false,
    "lang": "es"
  }
```

Full configuration [is here](./src/config-interfaces.ts#L32-L53).

:warning: You can also define stylesheet in the datadir (`default.properties`) because this file can be used in other georchestra's apps. It will take precedence over the one set in the config file of the header.

## Navigation

Navigation can contain three types of objects: `link` (by default), `separator`, or `dropdown`.

There is only one level of dropdowns. You cannot have a dropdown inside a dropdown.

Navigation is grouped as arrays of menu groups. Each group renders as a horizontal block on desktop.
If you want left and right blocks, use two groups and set the `navigation.class` accordingly (for
example `justify-between`). 

> See Tailwind's justify content utilities:
> https://tailwindcss.com/docs/justify-content

**Example:**

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
            },
            {
              "label": "Geonetwork",
              "i18n": "catalogue",
              "url": "/geonetwork/srv/:lang3/catalog.edit#/board",
              "activeAppUrl": "/geonetwork",
              "disabled": true
            }
          ]
        },
        {
          "label": "Superset admin stuff",
          "url": "/superset",
          "activeAppUrl": "/superset",
          "hasRole": "ROLE_SUPERUSER,ROLE_SUPERSET_*",
          "icon": "iconoir-graph-up"
        }
      ]
    ]
  }
}
```

Legacy: `menu` is still accepted and will be mapped to `navigation.menus[0]`.

### Active tab matching

A decision has been made in order to have the best match between the active tab and the current page.

If two conditions can be resolved for a link to be active, the longest one will be used.

URL of tab : /mapstore/#/home

- Condition 1 : activeAppUrl /mapstore
- Condition 2 : activeAppUrl /mapstore/#/home

Condition 2 will be used because /mapstore/#/home = 16 characters.

## i18n

In addition to translations set in [./src/i18n/](./src/i18n/), you can add custom translations :

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

## Url Variables

You can set some variables in some urls in the configuration file.

You can set variables in:

- `login.url`
- Each value of `login.params` iterable
- `logoutUrl`
- item's `url` in the menu
- `logoutExternalUrl`

:warning: `loginUrl` go through `new URL()` and so, must be a valid URL starting with `http://` or `https://`.
So the configuration will probably always start with `:origin` variable defined below.

All variables are available [in the `replaceUrlsVariables()` function](./src/header.ce.vue#L65).
Variables are:

| Name          | Description                                                                                |
| ------------- | ------------------------------------------------------------------------------------------ |
| `:lang3`      | Replaced with the alpha-3 country code                                                     |
| `:origin`     | Replaced with `window.location.origin`. Example: `https://www.mywebsite.com/`              |
| `:currentUrl` | Replaced with `window.location.href`. Example: `https://www.mywebsite.com/mapstore/#/home` |

## Login.url when using CAS

Login URL when using CAS must be set to

```json
    "login": {
      "url": "/cas/login",
      "params": [
        {"service": ":currentUrl"}
      ]
    },
```

in order to work properly.
