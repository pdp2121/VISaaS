

Given /^I choose (.+)$/ do |feat|
  visit "/#{feat}"
end

When /^I enter the filter "(.+)" for (.+) data$/ do |filter, dataset|
  if dataset == "weather"
    fill_in("cityname", with: filter)
  end
  click_button("Submit")
end

When /^I click "(.+)"$/ do |button|
  click_button(button)
end

When /^I download the data$/ do
  click_button("Acknowledged")
end

Given /^I visualize (.+) data$/ do |dataset|
  if dataset == "weather"
    visit "/#{dataset}/forecast"
  end
end

When /^I return to the home page$/ do 
  visit "/"
end

Then /^(.+) should be downloaded$/ do |filename|
  page.response_headers['Content-Disposition'].should include("filename=#{filename}")
end

Given /^I go to plot my own data$/ do
  visit "/upload"
end

When /^I upload my own valid csv$/ do
  attach_file(:file, File.join(__dir__, "files/data.csv"))
  click_button("Import")
end

When /^I create a "(.+)" plot type$/ do |plot|
  page.find(:option, plot).select_option
  click_button("Create Chart from Labels")
end

When /^I select "(.+)" and "(.+)" as the variables of interest$/ do |col1, col2|
  select(col1, from: 'column1')
  select(col2, from: 'column2')
  click_button("Create Chart from Labels")
end

When /^I enter "(.+)" as a query$/ do |query|
  fill_in("query", with: query)
  click_button("Create Chart from Query")
end

# from Codio rottenpotatoes assignment

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end
