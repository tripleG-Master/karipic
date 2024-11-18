# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Deleting all records..."
    
Post.destroy_all
User.destroy_all
# Purgamos active storage
ActiveStorage::Attachment.delete_all
ActiveStorage::Blob.delete_all
require 'aws-sdk-s3'
s3 = Aws::S3::Resource.new(
    region: 'sa-east-1',
    access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
    secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
)
bucket = s3.bucket('karipic-rails')
# Borramos todo lo de adentro del bucket
bucket.objects.each(&:delete)

puts "Records deleted"

if true

    puts "Creating records..."

    ## Seed Users
    puts "Creating Users..."
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
    profile_picture_files = Dir[Rails.root.join("public/profile_pictures/*.jpeg")]
    users.each do |attributes|
        user = User.create!(attributes)
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

    puts "Creating Posts..."
    post_images_files = Dir[Rails.root.join("public/images/*.jpeg")]
    6.times do |i|
        user = User.find_by(admin: true)
        post = Post.create!(
            description: Faker::Quote.famous_last_words,
            user: user,
            )
        if post_images_files.any?
            selected_picture = post_images_files.sample
            post_images_files.delete(selected_picture)
            post.image.attach(
            io: File.open(selected_picture),
            filename: File.basename(selected_picture)
            )
        else
            puts "No img available."
        end
    end
    ## Seed Comments

    puts "Creating Comments..."
    30.times do |i|
        post = Post.all.sample
        user = User.all.reject { |u| u == post.user }.sample
        Comment.create!(
            description: Faker::Lorem.sentence,
            post: post,
            user: user,
        )
    end

end