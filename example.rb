# calculate AM/FM signals
require 'matlab'

SAMPLE_RATE = 44100.0

def generate_wave(data, wave_type, mod_type, time, fm, fc, mi, max_amplitude)
  data ||= []
  if wave_type == :sine
    signals = sine_wave time, fm, 10
  else
    signals = square_wave data, time
  end

  t  = (0..time).step(1 / SAMPLE_RATE).to_a
  sc = sina(2 * pi * fc * t)
  if mod_type == :am
    samples = sc * (max_amplitude.to_f + mi * signals)
  else
    samples = max_amplitude * sina(2 * pi * fc * t + mi * signals)
  end
  samples
end

def sine_wave time, frequency, max_amplitude
  t = (0..time).step(1 / SAMPLE_RATE).to_a
  samples = max_amplitude * sina(2 * pi * frequency * t)
end

def square_wave data, time
  length = (time * SAMPLE_RATE).to_i + 1
  samples = [].fill(0.0, 0, length)
  if data.size > 0
    period = length / (data.size)
    start = 0
    data.each do |i|
      samples.fill(i, start, period)
      start += period
    end 
  end 
  samples
end

#Invoke R
#data = 50.times.map{rand(0..100)}
#fc = generate_wave(data, :sine, :am, 0.02, 500, 20000, 0.3, 2)
# R.eval "plot(x, type='l', xaxt='n', yaxt='n', bty='n', ann='False')"
