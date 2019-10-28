import sys
import locale
import ghostscript

args = [
    "ps2pdf", # actual value doesn't matter
    "-dNOPAUSE", "-dBATCH", "-dSAFER",
    "-sDEVICE=txtwrite",
    "-sOutputFile=" + sys.argv[1],
    "-c", ".setpdfwrite",
    "-f",  sys.argv[2]
    ]

# arguments have to be bytes, encode them
encoding = locale.getpreferredencoding()
args = [a.encode(encoding) for a in args]

ghostscript.Ghostscript(*args)