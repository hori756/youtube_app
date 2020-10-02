class YoutubeController < ApplicationController
  GOOGLE_API_KEY = "AIzaSyCcXytS7jcys5DMjPTonbicSoK6k0eiwY0"
  #Rails.application.credentials.google[:api_key]
  @@max_results = 3
  def find_videos(keyword, after: 100.years.ago, before: Time.now)
    #require 'google/apis/youtube_v3'
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: @@max_results,
      order: :viewCount,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    results = service.list_searches(:snippet, opt)
  end

  def find_video_id(youtube_data,max_results)
    results_items = youtube_data.to_h
    videos = []
    cnt = 2
    @@max_results.times do |timesCount|
      video = results_items[:items][timesCount][:id][:video_id]
      videos << video
    end
    return videos
    
    #video_cnt_get = service.list_videos(:statistics, id: video_id)
      #video_cnt_get_h = video_cnt_get.to_h  
  end

  def count_videos(youtube_data_video_id)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    count_videos=[]

    cnt = 2
    @@max_results.times do |timesCount|
    video_cnt_get = service.list_videos(:statistics, id: youtube_data_video_id[timesCount])
    video_cnt_get_h = video_cnt_get.to_h
    count_videos << video_cnt_get_h
    end
    return count_videos

  end

  def search
    @youtube_data = find_videos(params[:keyword])
    @youtube_data_video_id = find_video_id(@youtube_data,@max_results)
    @youtube_data_count = count_videos(@youtube_data_video_id)
    @max_results
  end
  def index
    @max_results = @@max_results
  end
end