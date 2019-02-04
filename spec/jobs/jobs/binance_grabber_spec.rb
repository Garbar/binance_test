require "rails_helper"

RSpec.describe BinanceGrabberJob, :type => :job do
  describe "#perform_later" do
    it "binance grabber" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        BinanceGrabberJob.perform_later
      }.to have_enqueued_job
    end
  end
end