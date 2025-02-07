## Regex 3: The Blithedale Romance

1. Cut out the top and bottom from *The Blithedale Romance* as it's not relevant / worth keeping here.

1. Find and replace any of XML's reserved characters (`&`, `<`, `>`). (There were none, so Dr. B lied!!). If there were any, replace them with (`&amp;`, `&lt;`, `&gt;`)

1. Remove extra blank lines.

	```
	Find: (\n){3,}
	Replace: \n\n
	```

1. Wrap each section in `<p>` tags. Add an additional closing tag to the last line of the book.

	```
	Find: \n\n
	Replace: </p>\n<p>
	```

1. Use expressions to wrap the chapter titles in a `<title>` element. Make sure "Dot matches all" is checked.

	```
	Find: (<p>)([IVX]+\.\s+.+?)(</p>)
	Replace: <title>\2</title>
	```
	
1. Use a similar expression to wrap the chapter titles in the table of contents in `<title>` elements as well (after manually removing the `<p>` and `</p>` that were enclosing all of the titles in the TOC). Make sure "Dot matches all" is still checked.

	```
	Find: (\s+)([IVX]+\.)(\s\s)(.+)$
	Replace: \n<title>\2 \4</title>
	```
	
1. Uncheck "Dot matches all". Now, enclose the chapters in `<chapter>` tags. Remove the extra closing `</chapter>` tag from the beginning of the first chapter and put it at the very end of the document to close the last chapter.

	```
	Find: <title>.+</title>\n<p>
	Replace: </chapter>\n<chapter>\n\0
	```
	
1. Find all the quotes in the book, and replace them with `<quote>` tags.

	```
	Find: "(.+?)"
	Replace: <quote>\1</quote>
	```
		
1. Finally, some finishing clean up: fixing up and tagging the book title and author at the beginning of the document, and wrapping the table of contents in its own element and including a heading for it. And of course, I added a root element, which I could've done by finding `.+` with "Dot matches all" checked, but I did that and got scared, so I did it by hand.

1. I saved the text file as a .xml file, and when I reopened it, it was well-formed! Success! I also used pretty-print on it to make it more readable to a human.
