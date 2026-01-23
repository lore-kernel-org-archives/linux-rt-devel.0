Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F1330D26
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179985; cv=none; b=oPyZra9QR/iJhAU23oRxJ4B8IQLRNFce6cQisF//ErksnuDWd4TUvCICdzbMbiDOek9k8cBfpoq9g+UaWiwgXRsqejCP7+uUza6Usd/UCqm/oldBxHRFVNfA2QtiyI2JYggzc89ZM6hJkaAA1higqqDT3Y2qaE1jJ2fD1Et19o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179985; c=relaxed/simple;
	bh=X3hFvP1pyFnmXIjVDsCEH2q1ElKZajfO6BylD7ROVwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW4LUrPUKNzJgqmVo/V4spnqJX7j0cXeKyERCWV8ZqLSYs1buULESU2Dh7swFq+jnP92qDh8BWepQIVNYWlLOkk9L7kwR5SqZYVPRIuqAN+zZYlREvNgPoLxqoGlvcSyEWE1iwgQWSXxVAXSATiqgRgwc7xzaV0EQEoKwMfJNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2i7i0Oc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2i7i0Oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769179984; x=1800715984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3hFvP1pyFnmXIjVDsCEH2q1ElKZajfO6BylD7ROVwk=;
  b=G2i7i0OcQ6m33BCCX62SEPrts5uFRpbPJnrBriXO4jCV7TMno/8Gynbv
   pP6JapfNtfmv9REZbWIKy93GAMjFOKF9mPr5nDtde683Wx/60136GwgNl
   F/7qC8jHXclu7UihaYJf2l5Bg8PcHIx1VhdK9ei2FXgbGgjVeKx5Vgp4d
   MZqp6ft/R9vCVomsk8/pYTpsqDHs1TwLE6TFpUnXDB4BDcWFXkqgZVtuD
   qS15KiqRRowloiiDlDrs4/ofyTR6ySPqbJFqwuiU3jl2FbJ19XoXRh+tv
   Jp0UKsS3NXUGYpmItPWAfMZ79q9Ij8EzJAPvlh1AOwYHUGBKc8qyXnYxX
   Q==;
X-CSE-ConnectionGUID: p1avJTiyTDK76PrDFYbCoA==
X-CSE-MsgGUID: kxyca8RyTyOQCcqasSNAAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="58006058"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="58006058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:53:03 -0800
X-CSE-ConnectionGUID: 51xaXEbAScKC2xQqs1Vt2g==
X-CSE-MsgGUID: XvtqPptwQQurk329AYkfDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="212042236"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:53:01 -0800
Date: Fri, 23 Jan 2026 16:52:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-18-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 12:37:03PM +0100, Sebastian Andrzej Siewior wrote:
> Using a threaded interrupt without a dedicated primary handler mandates
> the IRQF_ONESHOT flag to mask the interrupt source while the threaded
> handler is active. Otherwise the interrupt can fire again before the
> threaded handler had a chance to run.
> 
> Mark explained that this should not happen with this hardware since it a

"it is a" ?

> slow irqchip which is behind an I2C/ SPI bus but the IRQ-core will
> refuse to accept such a handler.
> 
> Set IRQF_ONESHOT so the interrupt source is masked until the secondary
> handler is done.

...

> Cc: Lee Jones <lee@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: patches@opensource.cirrus.com
> Cc: Mark Brown <broonie@kernel.org>

Cc list can be moved out from the commit message.

-- 
With Best Regards,
Andy Shevchenko


