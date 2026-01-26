Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA1332EB6
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426921; cv=none; b=dvnc+Ty2syfogM0cdEXyW+1uzusgfb3Iqj+Ka2/YYVXdfn6gDsheeQuOB7G61iH7OJ3cddCl/khuCqdur/eaAKC5JNNrqoc86snYAVOjwnX6qcnA2HrPlc10WC0eJ/9sz3EElrCstx0oohWypt7HbVhsuSRf5o7u/M/AKSdTfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426921; c=relaxed/simple;
	bh=KNM95+EXc+fBVPaK2inhYVBpJnNXWe36XPtjeDK5BKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbqoVllJ8vNyj+esJ9lbPDfOH5NAKQtpj+skSZLMRQ/ESrfLWSIxbCllrfE9ImL5uavy8rh1yMwHnOx2HniHb+BZtW3KH2zWfSKGZ9E9/vN4Ccqq7pr091gil9u3X83neL5yv7NwOebVcKQ9+fsgj7bk5EhkSlTIUiw1CnRpKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqP7noLF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqP7noLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769426920; x=1800962920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KNM95+EXc+fBVPaK2inhYVBpJnNXWe36XPtjeDK5BKk=;
  b=HqP7noLFmj2Nl05PylGQ8cn2SlTh9pAP5rSLG6LTj5efarLAUKo0BwVT
   f9O9yOSFDXgH2fgs9hUYwWdOB2JdqMbrll6+hT2wiHCbMt8tnkv4GtiWj
   Toc/bsX4v8bOKa4qcfZ63jssPSl4YXINBfGUxCgqjg91u+vpiATE4H6eC
   bc2kNdtp/FSSaSpW9b+BsSZuQIkIAiu+brhMQI4E+o0+YfXZQhgh/1sw/
   IltYEjCKgyEGm5tutVEEr3VFSpgpP754YbsBR4ghEx7VhhOk6/LVPjD1u
   NZ1IrDm8xJ6jvqQp23SPJQYO8hDkC472HySLOhGb+3vkLknO+I4rQn5w2
   g==;
X-CSE-ConnectionGUID: sPjrz/V5SSWCNEsJkV6BNQ==
X-CSE-MsgGUID: BnsoEVLHQ1CkPzCDJ02jzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81712430"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="81712430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:28:39 -0800
X-CSE-ConnectionGUID: K5VePRBlQqyj9+V2DAKyTw==
X-CSE-MsgGUID: EgyCTzGqSFyG18IwtIKOkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="212130714"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:28:37 -0800
Date: Mon, 26 Jan 2026 13:28:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <aXdP4xWP_Gu50Zog@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
 <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
 <20260126080119.AEjgGgaw@linutronix.de>
 <aXc346Nr_C4sybE5@smile.fi.intel.com>
 <20260126095613.vgkhGpdh@linutronix.de>
 <aXc8WYH0p9Hr-yz9@smile.fi.intel.com>
 <20260126101308.TOAFAQsM@linutronix.de>
 <aXdOYg5TUZrbD441@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXdOYg5TUZrbD441@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 01:22:14PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 11:13:08AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-26 12:05:13 [+0200], Andy Shevchenko wrote:

...

> > > > or will be imported via git-am.
> > > 
> > > Yes, that's the idea. `git am` will strip them out. But why would you need to
> > > apply via `git am` locally? You can pull from the tree.
> > 
> > I fetch from the list to pick up the tags, fix some of them up as the
> > iio but most of them remain the same. Then I post the v2. Where do I get
> > the Cc from? So I add them manually again?
> 
> Nope, I just checked how `b4 trailers -u ...` works. It does the correct thing.
> What did I miss?
> 
> So, for the matter of test I took this one:
> 20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev
> (as a *single* change).
> 
> In my tree I corrected it to look like this at the end of the commit message:
> 
>     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>     Signed-off-by: Sven Peter <sven@svenpeter.dev>
>     ---
>     Cc: Janne Grunau <j@jannau.net>
>     Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>     Cc: Neal Gompa <neal@gompa.dev>
>     Cc: Hector Martin <marcan@marcan.st>
>     Cc: Linus Walleij <linus.walleij@linaro.org>
>     Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>     Cc: Rob Herring <robh@kernel.org>
>     Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>     Cc: Conor Dooley <conor+dt@kernel.org>
>     Cc: Sebastian Reichel <sre@kernel.org>
>     Cc: Lee Jones <lee@kernel.org>
>     Cc: Marc Zyngier <maz@kernel.org>
>     Cc: asahi@lists.linux.dev
>     Cc: linux-arm-kernel@lists.infradead.org
>     Cc: linux-gpio@vger.kernel.org
>     Cc: devicetree@vger.kernel.org
>     Cc: linux-kernel@vger.kernel.org
>     Cc: linux-pm@vger.kernel.org
> 
> Then I ran
> 
> $ b4 trailers -u 20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev
> Finding code-review trailers for 1 commits...
> ---
>   + Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>     https://lore.kernel.org/all/aB3_Kw6WDaDAY6Ub@blossom
>   + Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>     https://lore.kernel.org/all/CACRpkdbCfUEZd06yeZTNecGFPwBgJkpMH3hqkvJw4J%2BiSENG%3DQ@mail.gmail.com
> ---
> Press Enter to apply these trailers or Ctrl-C to abort
>   dt-bindings: gpio: Add Apple Mac SMC GPIO block
>     + Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io> (✓ DKIM/rosenzweig.io)
>     + Reviewed-by: Linus Walleij <linus.walleij@linaro.org> (✗ DKIM/linaro.org)
> ---
> Invoking git-filter-repo to update trailers.
> New history written in 0.08 seconds...
> Completely finished after 0.38 seconds.
> Trailers updated.
> 
> Then I looked at `git show` again:
> 
>     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>     Signed-off-by: Sven Peter <sven@svenpeter.dev>
>     Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>     ---
>     Cc: Janne Grunau <j@jannau.net>
>     Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>     Cc: Neal Gompa <neal@gompa.dev>
>     Cc: Hector Martin <marcan@marcan.st>
>     Cc: Linus Walleij <linus.walleij@linaro.org>
>     Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>     Cc: Rob Herring <robh@kernel.org>
>     Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>     Cc: Conor Dooley <conor+dt@kernel.org>
>     Cc: Sebastian Reichel <sre@kernel.org>
>     Cc: Lee Jones <lee@kernel.org>
>     Cc: Marc Zyngier <maz@kernel.org>
>     Cc: asahi@lists.linux.dev
>     Cc: linux-arm-kernel@lists.infradead.org
>     Cc: linux-gpio@vger.kernel.org
>     Cc: devicetree@vger.kernel.org
>     Cc: linux-kernel@vger.kernel.org
>     Cc: linux-pm@vger.kernel.org

FWIW, I ran `git format-patch` and reapplied locally to test how maintainer
will see it:

    Add the DT binding for the Apple Mac System Management Controller GPIOs.

    Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
    Signed-off-by: Sven Peter <sven@svenpeter.dev>
    Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

diff --git a/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml b/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml

So, everything works as intended.

> P.S. `git am` is for maintainers, not flexible for the contributors.
> 
> > > > If you continue to nitpick here, I could do it for the next iio
> > > > submission assuming it will be picked-up by iio maintainers. But doing
> > > > it just for the single mfd patch looks like too much work.
> > > 
> > > I'm thinking of all the patches.

-- 
With Best Regards,
Andy Shevchenko


