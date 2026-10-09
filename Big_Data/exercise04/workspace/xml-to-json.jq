declare namespace cat = "http://example.org/catalog";
declare namespace bk = "http://example.org/book";
declare namespace pub = "http://example.org/publisher";

(: Load the XML file. Its path is relative to this query file. :)
let $doc := fn:doc("documents/catalog.xml")

(: { "key": value } builds a JSON object, and [ ... ] builds a JSON array. :)
return {
  "magazines": [
    for $magazine in $doc/cat:catalog/bk:magazine
    return {
      "title": $magazine/cat:title/string(),
      "editor": $magazine/pub:editor/string(),
      "issue": xs:integer($magazine/@issue)
    }
  ]
  (: Section 5.6: add a "books" key here. :)
}
