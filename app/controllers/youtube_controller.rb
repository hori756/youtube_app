class YoutubeController < ApplicationController
  GOOGLE_API_KEY = "AIzaSyCwR0JztvWLQncwUInVRQX_dP8zHM-22Qs"
  #Rails.application.credentials.google[:api_key]

  def find_videos(keyword, after: 1.months.ago, before: Time.now)
    #require 'google/apis/youtube_v3'
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 2,
      order: :date,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    service.list_searches(:snippet, opt)
  end

  def index
    @youtube_data = find_videos('アニメ')
  end
end