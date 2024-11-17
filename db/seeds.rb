# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Post.destroy_all
User.destroy_all


## Seed Users

emails = [
    "karina@karipic.com",
    "emma@emmapic.com",
    "lily@lilypic.com",
    "oliver@oliverpic.com",
    "sofia@softwaresolutions.com",
    "david@digitaldreams.net",
    "ana@artgallery.org",
    "benjamin@businessbuilder.biz",
    "julia@journeyjournal.info",
    "marcos@marketingmagic.co",
    "clara@creativestudio.de",
    "nicolas@newsnetwork.fr",
]

users = []

emails.each do |email|
    
    password = "password"
    users << {
        email: email,
        password: password,
        password_confirmation: password,
    }

end

users.each do |attributes|
    user = User.create!(attributes)

    # buscamos las imagenes
    profile_picture_files = Dir[Rails.root.join("public/profile_pictures/*.jpeg")]
    
    # seleccionamos una imagen aleatoria y la borramos
    # para evitar la repeticion
    if profile_picture_files.any?
        selected_picture = profile_picture_files.sample
        profile_picture_files.delete(selected_picture)
        
        user.profile_picture.attach(
            io: File.open(selected_picture),
            filename: File.basename(selected_picture)
        )
    else
        puts "No img available."
    end

end

## Seed Posts

6.times do |i|
    user = User.find_by(admin: true)

    post = Post.create!(
        description: Faker::Quote.famous_last_words,
        user: user,
        )

    post.image.attach(
        io: File.open(Rails.root.join("public/images/#{i+1}.jpeg")),
        filename: "post-#{post.id}-user-#{user.id}.jpeg"
        )

end

## Seed Comments

30.times do |i|

    post = Post.all.sample
    user = User.all.reject { |u| u == post.user }.sample

    Comment.create!(
        description: Faker::Lorem.sentence,
        post: post,
        user: user,
    )

end