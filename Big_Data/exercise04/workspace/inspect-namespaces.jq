(: Lists every element and attribute in catalog.xml with its namespace URI. :)
let $doc := fn:doc("documents/catalog.xml")
return [
  for $node in ($doc//*, $doc//@*)
  let $uri := fn:namespace-uri($node)
  return fn:concat(
    if ($node instance of attribute()) then "attribute " else "element ",
    fn:local-name($node), " -> ",
    if ($uri eq "") then "no namespace" else $uri)
]
