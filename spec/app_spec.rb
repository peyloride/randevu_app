require 'spec_helper'
require_relative '../app'

RSpec.describe "App", :type => :request do

  before(:each) do
    @saatler = [
      {'kota': 3, 'saat': '09:00'},
      {'kota': 3, 'saat': '09:20'},
      {'kota': 3, 'saat': '09:40'},
      {'kota': 3, 'saat': '10:00'},
      {'kota': 3, 'saat': '10:20'},
      {'kota': 3, 'saat': '10:40'},
      {'kota': 2, 'saat': '11:00'},
      {'kota': 2, 'saat': '11:20'},
      {'kota': 2, 'saat': '11:40'},
      {'kota': 2, 'saat': '12:00'},
      {'kota': 1, 'saat': '12:20'},
      {'kota': 1, 'saat': '12:40'},
      {'kota': 1, 'saat': '13:00'}
    ]
    @randevular = [
      {'kisi_sayisi': 2, 'saat': '10:40'},
      {'kisi_sayisi': 3, 'saat': '09:00'},
      {'kisi_sayisi': 1, 'saat': '11:40'},
      {'kisi_sayisi': 2, 'saat': '11:20'},
      {'kisi_sayisi': 1, 'saat': '09:40'},
      {'kisi_sayisi': 3, 'saat': '09:00'},
      {'kisi_sayisi': 4, 'saat': '10:00'}
    ]
  end

  describe "#n_sonraki_saat_index" do
    it "returns integer" do
      expect(n_sonraki_saat_index(@saatler, '09:00', 1)).to be_a(Integer)
    end

    it "returns index of saat adjacent to this" do
      expect(n_sonraki_saat_index(@saatler, '09:00', 1)).to eq(1)
    end

    it "returns index of the next two hours from the specified time" do
      expect(n_sonraki_saat_index(@saatler, '09:00', 2)).to eq(2)
    end

    it "should not return any other appointment hour" do
      expect(n_sonraki_saat_index(@saatler, '09:00', 1)).not_to eq(5)
    end
  end

  describe "#randevuları_yerlestir" do
    it "decreases quota of 09:00 appointment from 3 to 1" do
      expect{
        randevuları_yerlestir(@saatler, @randevular)
      }.to change { @saatler[0][:kota] }.from(3).to(1)
    end

    it "decreases quota of 09:20 appointment from 3 to 1" do
      expect{
        randevuları_yerlestir(@saatler, @randevular)
      }.to change { @saatler[1][:kota] }.from(3).to(1)
    end
  end

  describe "#randevu_verilemez?" do
    it "returns true if there is no appointment at specified index" do
      expect(randevu_verilemez?(@saatler, @saatler[12], 2)).to eq(true)
    end

    it "returns true if there is not any quota left" do
      @saatler[0][:kota] = 0
      expect(randevu_verilemez?(@saatler, @saatler[0], 0)).to eq(true)
    end

    it "returns false if appointable" do
      expect(randevu_verilemez?(@saatler, @saatler[0], 0)).to eq(false)
    end
  end

  describe "#musait_saatler" do
    it "returns appropriate appointable hours" do
      expect(musait_saatler(@saatler, @randevular, 3)).to eq(["10:00", "12:00", "12:20"])
    end

    it "returns blank array if there is not any appropriate appointable hours" do
      expect(musait_saatler(@saatler, @randevular, 6)).to eq([])
    end
  end
end
