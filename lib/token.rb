class Token

  TOKEN_GRACE = 5*60*1000 # Five minutes in milliseconds

  attr_reader :secret
  attr_reader :encoded
  attr_reader :details
  attr_reader :payload
  attr_reader :metadata
  attr_reader :reason

  class << self

    # @return [Fixnum] time Time now in milliseconds
    def now
      Time.now.to_i*1000 # Time since epoch in milliseconds
    end

    # Generate an expiration time in milliseconds
    #
    # @param [Fixnum] duration in milliseconds
    # @return [Fixnum] expiration time in milliseconds
    def expires(duration)
      self.now + duration
    end
  end # class << self

  def initialize(options={})
    payload ||= options[:payload]
    encoded ||= options[:encoded]
    @secret = options[:secret] || Rails.application.secrets.secret_key_base
    expires ||= options[:expires]
    payload = {} unless payload
    payload['exp'] = expires if expires
    from_payload(payload) if payload
    from_encoded(encoded)  if encoded
  end

  alias :to_s :encoded

  def length
    @encoded ? @encoded.length : 0
  end

  def valid?
    revalidate
    !@invalid
  end

  def expired?
    revalidate
    @expired ? true : false
  end

  def expires?
    @payload && @payload.include?(:exp)
  end

  def error?
    @error
  end

  def duration
    revalidate
    return 0 if @expired
    exp = @payload['exp'] || @payload[:exp] if @payload
    return exp - self.class.now if exp
    +1.0/0.0
  end

  def fetch(key)
    @payload.fetch(key, nil) if @payload
  end

  def info
    revalidate
    puts "secret: #{@secret}"
    puts "encoded: #{@encoded}"
    puts "details: #{@details}"
    puts "payload: #{@payload}"
    puts "metadata: #{@metadata}"
    puts "expired: #{@expired}"
    puts "error: #{@error}"
    puts "reason: #{@reason}"
    puts "invalid: #{@invalid}"
  end

  private

  def from_encoded(encoded, options={})
    @secret ||= options[:secret]
    @encoded = encoded
    @details = nil
    @payload = nil
    @metadata = nil
    @expired = false
    @error = nil
    @reason = nil
    @invalid = false

    begin
      JWT.decode(encoded, @secret)
    rescue JWT::ExpiredSignature
      @expired = true
    rescue JWT::DecodeError => e
      @error = true
      @reason = {'Nil JSON web token' => :nil_token,
        'Not enough or too many segments' => :bad_segments,
        'Signature verification failed' => :signature_invalid,
        'Algorithm not supported' => :unsupport_algorithm,
       }[e.message]
    end
    begin
      @details = JWT.decode(encoded, nil, false, verify_expiration: false)
    rescue JWT::ExpiredSignature
    rescue JWT::DecodeError
    end
    if @details && @details.is_a?(Array) && @details.length == 2
      @payload = @details.first
      @metadata = @details.last
    end
    @payload = HashWithIndifferentAccess.new(@payload)
    revalidate
  end

  def from_payload(payload, options={})
    @secret ||= options[:secret]
    @payload = payload
    @metadata = {"typ"=>"JWT", "alg"=>"HS256"}
    @details = [@payload, @metadata]
    @expired = false
    @error = nil
    @reason = nil
    @invalid = false
    @payload = HashWithIndifferentAccess.new(@payload)
    @encoded = JWT.encode(@payload, @secret)
    revalidate
  end

  def revalidate
    unless @expired
      exp = @payload['exp'] || @payload[:exp] if @payload
      @expired = exp && (exp <= self.class.now-TOKEN_GRACE)
    end
    @invalid = @expired || @error
  end

end # Token