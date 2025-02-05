## Regex 2: Lots of sonnets

1. Cut the top and bottom from Project Gutenberg out as not relevant / worth keeping here. 

2. Analyze the spacing in the document. Remove extra spaces at start of lines (how many?)

	```
	Find: ^\s\s
	Replace: NOTHING! :) This trims off the extra spaces.
	```

3. Run that again for the last two lines of each sonnet which still have two spaces at the beginning of the line.

	```
	Find: ^\s\s
	Replace: NOTHING!
	```

4. Now, there is still a single space at the beginning of ***some*** of the roman numerals and what looks to be all of the first lines of the sonnets. I was considering leaving these here to help identify them, but since they're inconsistent, I'm going to remove them also.

	```
	Find: ^\s
	Replace: NOTHING!
	```
	
5. Before continuing, I searched for the special characters XML wouldn't like (`&`, `<`, `>`), but there weren't any of them in the document.
6. I'm choosing to work inside-out because that's just how I intuitively thought about it.
7. I'm going to wrap everything in a line just to keep this step simple. 

	```
	Find (with "Dot matches all" UNCHECKED): .+
	Replace: <line>\0</line>
	```
	
8. Finding the Roman numeral lines was slightly more involved. Using just `[IVXLC]+` returned extra results because some lines started with `If...` or other matching expressions. But, adding the `line` start and end tags to the search ensured that the line contained only something from the character class, and then immediately the line ended. There were 154 results and the last Roman numeral was 154, so I think it worked!

	To successfully use replace, I then used capture groups in the Find expression. I'll only be using `\2` because I don't want the `<line>` tags anymore. With this replace, I'm going to do a lot. I'm going to create the closing tag for the sonnets, and then the opening tags, using the Roman numeral as an @number attribute. I'm also doing some formatting by adding tabs and a newline. *(This XML will be very neat and would probably "pretty-print" very nicely, but for the purpose of practicing with Regex, I'm doing all the formatting here)*

	```
	Find: (<line>)([IVXLC]+)(</line>)
	Replace: \t</sonnet>\n\t<sonnet number="\2">
	```
	
9. Almost done! Just going to do a little more formatting with the lines:

	```
	Find: <line>
	Replace: \t\t\0
	```
	
10. Finally, some finishing clean up: fixing up the title and author at the beginning of the document, deleting the closing `</sonnet>` tag that my expression created before the first sonnet (a small price to pay for keeping that expression simple and concise), and similarly, adding that closing `</sonnet>` tag to the end of the document for the last sonnet. And of course, I added a root element, which I could've done by finding `.+` with "Dot matches all" checked, but I did that and got scared, so I did it by hand.
11. I saved the text file as a .xml file, and when I reopened it, it was well-formed! Success!