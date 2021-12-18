count_map = (0..8).map { |d| File.read('input.txt').count(d.to_s) }
                  .tap do |f|
                    256.times do
                      p f
                      f.rotate!
                      f[6] += f[8]
                    end
                  end
p count_map.sum