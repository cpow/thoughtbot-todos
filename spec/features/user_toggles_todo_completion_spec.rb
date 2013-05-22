require 'spec_helper'

feature 'User toggles todo completion' do
  scenario 'marks as complete' do
    todo = create :todo, title: 'To be completed', owner_email: 'person@example.com'
    sign_in_as 'person@example.com'

    todo_on_page = TodoOnPage.new(todo)
    expect(todo_on_page).not_to have_incomplete_link
    todo_on_page.mark_complete
    expect(todo_on_page).to be_complete
    expect(todo_on_page).not_to have_complete_link
  end

  scenario 'marks as incomplete' do
    todo = create :todo, title: 'To be completed', owner_email: 'person@example.com'
    sign_in_as 'person@example.com'

    todo_on_page = TodoOnPage.new(todo)
    todo_on_page.mark_complete
    todo_on_page.mark_incomplete
    expect(todo_on_page).to be_incomplete
  end


  class TodoOnPage
    include Capybara::DSL

    def initialize(todo)
      @todo = todo
    end

    def has_incomplete_link?
      todo_on_page.has_css? 'a', text: 'Incomplete'
    end

    def has_complete_link?
      todo_on_page.has_css? 'a', text: 'Complete'
    end

    def mark_complete
      todo_on_page.click_on 'Complete'
    end

    def mark_incomplete
      todo_on_page.click_on 'Incomplete'
    end

    def complete?
      todo_on_page['data-state'] == 'complete'
    end

    def incomplete?
      todo_on_page['data-state'] == 'incomplete'
    end

    private

    def todo_on_page
      find("[data-id='#{@todo.id}']")
    end
  end

end
