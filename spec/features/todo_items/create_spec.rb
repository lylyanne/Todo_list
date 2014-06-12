require 'spec_helper'

describe "Creating todo items" do
	let!(:todo_list) {TodoList.create(title: "Groceries", description: "Tissue paper and towel") }

	def visit_todo_list(list) 
		visit '/todo_lists'
		within "#todo_list_#{list.id}" do
			click_link "List Items"	
		end
	end

	def update_todo_item(content="Milk")
		click_link "New Todo Item"
		fill_in "Content", with: content
		click_button "Save"
	end

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		update_todo_item
		expect(page).to have_content("Added todo list item.")
		within "ul.todo_items" do
			expect(page).to have_content("Milk")
		end
	end

	it "displays an error with no content" do
		visit_todo_list(todo_list)
		update_todo_item("")
		within "div.flash" do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content("Content can't be blank")
	end

	it "displays an error if content is less than 3 characters" do
		visit_todo_list(todo_list)
		update_todo_item("eg")
		within "div.flash" do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content("Content is too short")
	end
end
