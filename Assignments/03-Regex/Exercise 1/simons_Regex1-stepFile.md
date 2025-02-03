# Regex Steps for Converting Movie Data From a tab-separated text file to XML

*Before beginning, think about how to do these assignments. It might be helpful to run a separate (free) Markdown editor to keep
your step recording in a different software window than oXygen, where you'll be writing your Find and Replace operations.
You want to be able to copy and paste your expressions into your markdown file to record them. 
I'm going to use Macdown (a nice markdown editor for Mac). Windows has Typora or reMarkable, etc.*


First step is ALWAYS to search for characters that will disrupt XML encoding: 
`&`, `<`, `>`. 
XML is not allowed to contain raw ampersand characters `&`. 
So I needed to find:

```
&
```
and replace with the special escape characters for ampersands:
```
&amp;
```
I searched for `<` and `>` and did not find them. 


Moving on, we can begin the "autotagging" find and replace process.
I wanted to wrap elements around whole lines. 

I used the following expression to find. 
I made sure that *dot matches all* was NOT set so that
the dot matches on any character but only inside each line. 
This expression matches on the beginning of each line, 
and *one ore more characters on that line*.

```
^.+
```
I set this to replace:
```
<movie>\0</movie>
```

Second step I matched this and set capturing groups so I could tag the titles:

Find: 
```
(<movie>)(.+?)(\t)
```



I set this to replace, so I could keep the first tag, and then add a new pair of tags for the title elements:
```
\1<title>\2</title>\3
```
At the very end of class, I manually set a root element around the entire document 
```
<xml>
   <movie>...</movie>
   <movie>....</movie>
    <!--yada yada yada more code -->   
</xml>
```

**My work begins here:**

I started with the year:

```
Find: (\t)(\d{4})
Replace: \1<year>\2</year>
```

Country:

```
Find: (</year>)(\t)(.+?)(\t)
Replace: \1\2<country>\3</country>\4
```

Run Time (which I simply dropped the "min" text by not using its capture group in the replace function):

```
Find: (</country>)(\t)(\d+)(.+?)(</movie>)
Replace: \1\2<runTime unit="min">\3</runTime>\5
```

Here I started to clean up the document for easily readable XML:

```
Find: \t
Replace: \n\t
```
Here, I noticed that some of the run times were "N/A" which my previous expression neglected, so using the current formatting (the N/A's I was looking for were all followed by tabs), I wrapped them in runTime elements as well:

```
Find: (\t)(N/A)
Replace: \1<runTime>\2</runTime>
```

More cleaning up:

```
Find: (</runTime>)(</movie>)
Replace: \1\n\2
```

Indenting everything (which could've been done other ways, but why not with regex):

```
Find: \n
Replace: \n\t
```

Finally, I cleaned up the beginning and end xml tag formatting manually.

And I saved the file as simons_movieData.xml.
And I closed it.
And I opened my new simons_movieData.xml and saw that I had a green square in oXygen, indicating 
that the document is well-formed. Yay!
