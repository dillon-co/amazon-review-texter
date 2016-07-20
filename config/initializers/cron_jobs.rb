Sidekiq::Cron::Job.create(name:"grab orders from 2 weeks ago", cron: "0 7 * * *", klass: 'DailyNameGenerator')

