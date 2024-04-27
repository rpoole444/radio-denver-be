class MetArtFacade
  def art_single(id)
    call = ArtService.new.art_by_id(id)
    MetArtPoro.new(call)
  end
end
