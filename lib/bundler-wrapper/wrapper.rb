# Copyright (c) 2015 Solano Labs All Rights Reserved

module BundlerWrapper
  class BundlerWrapper
    MAX_RERUNS = 5

    def self.invoke(argv)
      env = ENV.to_hash.dup

      reruns = 0

      while reruns < MAX_RERUNS do
        ok, rerun = run_bundler(env, argv)
        if status == 0 || !rerun then
          exit(status)
        end
        reruns += 1
      end
      exit(255)
    end

    ERROR_MESSAGES = [
      'Gem::RemoteFetcher::FetchError:',
      'Errno::ETIMEDOUT:',
      'Connection timed out - connect(2)'
    ]

    def self.run_bundler(env, argv)
      path = ENV['PATH'] || "/bin:/usr/bin:/sbin:/usr/sbin"
      path = path.split(':')
      bundle = nil
      path.each do |p|
        if File.exists?(File.join(p, 'bundle')) then
          bundle = File.join(p, 'bundle')
          break
        end
      end

      if argv.length < 1 || argv[0] != 'exec' then
        argv.unshift(bundle)
        Kernel.exec(env, *argv)
        return
      end

      status, rerun = 255, false

      begin
        IO.popen(env, bundle, *argv, opts) do |io|
          io.each_line do |line|
            $stdout.puts line
            ERROR_MESSAGES.each do |error_message|
              if line.include?(error_message) then
                rerun = true
              end
            end
          end
        end

        status = $?
      rescue Exception => e
        status = 255
      end
      return [status, rerun]
    end
  end
end
