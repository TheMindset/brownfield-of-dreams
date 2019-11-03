# frozen_string_literal: true

class Bookmark
  attr_reader :tutorial, :videos

  def initialize(tutorial, videos)
    @tutorial = tutorial
    @videos = videos
  end
end
