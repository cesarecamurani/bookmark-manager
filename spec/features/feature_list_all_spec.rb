
feature '.list_all' do
  scenario "It shows a list of saved websites" do
    Bookmark.create(url: "http://www.makersacademy.com", title: "Makers")
    Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy")
    Bookmark.create(url: "https://www.visitfaroeislands.com", title: "Visit Faroe")
    Bookmark.create(url: "https://store.steampowered.com", title: "Steam")
    visit '/bookmarks'
    expect(page).to have_content("Bookmarks:")
    expect(page).to have_link("Makers", href: "http://www.makersacademy.com")
    expect(page).to have_link("Destroy", href: "http://www.destroyallsoftware.com")
    expect(page).to have_link("Visit Faroe", href: "https://www.visitfaroeislands.com")
    expect(page).to have_link("Steam", href: "https://store.steampowered.com")
  end
end

  
