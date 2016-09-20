desc "Generate API documation to public/index.html"
task :docs do
  system "aglio -i INTERFACE.apib -o public/index.html"
end
