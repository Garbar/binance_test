class BinanceGrabber
  require 'faraday'
  require 'openssl'
  BASE = 'https://api.binance.com/api'

  def call
    conn = Faraday.new(url: "#{BASE}/v3/account") do |faraday|
      faraday.response :json, content_type: /\bjson$/
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['X-MBX-APIKEY'] = Rails.application.credentials[:api_key]
      faraday.params = params_with_signature
    end
    response = conn.get
    if new_record?(response.body["updateTime"])
      result = RequestResult.create(raw_data: response.body,
                             update_time: response.body["updateTime"])
      result.save
    end
  end

  private
  #############################################################################

  def params_with_signature
    params = {
      recvWindow: 5000,
      timestamp: Time.now.to_i * 1000
    }
    secret = Rails.application.credentials[:api_secret]
    params = params.reject { |_k, v| v.nil? }
    query_string = URI.encode_www_form(params)
    signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, query_string)
    params.merge(signature: signature)
  end

  def last_update_record
    RequestResult.last ? RequestResult.last.update_time : 0
  end

  def new_record?(update_time)
    update_time != last_update_record
  end
end