class YoutubeController < ApplicationController
  GOOGLE_API_KEY = "AIzaSyDBquVrXQZ--j7h6kMUVgtM_LziXr3HunY"
  #Rails.application.credentials.google[:api_key]

  def find_videos(keyword, after: 10.months.ago, before: Time.now)
    #require 'google/apis/youtube_v3'
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 2,
      order: :viewCount,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    results = service.list_searches(:snippet, opt)
    
    #@video_title = response[:items][0][:snippet][:title]
    #video_id = response[:items][0][:id][:videoId]
  end

  def count_videos(youtube_data)

    results_items = youtube_data.to_h

    video = results_items[:items][0][:id][:video_id]
    video2 = results_items[:items][1][:id][:video_id]
    videos = []
    videos << video
    videos << video2

      #video_cnt_get = service.list_videos(:statistics, id: video_id)
      #video_cnt_get_h = video_cnt_get.to_h  

  end

  def count_videos2(youtube_data_count)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    num=9
    video_cnt_get = service.list_videos(:statistics, id: youtube_data_count[0])
    video_cnt_get_h = video_cnt_get.to_h
      #video_cnt_get = service.list_videos(:statistics, id: video_id)
      #video_cnt_get_h = video_cnt_get.to_h  

  end

  def search
    @youtube_data = find_videos(params[:keyword])
    @youtube_data_count = count_videos(@youtube_data)
    @youtube_data_count2 = count_videos2(@youtube_data_count)

  end
  def index
    
  end
end