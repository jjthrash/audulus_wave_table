class Sox
  # load the WAV file at `path` and turn it into a list of samples,
  # -1 to 1 in value
  def self.load_samples(path)
    `sox "#{path}" -t dat -`.
      lines.
      reject {|l| l.start_with?(';')}.
      map(&:strip).
      map(&:split).
      map(&:last).
      map(&:to_f)
  end
end

