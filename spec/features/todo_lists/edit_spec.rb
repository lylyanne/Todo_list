require 'spec_helper'

describe "Editing todo lists" do 
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "Milk and Honey")}

	def update_todo_list(options = {})
		options[:title] ||= "Groceries"
		options[:description] ||= "Milk and Honey"

		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
	end

	it "updates a todo list successfully with correct info" do
		

		update_todo_list(todo_list: todo_list, title: "Safeway Groceries", description: "Bread and butter")

		#we're looking for the representation of todo list, which is currently in memory. 
		#And we've updated it in the database
		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated.")
		expect(todo_list.title).to eq("Safeway Groceries")
		expect(todo_list.description).to eq("Bread and butter")
	end	

	it "displays an error with no title" do
		update_todo_list(todo_list: todo_list, title: "", description: "Bread and butter")
		expect(page).to have_content("error")
		expect(todo_list.title).to_not eq("")
	end

	it "displays an error with too short of a title" do
		update_todo_list(todo_list: todo_list, title: "SG", description: "Bread and butter")
		expect(page).to have_content("error")
		expect(todo_list.title).to_not eq("SG")
	end

	it "displays an error with no description" do
		update_todo_list(todo_list: todo_list, title: "Safeway Groceries", description: "")
		expect(page).to have_content("error")
		expect(todo_list.description).to_not eq("")
	end

	it "displays an error with too short of a description" do
		update_todo_list(todo_list: todo_list, title: "Safeway Groceries", description: "Egg")
		expect(page).to have_content("error")
		expect(todo_list.title).to_not eq("Egg")
	end
end