class Asset < ActiveRecord::Base
  require "iconv"
  attr_accessible :media_content_type, :media_file_name, :media_file_size, :media_updated_at, :name, :media
  belongs_to :assetable, :polymorphic => true

  has_attached_file :media,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }

  before_post_process :transliterate_file_name


  validate :validate_attachments

  MAX_ATTACHMENTS = 6
  MAX_ATTACHMENT_SIZE = 2.megabyte
  CONTENT_TYPES = ["image/png", "image/jpeg", "image/gif"]


  #TODO - Add validations
  def validate_attachments
    #errors.add_to_base("Too many attachments - maximum is #{MAX_ATTACHMENTS}") if item_assets.length > MAX_ATTACHMENTS
    #item_assets.each {|a| errors.add_to_base("#{a.name} is over #{MAX_ATTACHMENT_SIZE/1.megabyte}MB") if a.file_size > MAX_ATTACHMENT_SIZE}
    #item_assets.each {|a| errors.add_to_base("Only png, jpg, and gif images are allowed.") unless CONTENT_TYPES.include?(a.content_type)}
  end

  def transliterate(str)
    # Based on permalink_fu by Rick Olsen

    # Escape str by transliterating to UTF-8 with Iconv
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s

    # Downcase string
    s.downcase!

    # Remove apostrophes so isn't changes to isnt
    s.gsub!(/'/, '')

    # Replace any non-letter or non-number character with a space
    s.gsub!(/[^A-Za-z0-9]+/, ' ')

    # Remove spaces from beginning and end of string
    s.strip!

    # Replace groups of spaces with single hyphen
    s.gsub!(/\ +/, '-')

    return s
  end

  def transliterate_file_name
    extension = File.extname(media_file_name).gsub(/^\.+/, '')
    filename = media_file_name.gsub(/\.#{extension}$/, '')
    self.media.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
  end

end
