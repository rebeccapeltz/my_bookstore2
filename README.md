# Tutorial on working with Ruby and Cloudinary
https://www.youtube.com/watch?v=jjqmpXjsXB8&feature=youtu.be

```
bundle install
```

## Correction
Becky Peltz (rebecca.peltz) 11:49 AM
need to add `gem "sqlite3", "~> 1.3.6"` to gemfile for video 1

```
rails generate model book title:string description:text image:string
```

```
rails s
```

## Homework
* Add another text_field in your form to get a remote URL of an image.
That should be for the :image attribute of ‘Book’.
* Include Cloudinary’s GEM (in the ‘Gemfile’ file).
* Shut down the server, and run bundle install in the terminal.
* Get your YML file (make sure you‘re logged in to your own account first!).
Store ‘cloudinary.yml’ in the /config/ folder, e.g., .../my_bookstore/config/cloudinary.yml.
* Only then start Rails server again (rails s).
* Use Cloudinary’s “fetch” for this image and show it in 3 different sizes:
* 50x50 on the ‘index’ page.
* 200x200 on the ‘show’ page.
* Optional - The latter should be a clickable link, which redirects to the full sized image. Any additional Cloudinary transformation of your choice is welcomed of course.

```
<%= cl_image_tag "sample"%>
```

```
rails c
a = Book.last
```

```
fetch_image_tag
type="fetch"
```

error with delete method
2.3.3 :002 > Book.all.each{|book| Cloudinary::Uploader.destroy(book.image, type: :fetch) if book.image; book.update_attribute(:image, nil)}
  Book Load (0.2ms)  SELECT "books".* FROM "books"
   (0.1ms)  begin transaction
   (0.0ms)  commit transaction
   (0.0ms)  begin transaction
   (0.0ms)  commit transaction
   (0.0ms)  begin transaction
   (0.0ms)  commit transaction
   (0.0ms)  begin transaction
   (0.0ms)  commit transaction
   (0.0ms)  begin transaction
   (0.0ms)  commit transaction
   (0.0ms)  begin transaction
   (0.0ms)  commit transaction
   (0.1ms)  begin transaction
   (0.1ms)  commit transaction
objc[21987]: +[__NSPlaceholderDictionary initialize] may have been in progress in another thread when fork() was called.
objc[21987]: +[__NSPlaceholderDictionary initialize] may have been in progress in another thread when fork() was called. We cannot safely call it or ignore it in the fork() child process. Crashing instead. Set a breakpoint on objc_initializeAfterForkError to debug.
MacBook-Pro-2:my_bookstore1 rebeccapeltz$ 

How to get around forking error on Mac
https://blog.phusion.nl/2017/10/13/why-ruby-app-servers-break-on-macos-high-sierra-and-what-can-be-done-about-it/

```
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```

replace
    <%= fetch_image_tag(@book.image, width:200, height:200, crop: "fill") if @book.image %>
with
    <%= fetch_image_tag(@book.image, width:200, height:200, crop: "fill") if @book.image %>

Cloudinary::Utils.signed_preloaded_image image
where image is json returned from uploading image

response is a string same as response from jquery uploads
resource type, type, version

identifier:
q=Cloudinary::PreloadedFile.new image  # use string returned above
q.public_id
q.version ...  

Destroy all books
```
Book.delete_all
```