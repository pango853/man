

pdftk file1.pdf file2.pdf cat output output.pdf

convert sub1.pdf sub2.pdf sub3.pdf merged.pdf
qpdf --empty --pages file1.pdf file2.pdf -- merged.pdf
pdftools --input-file file1.pdf --input-file file2.pdf --output output.pdf
