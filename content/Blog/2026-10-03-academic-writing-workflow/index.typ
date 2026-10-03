#import "../index.typ": template, tufted
#import "../../_data/posts.typ": post-tags
#show: template.with(title: "My academic-writing workflow", lang: "en", date: datetime(year: 2026, month: 10, day: 3))

= My academic-writing workflow

#post-tags("/Blog/2026-10-03-academic-writing-workflow/")

I write every paper as one plain-text `.qmd` file. The same file renders to an APA-formatted Word document for co-authors, to a PDF for preprints, and to LaTeX when a journal wants LaTeX source. I have not opened Word to _write_ a paper in a long time. This post explains the setup and why I think it beats Word for quantitative work.

== The stack

#tufted.margin-note[
  #link("https://quarto.org")[Quarto] \
  #link("https://github.com/wjschne/apaquarto")[apaquarto] by W. Joel Schneider \
  #link("https://retorque.re/zotero-better-bibtex/")[Better BibTeX] for Zotero
]

- *Quarto*: one source file, many outputs (`docx`, `pdf`, `html`, LaTeX).
- *apaquarto*: a Quarto extension that takes care of APA 7: title page, running head, heading levels, table and figure notes, reference list.
- *R chunks* inside the same file for every analysis, table and figure.
- *Zotero + Better BibTeX* to keep a `references.bib` in sync with my library.
- *Git* for history.

The top of a paper looks like this:

```yaml
---
title: "Belief-driven or structure-determined?"
bibliography: references.bib
format:
  apaquarto-docx: default
  apaquarto-pdf:
    keep-tex: true
---
```

One `quarto render` gives me both the Word file and the PDF, and `keep-tex: true` leaves the `.tex` file next to the PDF.

== From qmd to LaTeX for submission

Some journals want LaTeX source at submission or after acceptance. Because Quarto goes through Pandoc and LaTeX anyway, the `.tex` file is a by-product, not a second version of the paper that I have to maintain. If the journal has its own LaTeX class, I change the `format:` block to that template and render again. The text, citations and analysis code do not change.

== Why not Word

=== The numbers update themselves

In Word, I would copy $beta = 0.42$ from the R console into the text. Then a reviewer asks me to drop twelve participants, and I have to find and retype every number in the paper, hoping I did not miss one in the abstract. In a `.qmd` file the numbers come from the model:

````markdown
The effect of belief on practice was small
(β = `r fmt(b_belief)`, 95% CrI [`r fmt(lo)`, `r fmt(hi)`]).
````

Refit the model, render, done. The text cannot disagree with the analysis.

=== Tables and figures renumber themselves

"Please move Table 3 to the appendix." In Word this means renumbering every later table and every "see Table 4" in the text. In Quarto I refer to tables by label (`@tbl-icc`), so the numbers follow wherever the table goes.

=== Changing citation style is one line

A paper rejected from an APA journal often goes next to a journal with a numeric or author-year style of its own. With a `.bib` file and a CSL style, that is one line in the header (`csl: springer-basic.csl`). The Zotero plugin for Word can do this too, but it breaks easily once a co-author without Zotero edits the file.

=== Revisions are diffable

Plain text works with Git, so `git diff` shows exactly what changed between the submitted version and the revision. That makes the response-to-reviewers letter much easier to write. When a journal asks for a "tracked changes" version, I run `latexdiff` on the two `.tex` files instead of reconstructing the changes by hand.#tufted.margin-note[#link("https://ctan.org/pkg/latexdiff")[latexdiff] marks deletions and insertions between two `.tex` files, much like Word's track changes.]

=== Formatting is not my job any more

Double spacing, running head, title page, where the table notes go: apaquarto handles all of it. I spend my time on the argument instead of on the ruler.

== Where it still hurts

- *Co-authors who live in Word.* I send them the rendered `.docx`, they comment and track changes, and I move their edits back into the `.qmd` by hand. This is the main cost of the workflow.
- *Fine-tuning Word output.* Some table layouts are easier to get right in PDF than in `.docx`.
- *The learning curve.* For a single short essay with no data, Word is still faster.

For papers with real analysis, though, I would not go back.
