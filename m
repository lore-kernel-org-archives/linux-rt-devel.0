Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17A1F936
	for <linux-rt-devel@lists.linux.dev>; Fri, 31 Oct 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922144; cv=none; b=kW+fzvKi4S3vCwFuR1qDAm5TSlZd/vZPaXe7RuRSmzZzG5T4fRgwFQxd4r/O0U0zKqI7GR+nDUN2pDkVKLU3wyrv678BKMUWn1TxmuavK70+sWKJkZa+EGcShhNp1a0erCSkZOURsqxx67KlULOKdng1mGwhUVplEKY/EFSiECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922144; c=relaxed/simple;
	bh=4/b7FZ+TKpOI5vWj+Cp7E9hBNkbAZuI1fJ/uXfz3C6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnkfGiVqND6ajOyeKPuUSphv7UPPy1YlDcG8I3gzoWPMHE8jhGUjtOnJ+5p15cQKzivBvZAwSeegOr2WT0EN95w6SweiodjaWrRBZSvq/iU/jZF4P6ZZ6b3ixnNO0Dkp6si91y7QlLlMVaMtXPvgTzq8I69H3ukdQNHjP7/EJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZ/IG1nA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZ/IG1nA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761922143; x=1793458143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4/b7FZ+TKpOI5vWj+Cp7E9hBNkbAZuI1fJ/uXfz3C6M=;
  b=EZ/IG1nAR5JijqABpQ8YJDRr/ot4i9ZArY1X980Bhy1KBZSq3nRHNPJq
   NdFMEFLMt8rrGgNlCvIw9o9K4AIFr/ygsM7DyknU7Yo2JbuV9sLqibozP
   xhjtoWD35REJTZ4YhxyBkKKiwTs9ValuNlQZC7wN6Ey7MAoXYFJdBkA2v
   2z0cPSKzLH62xsDHk2Zt1ql0arNd8PKYPLdDDqH3nZblZLG9OZhKzxJms
   LjwUKDv7UJlO6Hw44XUKVdZtutS0D06wzyZqNA57ycQM4B6adXd7VLJQ+
   12gWGtxgF0snDcQs+ILXfvl/pH6AsZOh3yljzOGOSTccWnbvgQZMuMyQF
   w==;
X-CSE-ConnectionGUID: no5eO7w0Rr2WtZnbH4uOvw==
X-CSE-MsgGUID: WfIQmRNpRd+zfqT/92eDLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="81713361"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81713361"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:49:01 -0700
X-CSE-ConnectionGUID: 7qosfd/ETsCowL6MpyUuDA==
X-CSE-MsgGUID: wHl6uhR0T0iDPn7r6vJ3dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186189303"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:48:57 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEqQt-00000004Ie3-0pCb;
	Fri, 31 Oct 2025 16:48:51 +0200
Date: Fri, 31 Oct 2025 16:48:50 +0200
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
Subject: Re: [PATCH v2 2/5] i2c: designware: Optimize flag reading in
 i2c_dw_read()
Message-ID: <aQTMUrMbfgs59oBQ@smile.fi.intel.com>
References: <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
 <20251031-i2c-dw-v2-2-90416874fcc0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031-i2c-dw-v2-2-90416874fcc0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 03:35:40PM +0100, Benoît Monin wrote:
> Optimize the i2c_dw_read() function by reading the message flags only
> once per message, rather than for every byte.
> 
> The message index is only modified by the outer loop, so reading the
> flags in the inner loop was always getting the same value.

Does it affect the binary (compiled) file?

-- 
With Best Regards,
Andy Shevchenko


