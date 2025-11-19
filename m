Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E53176F2
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Nov 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578015; cv=none; b=mmgO45o6zQBWz5wto0TTRRtcEkEjJUHsPQg3bbGx+q9SJZmgymv+mO9H/YCXx3El6pEvtedhqpW9WCM/uNdVtQxZ56QtaMI6Mf/NcBrCiLavBn0eDTXE3SV6CW/7646G454FF8mvnzZmx5DQDNfJtv258KdrldWayb6NkGprwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578015; c=relaxed/simple;
	bh=+L5dqYe4lbCTZNCO1ARmj3AGtDovp1AJchwoTDUFXvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDcRmvlvRoVV9vznjmefLmG12kD+feVY/sBeHNJSyuQreu9kG/7s3RT25yvv8NZb4sJfRHfH9VwP/NGSAIo6W6iy5KH53olnas0v5u/NWSsgOc2rG67aw4QTuRlg5M8UkDl0HAFoaXLb0/uQHovpTXlBQxaeqyXOH2yaJbj1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8FmaDmQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8FmaDmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763578009; x=1795114009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+L5dqYe4lbCTZNCO1ARmj3AGtDovp1AJchwoTDUFXvA=;
  b=V8FmaDmQGxd0VUij9SYU7IbfBK1LoCnzrNj9N8Tduonm/W0kdzp+LFTS
   p2KS3BbHXGsdDVtTETPugH25lD4KPMhzi/fVJZewfJfINcj0A9MogIkQ6
   ZSi20U8TgtoxhzTnPQKB0TMEYb1WtMgBJ0l5j2b3L+x5TQps44xnRWdZ+
   RPj0EWXmBZVBB8ENt4G4x5mqCPzHEcZdXKY3z3ng4nKVNp5RIXHj9DUXZ
   NJQnyEZceIRdnbup0Yxb6Ip+zH057LVlwrW3QE1ISjlodAGgi8l3IXH2B
   8mltvl09MWZN1r37NSVNR/5ZhjNbbjWonrwBjGICu6yAvamZT4ktlb7lD
   Q==;
X-CSE-ConnectionGUID: 8xO6Bt26QZuV2mmpXMAyiQ==
X-CSE-MsgGUID: fyqBPefJSdiXY/1iKCgaOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65573184"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65573184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 10:46:45 -0800
X-CSE-ConnectionGUID: HcqK3a3nQWCfPjIVvrmbNg==
X-CSE-MsgGUID: fu3L7RF7SOmj4p82+bkv2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="222068970"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 10:46:40 -0800
Date: Wed, 19 Nov 2025 20:46:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Dmitry Guzman <dmitry.guzman@mobileye.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 4/7] i2c: designware: Use runtime PM macro for
 auto-cleanup
Message-ID: <aR4QjtJqfZGN2_jw@smile.fi.intel.com>
References: <20251119-i2c-dw-v3-0-bc4bc2a2cbac@bootlin.com>
 <20251119-i2c-dw-v3-4-bc4bc2a2cbac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119-i2c-dw-v3-4-bc4bc2a2cbac@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 04:05:33PM +0100, Benoît Monin wrote:
> Simplify runtime PM handling in i2c_dw_xfer() by using the
> pm_runtime_active_auto_try guard. This adds the proper handling for
> runtime PM resume errors and allows us to get rid of the done_nolock
> label.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM and order kept the same, shouldn't regress.

-- 
With Best Regards,
Andy Shevchenko


