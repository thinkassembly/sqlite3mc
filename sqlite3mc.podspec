#
# Be sure to run `pod lib lint Sqlite3MC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'sqlite3mc'
  s.version          = '0.1.0'
  s.summary          = 'A short description of sqlite3mc.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/thinkassembly/sqlite3mc.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = 'asdlfkjalsdkfj '
  s.author           = { 'nullrocket' => 'douglas.b.hill@gmail.com' }
  s.source   = { :git => "https://github.com/thinkassembly/sqlite3mc.git" }
  s.prepare_command = <<-CMD
ls
mkdir -p sys
touch ./sys/random.h

CMD
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
s.requires_arc = false
s.default_subspecs = 'common'
s.subspec 'common' do |ss|

  ss.source_files = "sqlite3.{h,c},./sys/random.h"
  #ss.osx.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DHAVE_USLEEP=1 -maes #-aes' }
  # Disable OS X / AFP locking code on mobile platforms (iOS, tvOS, watchOS)
  sqlite_xcconfig_ios = { 'OTHER_CFLAGS' => '$(inherited)   -DSQLITE_TEMP_STORE=2 -DSQLITE_SOUNDEX -DSQLITE_THREADSAFE -DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_STAT3 -DSQLITE_ENABLE_STAT4 -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_MEMORY_MANAGEMENT -DSQLITE_ENABLE_LOAD_EXTENSION -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_FTS4_UNICODE61 -DSQLITE_ENABLE_FTS3_PARENTHESIS -DSQLITE_ENABLE_UNLOCK_NOTIFY -DSQLITE_ENABLE_JSON1 -DSQLITE_ENABLE_FTS5 -DSQLCIPHER_CRYPTO_CC -DHAVE_USLEEP=1 -DSQLITE_MAX_VARIABLE_NUMBER=99999
 -maes -isystem=./ ' ,
                          "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/sqlite3mc",
  }
  ss.ios.pod_target_xcconfig = sqlite_xcconfig_ios
 # ss.tvos.pod_target_xcconfig = sqlite_xcconfig_ios
 # ss.watchos.pod_target_xcconfig = sqlite_xcconfig_ios
  #
end




# The spellfix1 module not part of the default amalgation
# s.subspec 'spellfix1' do |ss|
#    ss.dependency 'sqlite3mcPod/common'
#    ss.source_files = "#{archive_name}/ext/misc/spellfix.c"
#  end
end