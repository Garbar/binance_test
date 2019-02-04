require "rails_helper"

RSpec.describe BinanceParserJob, :type => :job do
  describe "#perform_later" do
    it "binance parser" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        BinanceParserJob.perform_later
      }.to have_enqueued_job
    end
  end
end