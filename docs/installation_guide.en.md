# Installation guide

## Datadir integration

The geOrchestra datadir includes a dedicated header section:
https://github.com/georchestra/datadir/tree/master/header

These parameters let you configure the header from the datadir, including which
script URL is loaded and whether the legacy iframe is used.

## Datadir parameters (default.properties)

Simple overview of the header settings:

| Parameter | Description | Default |
| --- | --- | --- |
| `headerScript` | URL of the header web component script. | `https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js` |
| `headerHeight` | Header height in px. | `80` |
| `useLegacyHeader` | To keep using the legacy header | `false` |
| `headerUrl` | Legacy header URL (used only if `useLegacyHeader=true`). | `/header/` |

## Legacy replacement

The new header web component replaces the legacy header.

To use it, set `useLegacyHeader=true` in `default.properties` of the datadir.

## Usage

The web component is distributed as a static JS file on the `dist` branch of this repository.
It can be accessed via a CDN such as JsDelivr:

https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js

1. Add a script tag pointing to the JS file:

```html
<script src="https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js"></script>
```

2. Include the header component:

```html
<geor-header></geor-header>
```

Note: unlike iframes there is no need to specify a height, the component decides its own size
and pushes the page content accordingly.

Legacy iframe mode is still available by setting `legacy-header` and `legacy-url`:

```html
<geor-header legacy-header="true" legacy-url="/header/" legacy-style="width: 100%"></geor-header>
```

### Available attributes

| Attribute | Description | Example | For new header | For legacy header (iframe) |
| --- | --- | --- | --- | --- |
| `active-app` | Set the active class in the menu. | `<geor-header active-app='console'>` |  | v |
| `config-file` | Path to the config file for the new header. | `<geor-header config-file="/config.json">` | v |  |
| `stylesheet` | Add a stylesheet to the new header. | `<geor-header stylesheet="mystylesheet.css">` | v |  |
| `height` | Set the header height in pixels. | `<geor-header height="80">` | v | v |
| `legacy-header` | Enable the legacy iframe header. | `<geor-header legacy-header="true">` |  | v |
| `legacy-url` | Legacy iframe URL. Requires `legacy-header`. | `<geor-header legacy-header="true" legacy-url="/header/">` |  | v |
| `logo-url` | Logo URL for the new header. | `<geor-header logo-url="https://linktomylogo.com">` | v |  |
| `custom-nonce` | CSP nonce value used on injected links. | `<geor-header custom-nonce="nonce">` | v |  |

## Custom stylesheet

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

## CSP nonce

If your CSP requires a nonce for inline scripts, set it on the script tag and the component:

```html
<script src="https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js" nonce="your-nonce-value"></script>
<geor-header custom-nonce="your-nonce-value"></geor-header>
```
