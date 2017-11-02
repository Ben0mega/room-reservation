
Given /the following buildings exist/ do |buildings_table|
  buildings_table.hashes.each do |building|
    Building.create! building
  end
end

Given /the following rooms exist/ do |rooms_table|
    rooms_table.hashes.each do |room|
        Room.create! room
    end
end

When /^I click on room "(.*)"$/ do |room|
   click_button(room) 
end

When /^I click on building "(.*)"$/ do |building|
    visit building_path(Building.find_by(:name => building).id)
end

Then /^I should see room "(.*)"$/ do |room|
    step "I should see \"#{room}\""
end

Then /^I should not see room "(.*)"$/ do |room|
    step "I should not see \"#{room}\""
end

Then /^I should see "(.*)" to be "(.*)"$/ do |category, value|
    step "I should see \"#{category}: #{value}\""
end

Then /^I should see "(.*)" under "(.*)"$/ do |value, category|
    expect(page.body).to match /#{category}: [^:]*#{value}/m
end


