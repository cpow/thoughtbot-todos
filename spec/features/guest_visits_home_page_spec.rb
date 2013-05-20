require 'spec_helper'

feature 'Guest visits home page' do
  scenario 'learns about the application and its goals' do
    visit root_path
    within 'header' do
      expect(page).to have_css '[data-role="title"]', text: 'Todos'
    end
    expect(page).to have_css '[data-role="description"]'
  end
end
