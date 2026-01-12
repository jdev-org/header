# Configuration file

A configuration file can be set to customize the header.

Inside it, you can set the following properties:

```json
{
  "config": {},
  "menu": [],
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

## Menu

Menu can contain three type of objects : `link` (by default), `separator` or `dropdown`

There's actually just one level of dropdowns. You cannot have a dropdown inside a dropdown.

To see the actual structure of the menu, you can check the [menu interface](./src/default-config.json)

### Menu side selection (left or right)

We allow to select left or right side to ease position management inside Navbar.
Use `targetMenu` property with value "right" or "left" or empty.

Left side will contain items without `targetMenu` property and items with `targetMenu="left"` value.
Righ side will contain items with `targetMenu="right"` value

Menu's item configuration example : 

```
    {
      "label": "Contact",
      "url": "/mapstore/",
      "activeAppUrl": "includes:/mapstore",
      "iconUrl": "/public/icon_map.svg",
      "customClass": "tuto-btn",
      "targetMenu": "right"
    }
```
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
