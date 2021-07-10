

You can download Ghostscript here (get the 64-bit version):
https://www.ghostscript.com/download/gsdnld.html




Alternative:
"D:\Program Files\gs\gs9.53.3\bin\gswin64c.exe" -dNOPAUSE -sDEVICE=jpeg -r96 -dJPEGQ=92 -sOutputFile=s%03d.jpg a.pdf -dBATCH

gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m -r300 \
                -sOutputFile=tiger_300.png tiger.eps


# Compress PDF With Ghostscript On Windows
set PATH=%PATH%;D:\Program Files\gs\gs9.53.3\bin;D:\Program Files\gs\gs9.53.3\lib
"D:\Program Files\gs\gs9.53.3\lib\ps2pdf.bat" -dPDFSETTINGS#/ebook C:\path\to\input\file.pdf c:\path\to\output\file.pdf


