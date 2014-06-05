require 'spec_helper'

describe "Creating todo lists"  do
	def create_todo_list(options = {})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is what I'm doing today."

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do
		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "displays error when the to do list has no title" do
		expect(TodoList.count).to eq(0)
		create_todo_list(title:"")

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays error when the title is too short (< 3 chars)" do
		expect(TodoList.count).to eq(0)
		create_todo_list(title:"Hi")

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays error when the to do list is blank" do
		expect(TodoList.count).to eq(0)
		create_todo_list(description:"")

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list")
	end

	it "displays error when the description is too short (< 5 chars)" do
		expect(TodoList.count).to eq(0)
		create_todo_list(description:"Food")

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("Food")
	end
end