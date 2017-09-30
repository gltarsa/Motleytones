module ExportHelper
  def hash_to_pairs(hash)
    hash.each.collect { |h| "#{h.first}: \"#{h.last}\"" if h.last }.compact.join(",\n  ")
  end

  # rubocop: disable Rails/Output
  def export_to_stdout(klass:, extra_exceptions: [])
    exceptions = [:id, :created_at, :updated_at] + extra_exceptions
    klass.order(:id).all.each do |item|
      hash = item.serializable_hash(except: exceptions)
      puts "#{klass.name}.create!(#{hash_to_pairs(hash)})"
    end
  end
  # rubocop: enable Rails/Output
end
