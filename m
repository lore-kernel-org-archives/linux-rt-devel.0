Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984C2EA46D;
	Wed, 13 Aug 2025 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073296; cv=none; b=bHT5WgJyJtvfPYLNz7sTNng+0f+Wtjqn7Q9HEjEPEvWgqVDA8Vv/ntDT336bW1yMdgdoXqgb6grdQYwElUWwDucxeKncrdIK4j7FFWx91yw1VByYWEgbcdTIb0yhMH9bfzY+P4Cf0Da5Vqufp5Qft0XCdbTYHgYq5sunXNZL1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073296; c=relaxed/simple;
	bh=rDDxNyVDTajL4EF9VAKq0BLlpJPF2zJqeb4lAxYADJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCBnjlZGtCtC4i04E85T6T/HcFuX0XsV8AHiaGawJhe4tBAq7oUw2lKUjryNZEkSPETYVXpobfoSSBpORED3CXlzPt2+J8R8rxhZpQqTMdiN7wx7xWhI3fIt2SfGS3TY+tGcKdW8sMPX/rzM7uUxFMnIqCdiNa8w9Rnl7e8cUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiM+p6ka; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiM+p6ka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755073294; x=1786609294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rDDxNyVDTajL4EF9VAKq0BLlpJPF2zJqeb4lAxYADJE=;
  b=RiM+p6kaBDwrfGw3vcL+P9IjEIRup2kot218pX4/DAoorCcQqsns792v
   +IfhlUxScc/nwMm5utBegy/Jx561E9cIHn+wiws1cealu+1hqFioUNKOs
   Hrc+QriXO0aAnA4UG3CQPYVnwnMXzYmi+2ZVZyTeEvizfoqJIIW3VgyVN
   7J7unNuWFt+GeU8zSNVf98PJLwg88kSMvN7iA1YkXMAe8Itiw4wpY/t2v
   tj/kZOnD2g1/T3bJ6MXljdWNxsOrsFAs2x88FZJRq0WwPnQ8FRROigndE
   NfhzTG9AsvSjyM544ubyUHmV3xofFVHiCP9tecaeQ3pUAMJ2GMGcoX+28
   Q==;
X-CSE-ConnectionGUID: GxqymPOTRTmdW2xLQJyqeA==
X-CSE-MsgGUID: A2KT4OpkT/Obi2iwfPihBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56386686"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56386686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 01:21:34 -0700
X-CSE-ConnectionGUID: 2OmNiBG3Q8a3fKVxVGztOw==
X-CSE-MsgGUID: iTY/g4UnRReMEJNxq2+png==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166786869"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 13 Aug 2025 01:21:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um6jg-0009hg-2h;
	Wed, 13 Aug 2025 08:21:28 +0000
Date: Wed, 13 Aug 2025 16:20:59 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <202508131652.C4118cYh-lkp@intel.com>
References: <20250812143930.22RBn5BW@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812143930.22RBn5BW@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc1 next-20250813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/softirq-Provide-a-handshake-for-canceling-tasklets-via-polling-on-PREEMPT_RT/20250812-224928
base:   linus/master
patch link:    https://lore.kernel.org/r/20250812143930.22RBn5BW%40linutronix.de
patch subject: [PATCH] softirq: Provide a handshake for canceling tasklets via polling on PREEMPT_RT
config: csky-randconfig-002-20250813 (https://download.01.org/0day-ci/archive/20250813/202508131652.C4118cYh-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250813/202508131652.C4118cYh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131652.C4118cYh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/softirq.c:853:13: warning: 'tasklet_callback_cancel_wait_running' defined but not used [-Wunused-function]
     853 | static void tasklet_callback_cancel_wait_running(void) { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tasklet_callback_cancel_wait_running +853 kernel/softirq.c

   850	
   851	static void tasklet_lock_callback(void) { }
   852	static void tasklet_unlock_callback(void) { }
 > 853	static void tasklet_callback_cancel_wait_running(void) { }
   854	static void tasklet_callback_sync_wait_running(void) { }
   855	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
