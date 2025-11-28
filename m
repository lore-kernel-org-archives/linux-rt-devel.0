Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704D2C08CB
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Nov 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314368; cv=none; b=qY9N3IVQn1k2VHAsLauL95mx90ldrh1dh6c4rmVBHt+41FIOwvEYQdCWMre4kqdcTKBC8JoONVV7fVinVhIb7JA01qnTBpab4Slf31Bssyh60JM+GVUPeF0BnttOx5W/IcvuO9IhcKH7vfi7L2QVpRyzUI6mjLTEx0EEDyRHxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314368; c=relaxed/simple;
	bh=46/udGBccKTCWu2bDFQe4uYCsNXACon1T2esAT+O8rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmV0UVKZDFEuBIM6xT/t5Nndw4SsrKn/C4cW9LWHHtD8InIg2M8RpksiIc2HWrvt953V9Brbm3X0XYODyGy1hyWEMBHem3uMyQYyvZl1KfN/l6inFbhId2fLKQByG5yJgaALuLCqLY0s9B5B3c5lwG9QgUcCTkrNsFAW/afj4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmBTH9OT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmBTH9OT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764314365; x=1795850365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=46/udGBccKTCWu2bDFQe4uYCsNXACon1T2esAT+O8rQ=;
  b=CmBTH9OTEF5mfMJofvS9zy4J+1xFEurixJWEXJxM8bJJHY9TrFVZntd5
   SDNeXQ33ofds332sUYlyq1PfAADwvrJs+o9z39t1BMgumLXRhsHkayPWG
   dqJTxXKbDp3JBWs3BErwXRiYXbGV/+0y3xY0ScSC0Y1wewFCWIAlIfJC8
   ZhK9wQ7ag1TC+aUTmazBjfWHv6VYtlKvB59U7ERY6w4ew7FQF9pf7NlZG
   IEc4LguVOqthbZ8jkMDNwio7NQqnnYAHUXv9OXrAiePYrGKQDQ7zZfGN4
   BgK24qptei1b0sGL/Gu7JnfrHqR48X8OyXNc68hyo2dBQVfAEFjUA9fbb
   A==;
X-CSE-ConnectionGUID: lHivH4RjRkShMEemSEPaCA==
X-CSE-MsgGUID: wmpTeKy1SsOs/xrJhi2UCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="77707373"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="77707373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 23:19:24 -0800
X-CSE-ConnectionGUID: bYzWvcD+SHK3vhpLBErs8Q==
X-CSE-MsgGUID: je9/Vqt8TOyDit1rPPBh7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="198353882"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 27 Nov 2025 23:19:14 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8B3F3A0; Fri, 28 Nov 2025 08:19:08 +0100 (CET)
Date: Fri, 28 Nov 2025 08:19:08 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Dmitry Guzman <dmitry.guzman@mobileye.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 0/7] i2c: designware: Improve support of
 multi-messages transfer
Message-ID: <20251128071908.GA2580184@black.igk.intel.com>
References: <20251126-i2c-dw-v4-0-b0654598e7c5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126-i2c-dw-v4-0-b0654598e7c5@bootlin.com>

Hi,

On Wed, Nov 26, 2025 at 11:46:23AM +0100, Benoît Monin wrote:
> Add support for the I2C_M_STOP flag to the .xfer() function of the
> designware driver. This allows grouping multiple accesses in a single
> call and changing the target address after a STOP flag. This is achieved
> by splitting i2c_dw_xfer() in two functions. The core logic handling
> the transaction is now in __i2c_dw_xfer_one_part(), while i2c_dw_xfer()
> loops over the messages to search for the I2C_M_STOP flag and calls
> __i2c_dw_xfer_one_part().
> 
> Handle controllers that lack the ability to emit a RESTART when two
> consecutive messages have the same address and direction by aborting
> transfers that contain such a sequence of messages. For those controllers,
> we also check that we do not get any unwanted STOP caused by a Tx FIFO
> underrun, as they lack the ability to hold the clock during a transaction.
> And we set the irq as non-threaded to prevent underrun on PREEMPT-RT
> kernel when filling the FIFO.
> 
> The I2C controllers found in the EyeQ6Lplus and EyeQ7H SoCs from Mobileye
> lack such capability, so a compatible string is added because this cannot
> be detected at runtime.
> 
> This patch series also brings four cleanups:
> * Optimize the read of the message flags in i2c_dw_read().
> * Sort the compatible strings alphabetically in dw_i2c_of_match[].
> * Simplify runtime PM handling in i2c_dw_xfer() with guard.
> * Add a dedicated i2c_algorithm for AMD NAVI controller.
> 
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>

All look good to me now, thanks! I also checked that this did not break
anything -> my laptop I2C connected touchscreen & touchpad still works.

For the series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
