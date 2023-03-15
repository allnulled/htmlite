{
  const tabulacion = function(n) {
    let out = "";
    for(let i=0; i<n; i++) {
      out += "  ";
    }
    return out;
  };
  const transformar_a_html = function(bloque, tab=0) {
    let out = "";
    for(let i=0; i<bloque.length; i++) {
      const item = bloque[i];
      out += tabulacion(tab) + "<" + item.tag;
      if(!!item.id) {
        out += " id=" + JSON.stringify(item.id);
      }
      if(!!item.class && item.class.length) {
        out += " class=" + JSON.stringify(item.class.join(" "));
      }
      if(!!item.styles) {
        out += " styles=" + JSON.stringify(item.styles);
      }
      if(!!item.attrs) {
        out += " " + item.attrs;
      }
      out += ">";
      let is_text = true;
      if(!!item.children) {
        if(typeof item.children === "string") {
          is_text = true;
          out += item.children.trim();
        } else {
          is_text = false;
          out += "\n";
          out += transformar_a_html(item.children, tab + 1);
        }
      }
      if(!is_text) {
        out += tabulacion(tab);
      } 
      out += "</" + item.tag + ">\n";
    }
    return out;
  };
}
Language = _* bloque:Bloque _* { return { html: transformar_a_html(bloque), ast: bloque } }
Bloque = Sentencia*
Sentencia = Sentencia_de_tag
Sentencia_de_tag = "@"
  tag:Nombre_de_tag _*
  id:Identificador_de_tag? _*
  clazzes:Clases_de_tag? _*
  styles:Estilos_de_tag? _*
  attrs:Atributos_de_tag? _*
  children:Hijos_de_tag_o_texto?
    { return { tag, id, class: clazzes, styles, attrs, children } }
Atributos_de_tag = "["
  atributos:Atributos_de_tag_contenido "]"
    { return atributos }
Atributos_de_tag_contenido = [^\]]*
    { return text() }
Hijos_de_tag_o_texto = (Texto_de_tag / Hijos_de_tag)
Texto_de_tag = Texto_de_tag_1 / Texto_de_tag_2
Texto_de_tag_1 = ">>"
  contenido:Texto_de_tag_1_contenido "<<" _*
    { return contenido }
Texto_de_tag_2 = ">"
  contenido:Texto_de_tag_2_contenido "<" _*
    { return contenido }
Texto_de_tag_1_contenido = (!("<<").)* { return text() }
Texto_de_tag_2_contenido = (!("<").)* { return text() }
Hijos_de_tag = "{" _*
  hijos:Hijos_de_tag_contenido _* "}"
    { return hijos }
Hijos_de_tag_contenido = Bloque
Identificador_de_tag = "#"
  nombre:Id_de_tag?
    { return nombre }
Clases_de_tag = Clase_de_tag*
Clase_de_tag = "."
  nombre:Clase_de_tag_contenido?
    { return nombre }
Estilos_de_tag = "/"
  estilos:Estilos_de_tag_contenido ";/"
    { return estilos }
Estilos_de_tag_contenido = (!(";/").)*
    { return text() }
Id_de_tag = [A-Za-z_\-] [A-Za-z0-9_\-]* { return text() }
Nombre_de_tag = [A-Za-z_\-:.] [A-Za-z0-9_\-:.]* { return text() }
Clase_de_tag_contenido = [A-Za-z_\-] [A-Za-z0-9_\-]* { return text() }
_ = __ / ___ {}
__ = " " / "\t" {}
___ = "\n" / "\r" {}