## Regex 5: Stoker's Dracula

1. Find and replace any of XML's reserved characters (`&`, `<`, `>`). (There were none). If there were any, replace them with (`&amp;`, `&lt;`, `&gt;`)

1. Remove extra blank lines. There was only one case in this document. Every other paragraph or heading was separated by two newline characters.

	```
	Find: (\n){3,}
	Replace: \n\n
	```

1. Wrap each line in `<p>` tags.

	```
	Find: ^.+$
	Replace: <p>\0</p>
	```

1. Replace `<p>` tags with `<heading>` tags for chapter headings.

	```
	Find: (<p>)(CHAPTER [IVXLCD]+)(</p>)
	Replace: <heading>\2</heading>
	```

1. Add `<chapter>` tags to enclose each chapter and its heading. (The beginning of the chapter is indicated by a heading, and the end of a chapter is indicated by the following chapter's heading). Manually remove the extraneous closing tag from the beginning of the document and add it to the bottom of the document to close the last chapter.

	```
	Find: <heading>
	Replace: </chapter>\n\n<chapter>\n\n\0
	```

1. Add a root element. (select "Dot matches all")

	```
	Find: .+
	Replace: <xml>\n\0\n</xml>
	```
	
1. Manually add `<title>` tags around the title at the beginning of the document.

1. I saved the text file as a .xml file, and when I reopened it, it was well-formed! Success!
