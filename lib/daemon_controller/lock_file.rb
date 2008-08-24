# daemon_controller, library for robust daemon management
# Copyright (c) 2008 Phusion
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

class DaemonController
class LockFile
	def initialize(filename)
		@filename = filename
	end
	
	def exclusive_lock
		File.open(@filename, 'w') do |f|
			if Fcntl.const_defined? :F_SETFD
				f.fcntl(Fcntl::F_SETFD, Fcntl::FD_CLOEXEC)
			end
			f.flock(File::LOCK_EX)
			yield
		end
	end
	
	def shared_lock
		File.open(@filename, 'w') do |f|
			if Fcntl.const_defined? :F_SETFD
				f.fcntl(Fcntl::F_SETFD, Fcntl::FD_CLOEXEC)
			end
			f.flock(File::LOCK_SH)
			yield
		end
	end
end # class PidFile
end # class DaemonController
