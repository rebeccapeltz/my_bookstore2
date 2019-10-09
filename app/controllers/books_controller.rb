class BooksController < ApplicationController
def index
    # render plain: "hello"
    # /
    @books = Book.all
end
def show
    # books/1
    @book = Book.find(params[:id])
    if @book.image
        image = Cloudinary::PreloadedFile.new @book.image
        @public_id = image.public_id
        @version = image.version
    end
end
def new
    @book = Book.new()
end
def create
    puts "XXXXXXXXXcreate"
    puts book_params

    @book = Book.new(book_params)
    # @book = Book.new(book_params.except(:image))

    # if book_params[:image]  # don't try to add image if not exist
        # image = Cloudinary::Uploader.upload(book_params[:image]) #returns json response
    # image = Cloudinary::PreloadedFile.new
    # @public_id = image.public_id
    # @version = image.version
    # @book.image = image["public_id"]
        # @book.image = Cloudinary::Utils.signed_preloaded_image image
    # end
    @book.save
    redirect_to @book
end
def edit
    @book = Book.find(params[:id])
end
def update
    @book = Book.find(params[:id])
    current_image = @book.image
    existing = true if @book.image
    # @book.update(book_params)
    @book.assign_attributes(book_params)
    puts "XXXXXXXupdate"
    puts book_params
    if book_params[:image] and existing
        # if @book.image 
            image = Cloudinary::PreloadedFile.new current_image
            Cloudinary::Uploader.destroy image.public_id, resource_type: image.resource_type, type: image.type
        # end
        # image = Cloudinary::Uploader.upload(book_params[:image])
        # @book.image = Cloudinary::Utils.signed_preloaded_image image
    end
    @book.save
    redirect_to @book
end
def destroy
    @book = Book.find(params[:id])
    if @book
        # remove from database
        @book.destroy
        if @book.image
            # destroy cloudinary image
            image = Cloudinary::PreloadedFile.new @book.image
            Cloudinary::Uploader.destroy image.public_id, resource_type: image.resource_type, type: image.type
        end
    end
    # redirect_to books_path
    redirect_to root_path
end
private
def book_params
    params.require(:book).permit(:title,:description,:image)
end
end
