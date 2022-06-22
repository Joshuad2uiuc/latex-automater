require 'fileutils'
require 'yaml'
require 'date'

title = ARGV.first 

#convert title to lowercase 
lowercase_title = title.downcase 

#convert title to hyphenate 
hyphenated_title = lowercase_title.gsub(" ", "-")

# create directory
FileUtils.copy_entry "/Users/robertjgittings/Development/Code/Latex-Automator/latex-automater/default-template", "/Users/robertjgittings/Development/Code/Latex-Automator/latex-automater/#{hyphenated_title}"

#reame main to hyphenated title 
File.rename("/Users/robertjgittings/Development/Code/Latex-Automator/latex-automater/#{hyphenated_title}/main.tex", "/Users/robertjgittings/Development/Code/Latex-Automator/latex-automater/#{hyphenated_title}/#{hyphenated_title}.tex")

#grab and format date 
month = Date::MONTHNAMES[Date.today.month]
year = Date.today.year

#insert title and author into file 
path = "/Users/robertjgittings/Development/Code/Latex-Automator/latex-automater/#{hyphenated_title}/#{hyphenated_title}.tex"

contents = YAML.load_file('config.yml')
author = contents["author"]

text = File.read(path)
text_with_author = text.gsub('\author{Author}', '\author{' + "#{author}}")
text_with_title_author = text_with_author.gsub('\title{Title}', '\title{' + "#{title}}")

text_with_title_author_date = text_with_title_author.gsub('\date{Date}', '\date{' + "#{month} #{year}}")

File.open(path, "w") {|file| file.puts text_with_title_author_date }

