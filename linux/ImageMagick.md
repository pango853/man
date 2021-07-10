

convert -density 150 $(ls -rt *pdf) output.pdf


# Multi-page PDF to PNG

convert -density 300 -depth 8 -quality 85 a.pdf output-%d.png.png

convert.exe -density 300 file.pdf -scale 825x1125 .\test\output-%d.png
magick.exe -density 300 file.pdf -resize 825x1125 .\test\output-%d.png


Alternative:
"D:\Program Files\gs\gs9.53.3\bin\gswin64c.exe" -dNOPAUSE -sDEVICE=jpeg -r96 -dJPEGQ=92 -sOutputFile=s%03d.jpg a.pdf -dBATCH

gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m -r300 \
                -sOutputFile=tiger_300.png tiger.eps
