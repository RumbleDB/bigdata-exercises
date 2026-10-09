(: fn:json-doc() reads a file and parses its contents as JSON. 
    The quoted argument is a string containing a path, resolved relative to this query file. :)
(: The final expression is the query's result: here, the parsed JSON value.
   If loading or parsing fails, the query stops and reports the error.
   Edit and save the input document, then rerun this same query.
   To check another document, change the file name: json-a.json to json-d.json. :)
fn:json-doc("documents/json-a.json")
