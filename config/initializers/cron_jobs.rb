Sidekiq::Cron::Job.create(name:"grab orders from 2 weeks ago", cron: "0 9 * * *", klass: 'DailyNameGenerator')

