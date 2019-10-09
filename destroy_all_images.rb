# remove image from cloudinary and update database

a = Book.all
a.each do |book|
    Cloudinary::Uploader.destroy(book.image, type: :fetch) if book.image 
    # book.update_attribute :image, nil
end

a = Book.all
a.each do |book|
    # Cloudinary::Uploader.destroy(book.image, type: "fetch") if book.image 
    book.update_attribute :image, nil
end

a = Book.all
a.each do |book|
    puts book.inspect
end


# Book.all.each{|book| Cloudinary::Uploader.destroy(book.image, type: :fetch) if book.image; book.update_attribute(:image, nil)}