
feature '.create' do
  scenario "Adds websites to the bookmarks database" do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    visit '/bookmarks'
    fill_in('url', with: 'https://tfl.gov.uk/')
    fill_in('title', with: 'TFL')
    click_button 'Add Bookmark'
    expect(page).to have_link('TFL', href: 'https://tfl.gov.uk/')
  end

  scenario 'The bookmark must be a valid URL' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    visit('/bookmarks')
    fill_in('title', with: 'not a real bookmark')
    fill_in('url', with: 'not a real bookmark')
    click_button('Add Bookmark')
    expect(page).not_to have_content "not a real bookmark"
    expect(page).to have_content "You must submit a valid URL."
  end
end
