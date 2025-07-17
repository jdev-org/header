# geOrchestra header

The geOrchestra header is built using Vue and published as a web component called `geor-header`.

## Usage

The web component is distributed as a static JS file on the `dist` branch of this repository. It can easily be accessed using a service such as JsDelivr with the following url:

https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js

To include it in an existing application:

1. add a `script` tag pointing to the JS file:

```html
<script src="https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js"></script>
```

2. include the header component:

```html
<geor-header></geor-header>
```

Note: unlike with iframes there is no need to specify a height, the component will decide of its own size and "push" the content around accordingly.

Iframe can still be set with defining `legacy-url` attribute, style can also be set with `legacy-style` attribute :

```html
<geor-header legacy-url="myheader.com" legacy-style="width: 100%"></geor-header>
```

Attributes available :

| Attribute     | Description                                                                                                | Example                                                                  | For new header | For legacy header (iframe) |
|---------------|------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------| -------------- |----------------------------|
| active-app    | Use this attribute to set the active class in menu                                                         | `<geor-header active-app='console'>`                                     |                | v                          |
| config-file   | Use this attribute to set the config file for the new header (not legacy one). See [CONFIG.md](./CONFIG.md) | `<geor-header config-file="/config.json">`                               | v              |                            |
| stylesheet    | adds this stylesheet to the new header (not legacy one).                                                   | `<geor-header stylesheet="mystylesheet.css"></geor-header>`              | v              |                            |
| height        | sets the height of the header (in pixels)                                                                  | `<geor-header height="80"></geor-header>`                                | v              | v                          |
| legacy-header | Use this attribute to enable the legacy header `iframe` tag. Needs `legacy-url`.                           | `<geor-header legacy-header='true' legacy-url="/header/">`               |          | v          |
| legacy-url    | Legacy URL: if set, activates iframe with src attribute pointing to this URL. Needs `legacy-header`.       | `<geor-header legacy-header='true' legacy-url="/header/"></geor-header>` |          | v          |
| logo-url      | Use this attribute to set the logo for the new header (not legacy one).                                    | `<geor-header logo-url='https://linktomylogo.com'>`                      | v        |            |

3. Provide a custom stylesheet

Example :

```css
/* Example of custom stylesheet */
header {
  --georchestra-header-primary: #e20714;
  --georchestra-header-secondary: #333;
  --georchestra-header-primary-light: white;
  --georchestra-header-secondary-light: #eee;
}
.admin-dropdown > li.active {
  background-color: red;
  color: white;
}
```

4. Provide a Nonce for CSP

If you are using a Content Security Policy (CSP) that requires a nonce for inline scripts, you can add the `custom-nonce` attribute to the `<geor-header>` tag *and* set the `nonce` attribute on the `<script>` tag that loads the header component. This allows the header to be compliant with your CSP.:

```html
<script src="https://cdn.jsdelivr.net/gh/georchestra/header@dist/header.js" nonce="your-nonce-value"></script>
<geor-header custom-nonce="your-nonce-value"></geor-header>
```

Ideally, those values should be set by the webapp embedding the web component, so that they're unique/random per-request. See georchestra/geoserver#42 for an example.

## Development

On every new commit on main the `header.js` file on the `dist` branch is updated automatically.

### Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur) + [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin).

### Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).

### Project Setup

```sh
npm install
```

#### Compile and Hot-Reload for Development

```sh
npm run dev
```

#### Compile and Minify for Production

```sh
npm run build
```

#### Lint with [ESLint](https://eslint.org/)

```sh
npm run lint
```
