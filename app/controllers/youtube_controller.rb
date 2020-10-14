class YoutubeController < ApplicationController
  before_action :move_to_index, except: [:index]
  GOOGLE_API_KEY = "AIzaSyBKRe4-GEaVFZpnruLxRUge0vc23nhaWNE"
  #Rails.application.credentials.google[:api_key]
  @@max_results = 3
  def find_videos(keyword ,sorting ,after_date_years ,after_date_months ,after_date_days ,before_date_years ,before_date_months ,before_date_days)
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
      #published_after: (5.years + 2000.days).ago.iso8601,
      published_after: after_date_years+"-"+after_date_months+"-"+after_date_days+"T00:00:00Z",
      published_before: before_date_years+"-"+before_date_months+"-"+before_date_days+"T00:00:00Z",
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
    @youtube_data = find_videos(params[:keyword],params[:sorting],params["after_date(1i)"],params["after_date(2i)"],params["after_date(3i)"],params["before_date(1i)"],params["before_date(2i)"],params["before_date(3i)"])
    @youtube_data_video_id = find_video_id(@youtube_data)
    @youtube_data_count = count_videos(@youtube_data_video_id)
    @max_results = @@max_results
    @test = params[:keyword],params[:sorting],params["after_date(1i)"],params[:after_date],params[:before_date]

  end

  def index
    @max_results = @@max_results
  end

  private 
  def move_to_index
    redirect_to user_session_path unless user_signed_in?
  end
end