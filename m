Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F681E1E0B
	for <linux-rt-devel@lists.linux.dev>; Fri, 31 Oct 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922389; cv=none; b=GSs3wUTIM+/o9N/crqn2RC9rnNwccgUbG538eDTpKp/EyFQQ0VHEbdQiQ6tYliXNFj/cqwteLBTSsP0QwXhAgVKtozFtzHks6J+a1Mgk0nd0DSoKhmvd7UIKeZps86BA5YZvNeDlvRhVj7tb92ikV+LkATse9yi0V1ol2jhd04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922389; c=relaxed/simple;
	bh=lov+vmbKoZkT3iZ5MDyWTKKzx+/OVKK/WuReUGp7jH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzH6mX8YcYotQF9Chm9S1q94knpLy8QB+XBrZSk9QPyPpKFOJzLltANAQjo7GzBoqOMch9Y2VIeXs1hwqyjpTcA6MFpfWfE+KryWqXYcbq58bZNzCw+F4aU6XhpFEKhZFaMY8vZCni/B65FeUaJivc9Z9QH664szwi9tJKAp3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJhH4YlE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJhH4YlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761922388; x=1793458388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lov+vmbKoZkT3iZ5MDyWTKKzx+/OVKK/WuReUGp7jH8=;
  b=ZJhH4YlE0bX3pCQXdGX1yDZlPjr1ro7ubI9/xWXaLRNLTpB6huOwZaVJ
   /SmwRXHZCEDCrgU3VU5Dx9nOJFEG1SGMF9OXmfwxbZ9g4FLeCiT5Rlg3o
   kTffkAqbDyS/PcUT8uGBUPG555kGjzThkfrtOslXr8E2J9iUxLKWWLL3c
   wOKe4DnKyz/HQ+icaFW4y8qm+GYHNUAVQI/OXHOr8KXumyC6mjzRYoGGP
   reVfg9Gjgne1ESTfmxirPkjohiIL3xDGsEtMvZGK0USOX6O0rgTFOkAGH
   UCdDFcWQIX3LNC6ApoELpcY0NXqi23kdRsCgzDj8I40Cwb1zflOTO1huO
   w==;
X-CSE-ConnectionGUID: +LuZlZGRSbSIUXTGpwcuRw==
X-CSE-MsgGUID: cwnpZjclRdy+O2b6z3yFAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="75201341"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="75201341"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:53:06 -0700
X-CSE-ConnectionGUID: 7Mj/o2sFSfSx0X2UfuffuA==
X-CSE-MsgGUID: NVNlY3PoQqmz4ngBEtueig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="216908680"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:53:02 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEqUq-00000004Iip-1OMj;
	Fri, 31 Oct 2025 16:52:56 +0200
Date: Fri, 31 Oct 2025 16:52:55 +0200
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
Subject: Re: [PATCH v2 3/5] i2c: designware: Sort compatible strings in
 alphabetical order
Message-ID: <aQTNR57ae-hGBPn0@smile.fi.intel.com>
References: <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
 <20251031-i2c-dw-v2-3-90416874fcc0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031-i2c-dw-v2-3-90416874fcc0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 03:35:41PM +0100, Benoît Monin wrote:
> Reorder the of_device_id structures so that they are in alphabetical
> order. Also drop the unneeded inner trailing comma in the
> "snps,designware-i2c" struct.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


