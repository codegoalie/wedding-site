require 'simplehasher'

class Invitation < ActiveRecord::Base
  belongs_to :guest
  
  before_create :set_passcode

  attr_accessible :guest_id
  attr_readonly :passcode

  def self.from_hash(id_hash, passcode=nil)
    id = SimpleHasher.decode(id_hash)
    if passcode
      Invitation.where(:id => id, :passcode => passcode).first
    else
      Invitation.find id
    end
  end

  def id_hash
    SimpleHasher.encode(self.id) unless new_record?
  end

  #private 
    def set_passcode
      self.passcode = "#{PASSCODE_WORDS.sample.capitalize}#{PASSCODE_WORDS.sample.capitalize}#{rand(899)+100}"
    end

    PASSCODE_WORDS = [
      'achievement', 'admiration', 'adoration', 'adore', 'affection', 
      'affectionate', 'affinity', 'agreement', 'aisle', 'altar', 
      'anniversary', 'announcement', 'appreciation', 
      'attendance', 'attentive', 'attraction', 'bachelor', 'beloved', 
      'bestMan', 'blessing', 'bond', 'bouquet', 'boutonniere', 'bow', 'bride', 
      'budget', 'capable', 'caregiver', 'caring', 'celebration', 'ceremony', 'chapel', 
      'charmer', 'cherish', 'civil', 'clever', 'commitment', 
      'charmer', 'companion', 'compassion',
      'congratulations', 'corsage', 'couple', 'courtship', 'cozy', 
      'customary', 'dating', 'dazzle', 'dear', 'decision', 'declaration', 'dedication', 
      'delightful', 'dependable', 'devoted', 'devotion', 'dine', 
      'emotion', 'endearment', 'engagement', 'espouse', 
      'experience', 'family', 'fascinate', 'favor', 'favorite', 'fellowship', 
      'fiancee', 'forever', 'friend', 'friendship', 
      'gala', 'gathering', 'gentle', 'genuine', 'hitched', 'married', 
      'getaway', 'grin', 'groom', 'happiness', 'heart', 'hideaway', 
      'honey', 'honeymoon', 'honor', 'husband', 
      'integrity', 
      'intelligence', 'invitation', 'jocular', 'join', 'joyful', 'karma', 
      'kindness', 'kiss', 'lace', 'laughter', 'legacy', 
      'limousine', 'logical', 'love', 'loyalty', 'maidOfHonor', 'march', 
      'marriage', 'marry', 'mate', 'matrimony', 'memory', 
      'music', 'nerves', 'notion', 
      'partner', 'passionate', 'paternal', 
      'permanent', 'photograph', 'physical', 'precious', 'prize', 'protection', 
      'reading', 'reasonable', 'reasoning', 'reception', 
      'regard', 'relationship', 'relative', 'remembrance', 
      'reminiscent', 'respect', 'responsibility', 'responsible', 'revere', 'rice', 'ring', 
      'rite', 'role', 'model', 'romantic', 'service', 
      'sharing', 'show', 'shower', 'soiree', 'solemn', 'special', 
      'sweet', 'sweetheart', 'symbolize', 'sympathetic', 'teach', 'tie', 
      'together', 'token', 'truelove', 'tuxedo', 
      'union', 'unique', 'unite', 'unusual', 'usher', 'utmost', 'veil', 
      'vision', 'vow', 'warmth', 'white', 'wife', 'willingness', 'wisdom', 
      'wise', 'witness', 'wonderful'
    ]
end
