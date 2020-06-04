class EmotionsController < ApplicationController

  def index
    angerWeek = current_user.emotions.with_weekly_data.average(:anger)
    contemptWeek = current_user.emotions.with_weekly_data.average(:contempt)
    disgustWeek = current_user.emotions.with_weekly_data.average(:disgust)
    fearWeek = current_user.emotions.with_weekly_data.average(:fear)
    happinesstWeek = current_user.emotions.with_weekly_data.average(:happiness)
    neutralWeek = current_user.emotions.with_weekly_data.average(:neutral)
    sadnessWeek = current_user.emotions.with_weekly_data.average(:sadness)
    surpriseWeek = current_user.emotions.with_weekly_data.average(:surprise)
    emotionWeeks_ave = [
             angerWeek,
             contemptWeek,
             disgustWeek,
             fearWeek,
             happinesstWeek,
             neutralWeek,
             sadnessWeek,
             surpriseWeek
            ]
    gon.chartWeeks_ave = emotionWeeks_ave

    angerMonth = current_user.emotions.with_monthly_data.average(:anger)
    contemptMonth = current_user.emotions.with_monthly_data.average(:contempt)
    disgustMonth = current_user.emotions.with_monthly_data.average(:disgust)
    fearMonth = current_user.emotions.with_monthly_data.average(:fear)
    happinesstMonth = current_user.emotions.with_monthly_data.average(:happiness)
    neutralMonth = current_user.emotions.with_monthly_data.average(:neutral)
    sadnessMonth = current_user.emotions.with_monthly_data.average(:sadness)
    surpriseMonth = current_user.emotions.with_monthly_data.average(:surprise)
    emotionMonths_ave = [
              angerMonth,
              contemptMonth,
              disgustMonth,
              fearMonth,
              happinesstMonth,
              neutralMonth,
              sadnessMonth,
              surpriseMonth
             ]
    gon.chartMonths_ave = emotionMonths_ave
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
      request['Ocp-Apim-Subscription-Key'] = ENV['KEY']
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