Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BF323416
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542583; cv=none; b=U9foc5i5xZPOSEpmPhnlv9y07VjBiIABY2GI6TzSt1Pfq4mMVCGPlQxPkXdv4+IntmPBhfTCk3uOiPa+uRGIkRu9VJ5hQ6yCCfO9uYNBpEqYLaAHZOPlYgIbOCPnJ5k7KLFp5H7M5U7ifQCUfL8MPJ4JFKiWd+dwogAOLkjeDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542583; c=relaxed/simple;
	bh=lwZ7tFuk2xGcbZJvUQYVvI94x5grKWoOnedNK+VyGPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgBB6PE4+dDnLKpDpChnbjaRVN/R0ndFeXATXTquqsJVEa03tK3BTT/TP0Wo+DGUMEgg6swnPoHQcXAvXzG8gV27LFL4eEnYZVyDWkDY6gHqYbb9OSfAK9ebIccjRS5biTFzyxum3KUz9QBF8ob6Duk0mMbFf1HZj+ObLWlhd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDxms7XL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDxms7XL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769542581; x=1801078581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lwZ7tFuk2xGcbZJvUQYVvI94x5grKWoOnedNK+VyGPE=;
  b=IDxms7XLZ+u13EDhk75qfVS/2zREYGgRc7sdc+Q1/LcKB6qfIP/GJpKQ
   qX94pzVOk2Vm3nldhAmfzOR/4tyXrVOw9ProqUpZOHrXcQm1rmw1YT1QK
   CypxQnbSFr/AgB27sj1gF1UHHCIBJInjKNi1ZjCi51gtNgsoFlD3a5TzT
   3LY28Do111bqfzxjanovwRbRDO4N85ULlEdAdHgg9kDWQzIyRldwEP7ut
   /b+B5MO6gMdwqXaiUJ6h76wzZJZBecde4pqlzNN/J6yzAQ/DQkkY4uwP4
   0PlcQLt63Y5BjrTlbVLPnynIqqWLgUlGOme9TOuf2GJumoSsaKFW+UeVe
   w==;
X-CSE-ConnectionGUID: EMUF8GY5SoiuDzcDMP8EmA==
X-CSE-MsgGUID: GzwQl0U6TY6+wWejgu6k9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69948833"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69948833"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 11:36:21 -0800
X-CSE-ConnectionGUID: HSrFaESzQfuct8EtPtrTOw==
X-CSE-MsgGUID: AQikmMI3S9OliG8t1FLuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208123482"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 27 Jan 2026 11:36:18 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6990795; Tue, 27 Jan 2026 20:36:16 +0100 (CET)
Date: Tue, 27 Jan 2026 20:36:16 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuewen Yan <xuewen.yan@unisoc.com>, linusw@kernel.org,
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, ke.wang@unisoc.com,
	wenhua.lin@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [PATCH] gpio: sprd: Change sprd_gpio lock to raw_spin_lock
Message-ID: <aXkTsMqZ4iZyVM0J@black.igk.intel.com>
References: <20260126094209.9855-1-xuewen.yan@unisoc.com>
 <20260126095024.ZEEwNmlk@linutronix.de>
 <CAMRc=Md+ptvRvknV7C4g2W_vpkfQmLkanKUqXzM8eYSe5ns1dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md+ptvRvknV7C4g2W_vpkfQmLkanKUqXzM8eYSe5ns1dQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 27, 2026 at 10:07:01AM +0100, Bartosz Golaszewski wrote:
> On Mon, Jan 26, 2026 at 10:50 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > On 2026-01-26 17:42:09 [+0800], Xuewen Yan wrote:

...

> > > There was a lockdep warning in sprd_gpio:

> > > [    6.258411][T329@C6]  el0t_64_sync+0x1c4/0x1c8
> >
> > This could be reduced to "BUG: Invalid wait context". The other bits
> > provide to added value.
> >
> > > This is because the spin_lock would change to rt_mutex in PREEMPT_RT,
> > > however the sprd_gpio->lock would use in hard-irq, this is unsafe.
> > >
> > > So change the spin_lock to raw_spin_lock to use the spinlock
> >
> > spinlock_t to raw_spinlock_t
> 
> I fixed this in git.

Not sure if you noticed the above comment by Sebastian and it's actually
documented in Submitting Patches that backtraces should only carry the
necessary information, so usually ~3-5 lines is enough and not two full pages
like in the commit as I see in the repository.

> Bart
> 
> > > in hard-irq.

-- 
With Best Regards,
Andy Shevchenko


