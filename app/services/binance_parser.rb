class BinanceParser
  def call
    RequestResult.nonparced.each do |raw|
      parsed_data = raw.raw_data["balances"].reject { |l| l["free"].to_f.zero? }
      raw.parsed_data = parsed_data
      raw.save
    end
  end
end