class Card < ApplicationRecord
  belongs_to :story

  mount_uploader :photo, PhotoUploader

  # Neu prev_id == 0 thi tuc la card nay la card dau tien trong story
  def prev
    prev_id == 0 ? nil : story.cards.find(prev_id)
  end

  def prev=(aCard)
    if aCard.instance_of? Card
      self.prev_id = aCard.id
    else
      self.prev_id = aCard
    end
  end

  # Neu next_id ma la -1 thi tuc la card nay la card cuoi cung trong story
  def next
    self.next_id == -1 ? nil : self.story.cards.find(self.next_id)
  end

  # Gan gia tri cho card tiep theo. Neu bien truyen vao la 1 Card thi id cua Card
  # Neu khong thi gan luon
  def next=(aCard)
    if aCard.instance_of? Card
      self.next_id = aCard.id
    else
      self.next_id = aCard
    end
  end
end
