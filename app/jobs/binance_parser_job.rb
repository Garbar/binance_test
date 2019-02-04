class BinanceParserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BinanceParser.new.call
  end
end
