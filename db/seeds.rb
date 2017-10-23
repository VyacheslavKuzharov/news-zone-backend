# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

I18n.locale = :ru

puts '######## Generate Regions ########'
regions = [
    I18n.t('regions.rostov_region'),
    I18n.t('regions.krasnodar_region')
]

regions.each { |region| Region.create(name: region)}

puts '######## Generate Cities ########'

rostov_region = Region.find_by_name I18n.t('regions.rostov_region')
krasnodar_region = Region.find_by_name I18n.t('regions.krasnodar_region')

cities = [
    { name: I18n.t('cities.taganrog'), region_id: rostov_region.id},
    { name: I18n.t('cities.rostov'), region_id: rostov_region.id},
    { name: I18n.t('cities.krasnodar'), region_id: krasnodar_region.id}
]

cities.each { |city| City.create(city) }

puts '######## Generate Sites ########'

sites = [
    { name: 'MytaganrogCom', url: 'http://mytaganrog.com/' },
    { name: 'RostovlifeRu', url: 'http://rostovlife.ru/' }
]

sites.each { |site| Site.create site }

puts '######## Seeds Created ########'
