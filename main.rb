require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/reports.db")
class Report
	include DataMapper::Resource
	property :id, Serial
	property :localbackup, Boolean, :required => true, :default => false
	property :sharepointcreated, Boolean, :required => true, :default => false
	property :sharepointused, Boolean, :required => true, :default => false
	property :emailbackup, Boolean, :required => true, :default => false
	property :migrationtimeline, Text
	property :reportmonth, Text
	property :reportyear, Text
	property :created_at, DateTime
	property :updated_at, DateTime
end
DataMapper.finalize.auto_upgrade!

get '/' do
	@report = Report.all :order => :id.desc
	@title = 'All Reports'
	erb :home
end 

post '/' do
	r = Report.new
	r.localbackup = params[:localbackup]
	r.sharepointcreated = params[:sharepointcreated]
	r.sharepointused = params[:sharepointused]
	r.emailbackup = params[:emailbackup]
	r.migrationtimeline = params[:migrationtimeline]
	r.reportmonth = params[:reportmonth]
	r.reportyear = params[:reportyear]
	r.created_at = Time.now
	r.updated_at = Time.now
	r.save
	redirect '/'
end

get '/:id' do  
  @report = Report.get params[:id]  
  @title = "Edit report #{params[:id]}"  
  erb :edit  
end  