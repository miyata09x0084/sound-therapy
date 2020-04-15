class EmotionsController < ApplicationController

  def index
    @angerWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:anger)
    @contemptWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:contempt)
    @disgustWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:disgust)
    @fearWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:fear)
    @happinesstWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:happiness)
    @neutralWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:neutral)
    @sadnessWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:sadness)
    @surpriseWeek = Emotion.where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:surprise)
    @angerWeek_ave = @angerWeek.inject(:+) / @angerWeek.length
    @contemptWeek_ave = @contemptWeek.inject(:+) / @contemptWeek.length
    @disgustWeek_ave = @disgustWeek.inject(:+) / @disgustWeek.length
    @fearWeek_ave = @fearWeek.inject(:+) / @fearWeek.length
    @happinesstWeek_ave = @happinesstWeek.inject(:+) / @happinesstWeek.length
    @neutralWeek_ave = @neutralWeek.inject(:+) / @neutralWeek.length
    @sadnessWeek_ave = @sadnessWeek.inject(:+) / @sadnessWeek.length
    @surpriseWeek_ave = @surpriseWeek.inject(:+) / @surpriseWeek.length
    @chartData_week = [@angerWeek_ave, @contemptWeek_ave, @disgustWeek_ave, @fearWeek_ave, @happinesstWeek_ave, @neutralWeek_ave, @sadnessWeek_ave, @surpriseWeek_ave]
    gon.chartData_week = @chartData_week

    @angerMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:anger)
    @contemptMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:contempt)
    @disgustMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:disgust)
    @fearMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:fear)
    @happinesstMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:happiness)
    @neutralMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:neutral)
    @sadnessMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:sadness)
    @surpriseMonth = Emotion.where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day, "user_id": current_user.id).pluck(:surprise)
    @angerMonth_ave = @angerMonth.inject(:+) / @angerMonth.length
    @contemptMonth_ave = @contemptMonth.inject(:+) / @contemptMonth.length
    @disgustMonth_ave = @disgustMonth.inject(:+) / @disgustMonth.length
    @fearMonth_ave = @fearMonth.inject(:+) / @fearMonth.length
    @happinesstMonth_ave = @happinesstMonth.inject(:+) / @happinesstMonth.length
    @neutralMonth_ave = @neutralMonth.inject(:+) / @neutralMonth.length
    @sadnessMonth_ave = @sadnessMonth.inject(:+) / @sadnessMonth.length
    @surpriseMonth_ave = @surpriseMonth.inject(:+) / @surpriseMonth.length
    @chartData_month = [@angerMonth_ave, @contemptMonth_ave, @disgustMonth_ave, @fearMonth_ave, @happinesstMonth_ave, @neutralMonth_ave, @sadnessMonth_ave, @surpriseMonth_ave]
    gon.chartData_month = @chartData_month
  end

  def show
    @emotion = Emotion.last
    @chartData = [@emotion.anger ,@emotion.contempt ,@emotion.disgust ,@emotion.fear ,@emotion.happiness ,@emotion.neutral ,@emotion.sadness ,@emotion.surprise ]

    gon.chartData = @chartData
  end

  def new
      @emotion = Emotion.new
  end

  def result
    if user_signed_in?
      require 'net/http'

      # replace <My Endpoint String> in the URL below with the string from your endpoint.
      uri = URI('https://japaneast.api.cognitive.microsoft.com/face/v1.0/detect')
      uri.query = URI.encode_www_form({
          # Request parameters
          'returnFaceId' => 'true',
          # 'returnFaceLandmarks' => 'false',
          'returnFaceAttributes' => 'emotion'
      })

      request = Net::HTTP::Post.new(uri.request_uri)

      # Request headers
      # Replace <Subscription Key> with your valid subscription key.
      request['Ocp-Apim-Subscription-Key'] = ENV['Subscription_Key']
      request['Content-Type'] = 'application/json'
      
      imageUri = params[:url]
      request.body = "{\"url\": \"" + imageUri + "\"}"

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(request)
      end
      
      res = JSON.parse(response.body)
      # binding.pry

      if res[0].present?
        emoData = res[0]["faceAttributes"]["emotion"]
        @anger = emoData["anger"]
        @contempt = emoData["contempt"]
        @disgust = emoData["disgust"]
        @fear = emoData["fear"]
        @happiness = emoData["happiness"]
        @neutral = emoData["neutral"] 
        @sadness = emoData["sadness"]
        @surprise = emoData["surprise"]
        @emotion = Emotion.create!(anger: @anger, contempt: @contempt, disgust: @disgust, fear: @fear, happiness: @happiness, neutral: @neutral, sadness: @sadness, surprise: @surprise, user_id: current_user.id)
        redirect_to emotion_path(@emotion.id), notice: "Analyzed successfully."
      else
        flash.now[:alert] = "You need to enter a url for face."
        render new_emotion_path
      end
    else
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."
    end
  end

  private
  def biorythms_params 
    params.require(:emotion).permit(:image).merge(user_id: current_user.id)
  end
end