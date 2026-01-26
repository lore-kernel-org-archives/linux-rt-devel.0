Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285330149F
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421919; cv=none; b=HHk0NBhUsKEVDGSMohvBttNP6PfFNChMLxxSOuivuBNXd1+kaNjpyavl7com5HpWbv9nBjWgeqAKIxKAHnz3Vfx/eYuv3y7rsTQ/J/vmrigRMzfjI63iMHRUnOvTN6EWraoQ8UEPAe9+sb9L50OB/Pe99EmMdwLL3KY3at/if5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421919; c=relaxed/simple;
	bh=fzSpNKLiEnZjcZwGXSIEgYDGzVjEl3rIioOjxZpOs6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVLIiUVneyw7sQenoDcyT1xC8cJLSGfCOCC8xFAdStEzVQWtqpV+DWUda7AKxLqcxhWXv1rD0Ycd5/5AVkmUVmKJYu46/Y6J/CKZkHifcLpfXljSo5rbkSXGrcAGYf1lDDGEliz18ndQywK2aQVA858472bwCER+EUKGt3AGHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKqboTaA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKqboTaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769421918; x=1800957918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fzSpNKLiEnZjcZwGXSIEgYDGzVjEl3rIioOjxZpOs6c=;
  b=lKqboTaAF5/QTGcVe2lci4VqP1HH1P2NdA/Tvw+um4q0J/+uneVizDMe
   oiIZLK7vQmr/kDBROANLq1I5SQ6mT9krMotN636rXJwCeavTe6RAb7Hq6
   xcQM1ZhdC8J5WNbgAO+VqMVN/Cz9A3mEc53a/g4XvPjOQQ4XT1qYYMxaS
   6JE48YVG4lt3nI/75i5EtT/it2rZHkWf1zE0Ee52VeSCvj3wdB+76nbkG
   f9zzB+BNmyqkvPacCXRQ2EU4I6Wa5JELbQUw/zRCHOn7bOXcJhaa+Tf+R
   6KASgMRY/xJligUy+InQNZs0cHFc30I9uF8KlmBLCJYp3XUxt6fwCIpNc
   w==;
X-CSE-ConnectionGUID: DYwzHnC7S1mv6+0Z7iXIKg==
X-CSE-MsgGUID: V8vOHmtFRbe6BWUTnuYzjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70755816"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="70755816"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:05:17 -0800
X-CSE-ConnectionGUID: PFfx4EqESi+IuLaPgko1Uw==
X-CSE-MsgGUID: vb3qZLAmQvew2xd1DZ2K8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207528936"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:05:16 -0800
Date: Mon, 26 Jan 2026 12:05:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <aXc8WYH0p9Hr-yz9@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
 <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
 <20260126080119.AEjgGgaw@linutronix.de>
 <aXc346Nr_C4sybE5@smile.fi.intel.com>
 <20260126095613.vgkhGpdh@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126095613.vgkhGpdh@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 10:56:13AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-26 11:46:11 [+0200], Andy Shevchenko wrote:
> > On Mon, Jan 26, 2026 at 09:01:19AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-01-23 16:52:59 [+0200], Andy Shevchenko wrote:
> > > > On Fri, Jan 23, 2026 at 12:37:03PM +0100, Sebastian Andrzej Siewior wrote:

...

> > > > > Cc: Lee Jones <lee@kernel.org>
> > > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Cc: patches@opensource.cirrus.com
> > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > 
> > > > Cc list can be moved out from the commit message.
> > > 
> > > If I move it out, the list won't be CCed.
> > 
> > Please. elaborate. It works for me. I use `git send-email ...`
> 
> Yes that works. But I have to move it every single patch and I have 20
> and the number of Cc:es varies. Once I move it there, it won't be there
> on the next git-format-patch

`git format-patch` uses the commit message verbatim.

> or will be imported via git-am.

Yes, that's the idea. `git am` will strip them out. But why would you need to
apply via `git am` locally? You can pull from the tree.

> If you continue to nitpick here, I could do it for the next iio
> submission assuming it will be picked-up by iio maintainers. But doing
> it just for the single mfd patch looks like too much work.

I'm thinking of all the patches.

-- 
With Best Regards,
Andy Shevchenko


