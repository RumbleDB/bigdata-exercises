(: Bind the prefixes used in the paths to namespace URIs.
   Only the URIs must match the document; the prefixes are local to this query. :)
declare namespace cat = "http://example.org/catalog";
declare namespace bk = "http://example.org/book";
declare namespace pub = "http://example.org/publisher";

(: Load the XML file. Its path is relative to this query file. :)
let $doc := fn:doc("documents/catalog.xml")

(: Replace the path after return with each path from Section 5.3. :)
return $doc/catalog/book
