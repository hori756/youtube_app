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
      max_results: 1,
      order: :date,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    service.list_searches(:snippet, opt)
  end
  def search
    if !params[:keyword].blank?
        require 'google/apis/youtube_v3'
        youtube = Google::Apis::YoutubeV3::YouTubeService.new
        youtube.key = GOOGLE_API_KEY
        youtube_search_list = youtube.list_searches("id,snippet", type: "video",
                                                                q: params[:keyword],
                                                                max_results: 1)
        search_result = youtube_search_list.to_h
        @movies = search_result[:items]
        if !@movies.nil?
            respond_to do |format|
                format.html { render 'youtube'}
                format.js
            end
        else
            flash[:warning] = "検索結果はありません"
            respond_to do |format|
                format.html { render 'youtube'}
                format.js
            end
        end
    else 
        flash.now[:warning] = "検索に空白は使えません"
        respond_to do |format|
            format.html { render 'youtube'}
            format.js
        end
    end
end
  def index
    @youtube_data = find_videos('スポーツ')
  end
end