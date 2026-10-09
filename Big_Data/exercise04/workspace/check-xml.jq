(: fn:doc() reads a file and parses its contents as XML. :)

(: If loading or parsing fails, the query stops and reports the error.
   Edit and save the input document, then rerun this same query.
   To check another document, change the file name: xml-a.xml or xml-b.xml. :)
fn:doc("documents/xml-a.xml")
