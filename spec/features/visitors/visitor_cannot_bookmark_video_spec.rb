require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "#can't bookmark videos" do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_content("You must login before bookmark videos.")
  end

end