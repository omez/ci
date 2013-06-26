set :application, "set your application name here"
set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# set :deploy_via, :copy
# set :copy_dir, "./tmp" # sometimes tmp directory is not readable or causes errors, so use local tmp directory for tar.gz archive etc.

# if you want to clean up old releases on each deploy uncomment this:
# set :keep_releases, 3
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# Shared children links (extension to support mapping)
# Option 1: Use shared children mapping
# set :shared_children_map, { "wp/wp-content/uploads" => "uploads", "wp/wp-content/cache" => "cache", "wp/wp-content/avatars" => "avatars"  }
# set :shared_children, fetch(:shared_folders, {}).values # Auto-create shared children from shared_children_map
# Option 2: Use shared children same path map
# set :shared_children, [] 
# set :use_sudo, true # uncomment if you want to use sudo

# Deploying stages, uncomment corresponding section
# Option 1: Single stage server
# --------
# role :web, "your web-server here"					 			# Your HTTP server, Apache/etc
# role :app, "your app-server here"					 			# This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true 	# This is where Rails migrations will run
# role :db,  "your slave db-server here"						# Slave remote server

# Option 2: Multistage users
# --------
# depend :local, :gem, "capistrano-ext" # ensure build server understand multistaging
# set :stage_dir, "./stages"
# set :stages, [] 																							# Option 1: Specify stages
# set :stages, Dir.entries(fetch(:stage_dir)).map{ |x| x.match('(.*)\.rb$'); }.compact.map { |x| x[1] } 	# Option 2: Autofetch stages
# set :default_stage, "local"
# require 'capistrano/ext/multistage'


# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#	run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


## Finalize task uses hashtables
namespace :deploy do
	task :finalize_update, :except => { :no_release => true } do 
		run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)	    
	    fetch(:shared_folders, Hash[fetch(:shared_children, []).collect { |v| [v, f(v)] }] ).each { |in_release, in_shared| 
		    run <<-CMD
		    	rm -rf #{latest_release}/#{in_release} &&
		    	mkdir -p #{latest_release}/#{in_release} &&
		    	rm -rf #{latest_release}/#{in_release} && 
				ln -Ts #{shared_path}/#{in_shared} #{latest_release}/#{in_release}
			CMD
		}
	end;
end
