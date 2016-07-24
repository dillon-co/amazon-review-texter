Sidekiq::Cron::Job.create(name:"grab orders from 2 weeks ago", cron: "0 7 * * *", klass: 'DailyNameGenerator')

Sidekiq::Cron::Job.create(name:"grab names from 3 days ago", cron: "0 4 * * *", klass: 'DailyEmailCreator')