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

	it "displays error when the title is too short (< 3 chars)" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "hi"
		fill_in "Description", with: "I need to go to grocery store."
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("I need to go to grocery store.")
	end

	it "displays error when the to do list is blank" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "Short todo list"
		fill_in "Description", with: " "
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("Short todo list")
	end

	it "displays error when the description is too short (< 5 chars)" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "Grocery list"
		fill_in "Description", with: "Food"
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("Food")
	end
end