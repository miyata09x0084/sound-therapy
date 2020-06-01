class EmotionsController < ApplicationController

  def index
    angerWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:anger)
    contemptWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:contempt)
    disgustWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:disgust)
    fearWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:fear)
    happinesstWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:happiness)
    neutralWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:neutral)
    sadnessWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:sadness)
    surpriseWeek = Emotion.with_weekly_data.search_with_id(current_user.id).search_with_feeling(:surprise)
    emotionWeeks = [
             angerWeek,
             contemptWeek,
             disgustWeek,
             fearWeek,
             happinesstWeek,
             neutralWeek,
             sadnessWeek,
             surpriseWeek
            ]
    chartWeeks = []
    emotionWeeks.each do |emotionWeek|
      chartWeeks << emotionWeek.inject(:+) / emotionWeek.length
    end
    gon.chartWeeks = chartWeeks

    angerMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:anger)
    contemptMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:contempt)
    disgustMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:disgust)
    fearMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:fear)
    happinesstMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:happiness)
    neutralMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:neutral)
    sadnessMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:sadness)
    surpriseMonth = Emotion.with_monthly_data.search_with_id(current_user.id).search_with_feeling(:surprise)
    emotionMonths = [
              angerMonth,
              contemptMonth,
              disgustMonth,
              fearMonth,
              happinesstMonth,
              neutralMonth,
              sadnessMonth,
              surpriseMonth
             ]
    chartMonths = []
    emotionMonths.each do |emotionMonth|
      chartMonths << emotionMonth.inject(:+) / emotionMonth.length
    end
    gon.chartMonths = chartMonths
  end

  def show
    @emotion = Emotion.last
    @chartData = [
                  @emotion.anger,
                  @emotion.contempt,
                  @emotion.disgust,
                  @emotion.fear,
                  @emotion.happiness,
                  @emotion.neutral,
                  @emotion.sadness,
                  @emotion.surprise
                 ]

    gon.chartData = @chartData
  end

  def new
      @emotion = Emotion.new
  end

  def result
    if user_signed_in?
      require 'net/http'

      uri = URI('https://japaneast.api.cognitive.microsoft.com/face/v1.0/detect')
      uri.query = URI.encode_www_form({
          'returnFaceAttributes' => 'emotion'
      })

      request = Net::HTTP::Post.new(uri.request_uri)
      request['Ocp-Apim-Subscription-Key'] = '8d4223df7b0d48e69f3cc03263301344'
      request['Content-Type'] = 'application/json'

      imageUri = params[:url]
      request.body = "{\"url\": \"" + imageUri + "\"}"

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(request)
      end

      res = JSON.parse(response.body)

      if res[0].present?
        emoData = res[0]["faceAttributes"]["emotion"]
        emotion = Emotion.create(
                                  anger: emoData["anger"],
                                  contempt: emoData["contempt"],
                                  disgust: emoData["disgust"],
                                  fear: emoData["fear"],
                                  happiness: emoData["happiness"],
                                  neutral: emoData["neutral"],
                                  sadness: emoData["sadness"],
                                  surprise: emoData["surprise"],
                                  user_id: current_user.id
                                )

        redirect_to emotion_path(emotion.id), notice: "Analyzed successfully."
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