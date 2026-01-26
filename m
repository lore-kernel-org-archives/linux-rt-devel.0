Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898A332904
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426538; cv=none; b=ow/ND7CQjh7YriJ+Ju+Z4EqyMAKJI93s64S4RDGMHj/gn+UkE4iVaKxshVwwLxR/OKdKeUefzr+MXs6ZGn0p0/BIhhtcjvUdg0gBrUpKG6nDW53/C2Cu1wWfs2ZudPjIQUvqBbpGmGStUzmM65CqotDgZJ6UKyLtdprJ8U6gdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426538; c=relaxed/simple;
	bh=qLNiB/rFm4RbEBwVu+FDZXVy3UPMUxh2mP2zsCr51ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZQT0Yb0xJBcy8CRQbiDHaLyoclruS2ihBRj3ElFRJf6LoM7XwgEWae4vLG60zf2WxQQXDTZS7Itu733M3We4QmS0djF7hHSDOJ6FV0dQCX6eV/vMACTRNvtXJyLMlX1QcgH/+A95u+Jq8LbSzloI9Xug4Mj25UzNk1zOyC6wLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsentvUx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsentvUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769426535; x=1800962535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qLNiB/rFm4RbEBwVu+FDZXVy3UPMUxh2mP2zsCr51ko=;
  b=ZsentvUxy3DUgRFsIiUt2dJrcT2HWcGz96ZTOMDZMRZmGIprDVhK3oyw
   B02XyHge1DC4seQilhFkC8ZpJR8apFZtHLXJWy9oa8SQPwoSkPKhjuzm1
   a4gsT8ymGfLM53jwTD+bxtK+J21RI+YGNdYCfAOoUh/fiUiU8D1OVzEhn
   azYnK2+3G8r9d1p8CoifIX2ysYLNOYTjFGkftNBDbuCFZz6g256yz56I1
   tG9C2PwGkZxshAgH5BBcROiVQRFxkgrx9EGEOxc0y1dMPcBtiBU0hpTrK
   zxkVnqRYB4jb1o/NPXGhWDB7H4pP6GY6EH8/isy2U9uwIRro3JvlO2Zxl
   g==;
X-CSE-ConnectionGUID: SPVPLG/xQWelR5vqEzaxiw==
X-CSE-MsgGUID: ptjnVfhIRAeUZBuorO75Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81320005"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="81320005"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:22:14 -0800
X-CSE-ConnectionGUID: 3gCj+IkoQQmMVD6TQfic6Q==
X-CSE-MsgGUID: EUCVp5JITxO/qNpdkvhI3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207907246"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:22:13 -0800
Date: Mon, 26 Jan 2026 13:22:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <aXdOYg5TUZrbD441@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
 <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
 <20260126080119.AEjgGgaw@linutronix.de>
 <aXc346Nr_C4sybE5@smile.fi.intel.com>
 <20260126095613.vgkhGpdh@linutronix.de>
 <aXc8WYH0p9Hr-yz9@smile.fi.intel.com>
 <20260126101308.TOAFAQsM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126101308.TOAFAQsM@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 11:13:08AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-26 12:05:13 [+0200], Andy Shevchenko wrote:
> > > or will be imported via git-am.
> > 
> > Yes, that's the idea. `git am` will strip them out. But why would you need to
> > apply via `git am` locally? You can pull from the tree.
> 
> I fetch from the list to pick up the tags, fix some of them up as the
> iio but most of them remain the same. Then I post the v2. Where do I get
> the Cc from? So I add them manually again?

Nope, I just checked how `b4 trailers -u ...` works. It does the correct thing.
What did I miss?

So, for the matter of test I took this one:
20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev
(as a *single* change).

In my tree I corrected it to look like this at the end of the commit message:

    Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
    Signed-off-by: Sven Peter <sven@svenpeter.dev>
    ---
    Cc: Janne Grunau <j@jannau.net>
    Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
    Cc: Neal Gompa <neal@gompa.dev>
    Cc: Hector Martin <marcan@marcan.st>
    Cc: Linus Walleij <linus.walleij@linaro.org>
    Cc: Bartosz Golaszewski <brgl@bgdev.pl>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
    Cc: Conor Dooley <conor+dt@kernel.org>
    Cc: Sebastian Reichel <sre@kernel.org>
    Cc: Lee Jones <lee@kernel.org>
    Cc: Marc Zyngier <maz@kernel.org>
    Cc: asahi@lists.linux.dev
    Cc: linux-arm-kernel@lists.infradead.org
    Cc: linux-gpio@vger.kernel.org
    Cc: devicetree@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    Cc: linux-pm@vger.kernel.org

Then I ran

$ b4 trailers -u 20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev
Finding code-review trailers for 1 commits...
---
  + Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
    https://lore.kernel.org/all/aB3_Kw6WDaDAY6Ub@blossom
  + Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    https://lore.kernel.org/all/CACRpkdbCfUEZd06yeZTNecGFPwBgJkpMH3hqkvJw4J%2BiSENG%3DQ@mail.gmail.com
---
Press Enter to apply these trailers or Ctrl-C to abort
  dt-bindings: gpio: Add Apple Mac SMC GPIO block
    + Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io> (✓ DKIM/rosenzweig.io)
    + Reviewed-by: Linus Walleij <linus.walleij@linaro.org> (✗ DKIM/linaro.org)
---
Invoking git-filter-repo to update trailers.
New history written in 0.08 seconds...
Completely finished after 0.38 seconds.
Trailers updated.

Then I looked at `git show` again:

    Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
    Signed-off-by: Sven Peter <sven@svenpeter.dev>
    Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    ---
    Cc: Janne Grunau <j@jannau.net>
    Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
    Cc: Neal Gompa <neal@gompa.dev>
    Cc: Hector Martin <marcan@marcan.st>
    Cc: Linus Walleij <linus.walleij@linaro.org>
    Cc: Bartosz Golaszewski <brgl@bgdev.pl>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
    Cc: Conor Dooley <conor+dt@kernel.org>
    Cc: Sebastian Reichel <sre@kernel.org>
    Cc: Lee Jones <lee@kernel.org>
    Cc: Marc Zyngier <maz@kernel.org>
    Cc: asahi@lists.linux.dev
    Cc: linux-arm-kernel@lists.infradead.org
    Cc: linux-gpio@vger.kernel.org
    Cc: devicetree@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    Cc: linux-pm@vger.kernel.org

P.S. `git am` is for maintainers, not flexible for the contributors.

> > > If you continue to nitpick here, I could do it for the next iio
> > > submission assuming it will be picked-up by iio maintainers. But doing
> > > it just for the single mfd patch looks like too much work.
> > 
> > I'm thinking of all the patches.

-- 
With Best Regards,
Andy Shevchenko


