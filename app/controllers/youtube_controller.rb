class YoutubeController < ApplicationController
  GOOGLE_API_KEY = "AIzaSyBKRe4-GEaVFZpnruLxRUge0vc23nhaWNE"
  #Rails.application.credentials.google[:api_key]
  @@max_results = 3
  def find_videos(keyword,sorting,  before: Time.now)
    #require 'google/apis/youtube_v3'
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    oder = "relevance"
    case sorting
    when "1"
      oder = 'relevance'
    when "2"
      oder = 'date'
    when "3"
      oder = 'viewCount'
    when "4"
      oder = 'rating'
    end
    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: @@max_results,
      order: oder,
      page_token: next_page_token,
      published_after: (5.years + 2000.days).ago.iso8601,
      published_before: before.iso8601
    }
    results = service.list_searches(:snippet, opt)
  end

  def find_video_id(youtube_data)
    results_items = youtube_data.to_h
    videos = []

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

    @@max_results.times do |timesCount|
      video_cnt_get = service.list_videos(:statistics, id: youtube_data_video_id[timesCount])
      video_cnt_get_h = video_cnt_get.to_h
      count_videos << video_cnt_get_h
    end

    return count_videos

  end

  def search
    @youtube_data = find_videos(params[:keyword],params[:sorting])
    @youtube_data_video_id = find_video_id(@youtube_data)
    @youtube_data_count = count_videos(@youtube_data_video_id)
    @max_results = @@max_results
    @test = params[:keyword],params[:sorting],params[:after_date],params[:before_date]
  end

  def index
    @max_results = @@max_results
  end

end