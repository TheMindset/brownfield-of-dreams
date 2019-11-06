require 'rails_helper'

describe "As a user", :vcr do

  before :each do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path
    click_on "Send an invitation"

    expect(current_path).to eq(send_invitation_path)
  end

  it "#can send an invitation with valid github_nickname" do
    @user.user_credentials.create!(token: ENV["GITHUB-API-KEY"], nickname: "TheMindset", website: "github")

    fill_in "github_nickname", with: "TheMindset"
    click_on "Send the invitation"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("The user you selected doesn't have an email associated with their account.")
  end

  it "#can't send an invitation without valid github_nickname" do
    @user.user_credentials.create!(token: ENV["GITHUB-API-KEY"], nickname: "TheMindset", website: "github")

    fill_in "github_nickname", with: "dzescgr"
    click_on "Send the invitation"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Github user not found")
    expect(page).to_not have_content("Successfully sent the invitation!")
    expect(page).to_not have_content("The user you selected doesn't have an email associated with their account.")
  end

  it "cannot send if not logged in to github" do
    fill_in "github_nickname", with: "TheMindset"
    click_on "Send the invitation"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("You must be connected to Github to invite new users.")
    expect(page).to_not have_content("The user you selected doesn't have an email associated with their account.")
    expect(page).to_not have_content("Successfully sent invitation!")
  end

end