# CV and resume source

The CV and resume content is shared by the website and the PDFs:

- Edit personal, education, employment, teaching, service, and affiliation data
  in `../_data/cv.yml`.
- Edit the resume's selected publications in the `resume` block of
  `../_data/cv.yml`.
- Edit publication details in `../_data/publications.yml`; the `publications`
  list in `cv.yml` selects and orders the entries shown on the CV.
- Edit the PDF layouts in `cv.typ` and `resume.typ`, and the web layout in
  `../cv.md`.

Build both `../cv.pdf` and `../resume.pdf` with:

```sh
make
```

Build only one document with `make cv` or `make resume`.

This requires Typst 0.14.2 or newer. If TeX's XCharter font is installed, the
Makefile finds it through `kpsewhich`; otherwise Typst falls back to a system
Charter-compatible serif.
