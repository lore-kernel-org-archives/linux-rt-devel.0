Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860222D5940;
	Wed, 14 Jan 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407906; cv=none; b=J0rDBSh6+ngRsC4feh4+q7WvAZXDTB0hxPn5baqz9l5IPoSKbGZjkDZWqBbIboalD4hK+yOmOo8ygaLY47aej0PrEzH1oQ16d7QHm3ILQmkXEL7ntwRE/CDQZr5DeVmZvP6g1f1vLd8Xfi63isb6X5vTb4hJmGKIgA3rgBDbw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407906; c=relaxed/simple;
	bh=F2VgcPqyHuUhbWpqo8TeO6os/XgKfmFxGplvGgMgn80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbOSDSMeP7ZFOyBjxqdLbGUJPho6sQL7PDi7cR8vtaBhhcDRk+Tin5MlAA6XsOKydueSheCLk0iX1+otTb7bCFdjG9y74REC3AE8gxH4FMdiOLQHiIkt37JslU7iQLcKMcvGu/07rT1WCAkCqO+FQhwqpFR6yOZZNecxtRRTf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3v/CDCV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3v/CDCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768407905; x=1799943905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2VgcPqyHuUhbWpqo8TeO6os/XgKfmFxGplvGgMgn80=;
  b=R3v/CDCVqY5xOmoFUGlPNgrEb4ytwwAc427Rx6mCMoahNh8ty7ypnHbF
   yRwgfSJKGlWMdnPqOfkV2BoLqHIG3jab3bT0jROyl/Ma0P956rvP0R6QB
   KZ48kPuGMnWWKNUjLsrwH/++ZQaLZ0wq9IXLn//R7ksr8xhpYh955gsbF
   nXLI0CaJn6vQYL+Dka2FHxYxeSoU4tNN4OSd+1ezadR5XZFFVkmEvvffY
   LrJVrTfm138jH+CNukYLcQ7Hkqb+L3Nm5nxf2F6EkevXlwSYs0JBCpy9Y
   kYgWevkCnjDCk9ioCzLxhW5SJF5tGX/VEo4Dm8k0IRqmcmbpcHJnWk2lV
   w==;
X-CSE-ConnectionGUID: HjhK2ViDSH+7ITK6StBgsA==
X-CSE-MsgGUID: WYy8qxnnRpiPG4vWNV5qCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69610904"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69610904"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:25:05 -0800
X-CSE-ConnectionGUID: k/wY7Qf9TGyO2mozsXsRcQ==
X-CSE-MsgGUID: JyfDNc2UT/yeTU6ZMNFmLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="205261971"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jan 2026 08:25:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vg3g1-00000000Gdw-34L8;
	Wed, 14 Jan 2026 16:24:57 +0000
Date: Thu, 15 Jan 2026 00:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Bert Karwatzki <spasswolf@web.de>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
Message-ID: <202601150006.r4sCNEZq-lkp@intel.com>
References: <20260114085113.21378-3-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114085113.21378-3-kprateek.nayak@amd.com>

Hi Prateek,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1f630297e183aa2abbafdbe8c4f916ee647e6e21]

url:    https://github.com/intel-lab-lkp/linux/commits/K-Prateek-Nayak/cpufreq-amd-pstate-Pass-the-policy-to-amd_pstate_update/20260114-165940
base:   1f630297e183aa2abbafdbe8c4f916ee647e6e21
patch link:    https://lore.kernel.org/r/20260114085113.21378-3-kprateek.nayak%40amd.com
patch subject: [PATCH v2 2/2] cpufreq: Pass the policy to cpufreq_driver->adjust_perf()
config: arm64-randconfig-001-20260114 (https://download.01.org/0day-ci/archive/20260115/202601150006.r4sCNEZq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601150006.r4sCNEZq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601150006.r4sCNEZq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0308]: mismatched types
   --> rust/kernel/cpufreq.rs:946:18
   |
   946 |             Some(Self::adjust_perf_callback)
   |             ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
   |             |
   |             arguments to this enum variant are incorrect
   |
   = note: expected fn pointer `unsafe extern "C" fn(*mut bindings::cpufreq_policy, _, _, _)`
   found fn item `unsafe extern "C" fn(u32, _, _, _) {cpufreq::Registration::<T>::adjust_perf_callback}`
   help: the type constructed contains `unsafe extern "C" fn(u32, usize, usize, usize) {cpufreq::Registration::<T>::adjust_perf_callback}` due to the type of the argument passed
   --> rust/kernel/cpufreq.rs:946:13
   |
   946 |             Some(Self::adjust_perf_callback)
   |             ^^^^^--------------------------^
   |                  |
   |                  this argument influences the type of `Some`
   note: tuple variant defined here
   --> /opt/cross/rustc-1.88.0-bindgen-0.72.1/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:597:5
   |
   597 |     Some(#[stable(feature = "rust1", since = "1.0.0")] T),
   |     ^^^^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
