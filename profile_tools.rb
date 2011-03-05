class ProfileTools
  attr_accessor :mem_chunk_size, :mem_decimals

  def initialize()
    @mem_chunk_size = "Mb"
    @mem_decimals = 1
    @byte_divisor = {"Kb" => 1, "Mb" => 1024, "Gb" => 1024 * 1024}
  end

  def show_mem(note = '')
    now = Time.new.strftime("%Y%m%d-%H%M%S")
    pid = $$
    # NOTE: the requirement of the ps command
    mem = sprintf("%.#{@mem_decimals}f", (`ps -o rss= -p #{$$}`.to_f / @byte_divisor[@mem_chunk_size]).to_i)
    puts "#{now} - PID: #{pid} MEM: #{mem} #{@mem_chunk_size}  #{note}"
  end
end

