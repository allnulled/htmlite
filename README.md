# htmlite

Lenguaje para abreviar la codificación de html.

## Instalación

```sh
npm i -g htmlite
```

## Uso por código

```js
const output = require("htmlite").parse(`
@body {
  @div .main {
    @h1 > Título de página <
    @h3 >> Subtítulo de página <b>que permite HTML dentro</b> <<
    @div {
        @textarea#entrada_1 [disabled=true]
    }
  }
}`);
console.log(output.ast);
console.log(output.html);
```

## Uso por consola

```sh
htmlite index.htmlite
```

Para añadir el doctype de html5 a los ficheros que sigan en el comando:

```sh
htmlite plantilla1.htmlite plantilla2.htmlite plantilla3.htmlite --doctype index.htmlite
```


## Sintaxis

En este ejemplo se ve toda la sintaxis desplegada:

```
@div#id-1.clase-1.clase-1b/width:100%;/[editable="true"]{
  @div#id-2.clase-2/width:100%;/[]>Texto en lugar de subtags<
}
```

En este ejemplo se ve la misma sintaxis pero con espacios donde los permite:

```
@div #id-1 .clase-1 .clase-1b / width:100% ;/ [ editable="true" ] {
  @div #id-2 .clase-2 / width:100% ;/ [ ] > Texto en lugar de subtags <
}
```

## Licencia

Sí, licencia, licencia. Licencia para matar: 000/365.