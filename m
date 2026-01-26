Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6632D438
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420781; cv=none; b=UtNgURhJhOFdAGY9yJpZBqDXYh2/qe2fom1ySgagsjvg+1sEFoO2pmgyCaTMNifU7xlJqZQ4I/jCxR4kn3jOPE5vBqYsp0BUA7yZGehn/rf93UDXbuPIZ/ws/gZCBCHxVKgwXwNKNTN/0pKz0iF9x5J0lDpx0K+SGc1UtsFnimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420781; c=relaxed/simple;
	bh=69v3EeEElcdbjQ6yA4BpdwUn4muHBV+XGmeNjd3qmKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjPqY+5KzKh+puWlhqg2dV2vmKM7O6JDPKJwjEAKzHOy+d21Nz7j5JbD4Ik0tN6ZrnFdm1mUBJUNFpTAKG2SFZgtiDkoiobeOG+EThRaOOHrfs7j09G6h0VnHD5ozteu67Y42tvjNgzLHRbghq+KoFVgWn6Jwjl1bRa06fAdaW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEXA/90f; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEXA/90f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769420779; x=1800956779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=69v3EeEElcdbjQ6yA4BpdwUn4muHBV+XGmeNjd3qmKc=;
  b=EEXA/90f53B7zixO6zCNg/pMhdBywvUcJ1OVLgvToPZp0k/RYNGsXJUU
   fEOK8JIvbJOrOPc+NDc02hBM9wz8mOXg32CtV+Muq6bRo3qvnUn86Uy+N
   We98uuC8opNOJnMAVSSSwtIhSdulnSIrXxvU48ubZBQ2LPbH1kzE6GlXA
   4/iRCNH3xYMKfHKeCFnTbztVtKSkLcvD7/cWey3n0g+0GDkA3xZWxxiWQ
   sCHDraZZsqKY3dQfXQELvgmX6bRubhSE2oi+F2R/svN3ex9y0W2ybr4t2
   749ROujUepy27kORUg05zeEziWWrdhUHjVrA6tmGq9vcln5s1VhWC+454
   w==;
X-CSE-ConnectionGUID: FQ+Ay28xQWeJneDekGfUZA==
X-CSE-MsgGUID: zPIsqjyaSyuhH7Fcxp/Kkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="58170107"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="58170107"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:46:15 -0800
X-CSE-ConnectionGUID: li3+BzuJRHmnzKynxrM9UQ==
X-CSE-MsgGUID: yed/uQX/SxS6tcnnPPHlog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207887061"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:46:13 -0800
Date: Mon, 26 Jan 2026 11:46:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <aXc346Nr_C4sybE5@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
 <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
 <20260126080119.AEjgGgaw@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126080119.AEjgGgaw@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 09:01:19AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-23 16:52:59 [+0200], Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 12:37:03PM +0100, Sebastian Andrzej Siewior wrote:

...

> > > Cc: Lee Jones <lee@kernel.org>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: patches@opensource.cirrus.com
> > > Cc: Mark Brown <broonie@kernel.org>
> > 
> > Cc list can be moved out from the commit message.
> 
> If I move it out, the list won't be CCed.

Please. elaborate. It works for me. I use `git send-email ...`

-- 
With Best Regards,
Andy Shevchenko


