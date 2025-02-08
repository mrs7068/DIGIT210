## Regex 4: Mulan Screenplay

1. Cut out the top meta information for now.

1. Find and replace any of XML's reserved characters (`&`, `<`, `>`). (There were none). If there were any, replace them with (`&amp;`, `&lt;`, `&gt;`)

1. Remove extra blank lines. There was only one case in this document. Every other "chunk" was separated by two newline characters.

	```
	Find: (\n){3,}
	Replace: \n\n
	```

1. Wrap each "chunk" in `<sp>` tags. Remove the extraneous closing tag from the top of the document and move it to the last line of the document.

	```
	Find: \n\n
	Replace: \n</sp>\n<sp>\n
	```

1. Add a root element. (select "Dot matches all")

	```
	Find: .+
	Replace: <xml>\n\0\n</xml>
	```
	
1. Re-insert and format the metadata at the top of the document.

1. I saved the text file as a .xml file, and when I reopened it, it was well-formed! Success!
