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
    ss.source_files = "sqlite*.{h,c}"
    ss.public_header_files = "sqlite3.h,sqlite3ext.h"
    ss.osx.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DHAVE_USLEEP=1 -maes -isystem=./ -Wno-strict-prototypes DIAG_OFF_CLANG(shorten-64-to-32)
 ',
               "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/sqlite3mc",
    # Disable OS X / AFP locking code on mobile platforms (iOS, tvOS, watchOS)
    sqlite_xcconfig_ios = { 'OTHER_CFLAGS' => '$(inherited) -DHAVE_USLEEP=1 -DSQLITE_ENABLE_LOCKING_STYLE=0  -maes -isystem=./ -Wno-strict-prototypes DIAG_OFF_CLANG(shorten-64-to-32)
 ',
                               "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/sqlite3mc",

     }
    ss.ios.pod_target_xcconfig = sqlite_xcconfig_ios
    ss.tvos.pod_target_xcconfig = sqlite_xcconfig_ios
    ss.watchos.pod_target_xcconfig = sqlite_xcconfig_ios
  end

  # Detect misuse of SQLite API
  s.subspec 'api_armor' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_API_ARMOR=1' }
  end

  # API for column meta-data access
  s.subspec 'coldata' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_COLUMN_METADATA=1' }
  end

  # FTS4 full-text-search
  s.subspec 'fts' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_FTS4=1 -DSQLITE_ENABLE_FTS3_PARENTHESIS=1' }
  end

  # FTS5 full-text-search
  s.subspec 'fts5' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_FTS5=1' }
  end

  # Geopoly extension
  s.subspec 'geopoly' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.dependency 'sqlite3mc/rtree'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_GEOPOLY=1' }
  end

  # JSON1 extension for managing JSON content (Built-in since 3.38.0)
  s.subspec 'json1' do |ss|
    ss.dependency 'sqlite3mc/common'
  end

  # Recommended defaults for increased performance and reduced memory usage
  s.subspec 'perf' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_DQS=0 -DSQLITE_THREADSAFE=0 -DSQLITE_DEFAULT_MEMSTATUS=0 -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 -DSQLITE_LIKE_DOESNT_MATCH_BLOBS=1 -DSQLITE_MAX_EXPR_DEPTH=0 -DSQLITE_OMIT_DECLTYPE=1 -DSQLITE_OMIT_DEPRECATED=1 -DSQLITE_OMIT_PROGRESS_CALLBACK=1 -DSQLITE_OMIT_SHARED_CACHE=1 -DSQLITE_USE_ALLOCA=1' }
  end

  # Recommended defaults for increased performance and reduced memory usage (Threadsafe and with shared-cache mode)
  s.subspec 'perf-threadsafe' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_DQS=0 -DSQLITE_DEFAULT_MEMSTATUS=0 -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 -DSQLITE_LIKE_DOESNT_MATCH_BLOBS=1 -DSQLITE_MAX_EXPR_DEPTH=0 -DSQLITE_OMIT_DECLTYPE=1 -DSQLITE_OMIT_DEPRECATED=1 -DSQLITE_OMIT_PROGRESS_CALLBACK=1 -DSQLITE_USE_ALLOCA=1' }
  end

  # Resumable Bulk Update
  s.subspec 'rbu' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_RBU=1' }
  end

  # R*Tree index for range queries
  s.subspec 'rtree' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_RTREE=1' }
  end

  # Session extension: Record and package changes to rowid tables into files that can be applied to other DBs
  s.subspec 'session' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_PREUPDATE_HOOK=1 -DSQLITE_ENABLE_SESSION=1' }
  end

  # Interface for historical database snapshots
  s.subspec 'snapshot' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_SNAPSHOT=1' }
  end

  # Soundex phonetic string encoding function
  s.subspec 'soundex' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_SOUNDEX=1' }
  end

  # Enhanced ANALYZE and query planner (Deprecated!)
  s.subspec 'stat3' do |ss|
    # The legacy option SQLITE_ENABLE_STAT3 is a no-op since version 3.30.0
    # We therefore depend on the replacement SQLITE_ENABLE_STAT4
    ss.dependency 'sqlite3mc/stat4'
  end

  # Enhanced ANALYZE and query planner: Collects histogram data for all columns of each index
  s.subspec 'stat4' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_STAT4=1' }
  end

  # Build unicode61 FTS tokenizer (Deprecated! The tokenizer is built by default)
  s.subspec 'unicode61' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.dependency 'sqlite3mc/fts'
  end

  # API to register unlock-notification callbacks
  s.subspec 'unlock_notify' do |ss|
    ss.dependency 'sqlite3mc/common'
    ss.pod_target_xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_ENABLE_UNLOCK_NOTIFY=1' }
  end

  # The spellfix1 module not part of the default amalgation
 # s.subspec 'spellfix1' do |ss|
 #   ss.dependency 'sqlite3mc/common'
 #   ss.source_files = "#{archive_name}/ext/misc/spellfix.c"
 # end
end