# LaTeXmk configuration file
# Set LuaLaTeX as the default compiler
$pdf_mode = 4;  # Use LuaLaTeX
$lualatex = 'lualatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# Add Inkscape to PATH on Windows only (avoid breaking PATH on Linux/macOS)
if ($^O eq 'MSWin32') {
	$ENV{'PATH'} = $ENV{'PATH'} . ';C:\\Program Files\\Inkscape\\bin';
}

# Set output directory
$out_dir = './out_dir';

# Clean up auxiliary files
$clean_ext = "synctex.gz nav snm vrb";

# Disable continuous mode and PDF viewer
$preview_continuous_mode = 0;
$pdf_previewer = 'none';
