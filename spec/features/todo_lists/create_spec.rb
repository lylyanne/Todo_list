require 'spec_helper'

describe "Creating todo lists"  do
	it "redirects to the todo list index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(page).to have_content("My todo list")
	end

	it "displays error when the to do list has no title" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end


	it "displays error when the to do list is too short" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "Short todo list"
		fill_in "Description", with: "hi"
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("hi")
	end
end