# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Seeding database..."

# Издатели
publishers = [
  Publisher.create!(name: "Эксмо", email: "eksmo@example.com", phone: "1234567890"),
  Publisher.create!(name: "АСТ", email: "ast@example.com", phone: "0987654321"),
  Publisher.create!(name: "Манн, Иванов и Фербер", email: "mif@example.com", phone: "1122334455")
]

# Авторы
authors = [
  Author.create!(first_name: "Александр", last_name: "Пушкин", biography: "Русский поэт", born_in: "1799-06-06", died_in: "1837-02-10"),
  Author.create!(first_name: "Лев", last_name: "Толстой", biography: "Писатель, философ", born_in: "1828-09-09", died_in: "1910-11-20"),
  Author.create!(first_name: "Фёдор", last_name: "Достоевский", biography: "Русский писатель", born_in: "1821-11-11", died_in: "1881-02-09"),
  Author.create!(first_name: "Антон", last_name: "Чехов", biography: "Драматург и прозаик", born_in: "1860-01-29", died_in: "1904-07-15"),
  Author.create!(first_name: "Иван", last_name: "Тургенев", biography: "Русский писатель", born_in: "1818-11-09", died_in: "1883-09-03")
]

# Жанры
genres = [
  Genre.create!(name: "Классика", description: "Литературная классика"),
  Genre.create!(name: "Фантастика", description: "Научная и социальная фантастика"),
  Genre.create!(name: "Драма", description: "Сильные эмоции и конфликты"),
  Genre.create!(name: "Приключения", description: "Интересные и захватывающие события")
]

# Книги
10.times do |i|
  book = Book.create!(
    title: "Книга #{i + 1}",
    description: "Описание книги #{i + 1}",
    published_in: Date.today - rand(10000),
    weight: rand(100..500),
    pages_count: rand(100..1000),
    isbn13: "9781234567#{rand(100..999)}",
    isbn10: "1234567#{rand(10..99)}",
    publisher: publishers.sample
  )

  book.authors << authors.sample(rand(1..3))
  book.genres << genres.sample(rand(1..2))
end

puts "✅ Seeding done!"
