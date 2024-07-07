require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # 画像をbase64にエンコード
      base64_image = Base64.encode64(image_file.tempfile.read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)

      # デバッグ用のログを追加
      Rails.logger.info("Vision API request params: #{params}")
      Rails.logger.info("Vision API response: #{response.body}")

      response_body = JSON.parse(response.body)

      # APIレスポンス出力
      if response_body['responses'] && response_body['responses'][0]['error']
        raise "Vision API Error: #{response_body['responses'][0]['error']['message']}"
      elsif response_body['responses'] && response_body['responses'][0]['labelAnnotations']
        response_body['responses'][0]['labelAnnotations'].pluck('description').take(3)
      else
        raise "Unexpected response structure from Vision API: #{response.body}"
      end
    end
  end
end