=begin
Automated Ruby script that navigates to Agiletrailblazers, search for word 'agile', and
then the results for the search will be displayed. Designed for Firefox on macOS.
=end

require "selenium-webdriver"
require "rest-client"
require "json"
require "selenium-webdriver" 
require "base62"
require "uri"
require 'net/http'
require 'jira-ruby'
require 'net_http_ssl_fix'
require 'httparty'


puts "Starting the execution"


#Navigates to the homepage.
Given(/^We navigate to the Google WebSite$/) do
  puts "Inside the Given"
    puts "Connecting to the JIRA Using API"
	
	File.new "TestResult.xml" , "w"
	File.write('TestResult.xml','<?xml version="1.0" encoding="UTF-8"?>   <testsuites>  ',mode: 'a')
	
	
	
options = {
  username: 'ananthanarayan4u@gmail.com',
  password: 'nhG0JH27kdvvDKBNOmb8DDF0',
  site: 'https://ananthaproject.atlassian.net/',
  context_path: '',
  auth_type: :basic,
  use_ssl: true
}

client = JIRA::Client.new(options)
######puts client.to_s

# Show all projects
projects = client.Project.all
projects.each do |project|
#####puts project.key
end


project = client.Project.find('AN')
#####pp project
project.issues.each do |issue|
######puts issue.id
end



client.Issue.jql('PROJECT = "AN" and key = "AN-23" and type = "Test"', {fields: %w(summary status)}).each do |issue|
####puts "#{issue.id} - #{issue.key} - #{issue.status} - #{issue.fields['summary']}"
puts "#{issue.id} - #{issue.key} - #{issue.summary} "
#########issue.save({"fields"=>{"body"=>"Summary 123"}})
end


puts "Updating the status to IN PROGRESS "
issue = client.Issue.find("AN-23")
available_transitions = client.Transition.all(:issue => issue)
#####available_transitions.each {|ea| puts "#{ea.name} (id #{ea.id})" }

transition_id = '21'
transition = issue.transitions.build
transition.save!("transition" => {"id" => transition_id})


puts "Updating the comments section of the JIRA Issue "
issue = client.Issue.find("AN-23")
comment = issue.comments.build
comment.save!(:body => "The Status has been updated by Jenkins Automatically via Cucumber Tests." )

puts AppendToJunitXML("TestCase1","SFDC","Verify the files landed successfully",0)
#####issue.save({"fields"=>{"summary"=>"Summary 123"}})
#####pp issue

####issue = client.Issue.find("AN-9")
####issue.comments.each do |comment|
## pp comment
#####puts comment.to_s
#######end

puts "NEW CODEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE "

puts "Updating the status to DONE "
issue = client.Issue.find("AN-23")
available_transitions = client.Transition.all(:issue => issue)
#####available_transitions.each {|ea| puts "#{ea.name} (id #{ea.id})" }

transition_id = '31'
transition = issue.transitions.build
transition.save!("transition" => {"id" => transition_id})

puts AppendToJunitXML("TestCase2","SFDC","Verify the files as per the IASS document",1)

puts "Disconnecting from JIRA"
File.write('TestResult.xml',' </testsuites>  ',mode: 'a')
end



def AppendToJunitXML(v_testsuite_name,v_classname,v_name,v_failure)

if v_failure == 0 then
File.write('TestResult.xml','
  <testsuite name="'+v_testsuite_name+'" errors="0" skipped="0" tests="1" failures="'+v_failure.to_s+'" time="10.74" timestamp="2016-05-24T10:23:58">
  <testcase classname="'+v_classname+'" name="'+v_name+'"  time="1.3" response-time="0.3">
  </testcase>
 </testsuite>',mode: 'a')
 else
 File.write('TestResult.xml','
  <testsuite name="'+v_testsuite_name+'" errors="0" skipped="0" tests="1" failures="'+v_failure.to_s+'" time="10.74" timestamp="2016-05-24T10:23:58">
  <testcase classname="'+v_classname+'" name="'+v_name+'"  time="1.3" response-time="0.3">
  <failure message="Executed the Test Case and failed." />
<attachment>C:/file1.jpg</attachment>
[[ATTACHMENT|file1.jpg]]
  </testcase>
 </testsuite>',mode: 'a')
 end
 
end
