class BinanceGrabberJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BinanceGrabber.new.call
  end
end
