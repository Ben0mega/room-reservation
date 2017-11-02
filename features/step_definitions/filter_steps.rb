require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Then /^(?:|I )should see a submit button "([^"]*)"$/ do |button_name|
    expect(page.body =~ /input type=\"submit\".*value=\"#{button_name}\"/).to be >= 0
end