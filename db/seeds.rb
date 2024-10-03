# frozen_string_literal: true

# Destroy existing data
Note.destroy_all
Invoice.destroy_all
Project.destroy_all
User.destroy_all

# Seed 10 users
10.times do |i|
  user = User.create(
    first_name: "User #{i + 1}",
    last_name: "Lastname #{i + 1}",
    email: "user#{i + 1}@example.com",
    password: 'test@123' # Replace with your desired password
  )

  # Seed projects for each user
  5.times do |j|
    project = user.projects.create(
      name: "Project #{i + 1}- user #{j + 1}",
      description: "Description for Project #{i + 1}-#{j + 1}",
      start_date: Faker::Date.backward(days: 30)
    )

    # Seed invoices for each project
    invoices = []
    3.times do
      invoice = project.invoices.create(
        tenure_start_date: Faker::Date.backward(days: 30),
        tenure_end_date: Faker::Date.forward(days: 30),
        invoice_deadline: Faker::Date.forward(days: 30),
        invoice_creation_date: Date.today,
        payment_details: Faker::Number.decimal(l_digits: 2)
      )
      invoices << invoice
    end

    # Seed notes for each project
    5.times do |k|
      type = %w[project invoice].sample
      parent_id = type == 'project' ? project.id : project.invoices.sample&.id

      Note.create(
        title: "Note #{k + 1} for #{type.capitalize} #{i + 1}-#{j + 1}",
        description: "Description for Note #{k + 1}",
        tag: %w[low medium high].sample,
        user_id: user.id,
        note_type: type,
        parent_id: parent_id
      )
    end
  end
end

puts 'Seed data created successfully.'
