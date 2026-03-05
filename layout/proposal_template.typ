#import "/layout/titlepage.typ": *
#import "/utils/print_page_break.typ": *
#import "/layout/fonts.typ": *

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let proposal(
  title: "",
  titleGerman: "",
  degree: "",
  program: "",
  examiner: "",
  supervisors: (),
  author: "",
  startDate: datetime,
  submissionDate: datetime,
  is_print: false,
  body,
) = {
  titlepage(
    title: title,
    titleGerman: titleGerman,
    degree: degree,
    program: program,
    examiner: examiner,
    supervisors: supervisors,
    author: author,
    startDate: startDate,
    submissionDate: submissionDate
  )

  print_page_break(print: is_print)

  // Set the document's basic properties.
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "1",
    number-align: center,
  )

  // Set body font family.
  set text(
    font: fonts.body, 
    size: 12pt, 
    lang: "en"
  )

  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: fonts.body)
  set heading(numbering: "1.1")

  // --- Paragraphs ---
  let firstParagraphIndent = 1.45em
  show heading: it => {
    it
    h(firstParagraphIndent)
  }
  set par(leading: 1em, justify: true, first-line-indent: 2em)

  // --- Citation Style ---
  set cite(style: "ieee")

  // --- Figures ---
  show figure: set text(size: 0.85em)

  body

  pagebreak()
  bibliography("/thesis.yml")
  pagebreak()
}
