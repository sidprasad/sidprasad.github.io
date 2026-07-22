# CV source

The CV's content is shared by the website and the PDF:

- Edit personal, education, employment, teaching, service, and affiliation data
  in `../_data/cv.yml`.
- Edit publication details in `../_data/publications.yml`; the `publications`
  list in `cv.yml` selects and orders the entries shown on the CV.
- Edit the PDF layout in `cv.typ` and the web layout in `../cv.md`.

Build `../cv.pdf` with:

```sh
make
```

This requires Typst 0.14.2 or newer. If TeX's XCharter font is installed, the
Makefile finds it through `kpsewhich`; otherwise Typst falls back to a system
Charter-compatible serif.
