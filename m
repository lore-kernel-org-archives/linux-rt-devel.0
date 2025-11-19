Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881E3081D9
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Nov 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582726; cv=none; b=BeInLm0yTqIn2G9hsUD8O4by5SrjYK2OcwBuRJ7eNijF+YkgtHoU3+UzhLgdqi/gRL6s3Uy4Evjsqj5UWvlw+TnynJ/O5/3fJKIEIAdMhAyrg1G0woNw7g3apM11Ho7Rjmc348343JZguhfe9b+41hC4TTndD+Ia5BBimfKSpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582726; c=relaxed/simple;
	bh=58JJAYBmhecOlIksKrVjKgMTdqA1OoMhJ2vhGxjvb8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/86OxomtttYtwwFhOlGxNJPT+oiH8cGzyAYEg/5mkO6F/f8U+HN2tU4c9h03/uvIDrCWyNSNedo7D9q3sREgT7CEK3ZkrVGMV2g/yHDVC+OuAJnlXvvHpydb5GOFNCV01Mv/98t6X3tVVEwDk/EMnk+frtI8ZheGPkGf4m2PRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcgpHb+u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcgpHb+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763582722; x=1795118722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=58JJAYBmhecOlIksKrVjKgMTdqA1OoMhJ2vhGxjvb8M=;
  b=hcgpHb+u1CAMiu4crgjfv5ubGlX6NGlmq0Z92xyQQ3CgudHD3+sSgKUf
   /SVVyyUHXeVqdzq2lUPyVcbc/u1J2FqLIeiQBHUHltnKzq9o+lrNp8+DQ
   hPeAFtpu+gqgTAF7rfUWYtroGqszT9UHfNLwEPSdTsRUSQk/wmMbJy+YC
   VtH0gq4d1BuwhnRnJQn/sC32Y+qc6A3/a1braCGwy8Rlm2lQSxoK0sGgf
   k16Gwz/4safQsJ/KnKdIPyPplBrATNitVWSh9arvNcTf4sCDxkcOKi0DN
   zq/TnUc61babngEtJka9xAocb98zbe+AC2ag8AHbZBq7vAJn0a9vYBTTo
   A==;
X-CSE-ConnectionGUID: /pxxirxrSU+MveJJoDAfBg==
X-CSE-MsgGUID: 5HtcZHZ9Re+PRVP5bbGV2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="76316292"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="76316292"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:05:20 -0800
X-CSE-ConnectionGUID: 5SBGXruOTRuhCotE2+SCrw==
X-CSE-MsgGUID: CjKn2GOnS166hy9Ak2Y1SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191955972"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:05:16 -0800
Date: Wed, 19 Nov 2025 22:05:13 +0200
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
Subject: Re: [PATCH v3 2/7] i2c: designware: Optimize flag reading in
 i2c_dw_read()
Message-ID: <aR4i-fnWPpnhBHaQ@smile.fi.intel.com>
References: <20251119-i2c-dw-v3-0-bc4bc2a2cbac@bootlin.com>
 <20251119-i2c-dw-v3-2-bc4bc2a2cbac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119-i2c-dw-v3-2-bc4bc2a2cbac@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 04:05:31PM +0100, Benoît Monin wrote:
> Optimize the i2c_dw_read() function by reading the message flags only
> once per message, rather than for every byte.
> 
> The message flags are accessed both in the outer loop and the inner loop,
> so move the declaration of the local flags variable to the outer loop.
> 
> The message index is only modified by the outer loop, so reading the
> flags in the inner loop was always getting the same value.

OK.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


