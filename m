Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0034D3BD
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176638; cv=none; b=o7EvqkQnv/8L9q7XZ5Ru8QTblb1bmvIftPl8hOiCp9uWu07Rb8krS6Iv3dmqM/Ec19ztQpiULCpDB/2emrrO7rOqw+IwizGvdVni1jSr1RIfXc+A1NHijbgo1BRJJJqtW5N1kEWQuuDOhORFRDERTdZTo5BpMJQspvUFL2eOhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176638; c=relaxed/simple;
	bh=xrurQH3MSBJFB/YxXitmgCZhswQbfHrLHt3WRy/0VnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LebyI94vj8YON6OzZcTLFBxZUe/HfasRN9n8AC4Y2Wbr0gPGOk0U10Gn3kkIlTESNwu02M8Ze/jVNURkHiuoCa5yqoGN9xZsv1FX26WYporKm5w8dhyufUvgK4fiGen8nzqQVjqnEYdS+JK+brxpiiYAQSppPNJM7bJpdJ7SCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gz1RF0Gu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gz1RF0Gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762176638; x=1793712638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xrurQH3MSBJFB/YxXitmgCZhswQbfHrLHt3WRy/0VnU=;
  b=Gz1RF0GuVWgw8jkVe8tQUYrEf35CW7DohL+u20WwBAZIYVRlTDeHclfg
   HO1T71vj1w+gaS5x/qBzN/OPylqCtAeMQLLwfew+L8FI81SJejx/zumQO
   sZoULQtTixw2VkTGvEtvQq9YPMXuaQwgVAMbl/ds3jSc7bJBYK9myaXEy
   9CCdJp09//aiCPsmIDlnCt44OG64u34+0Ubh7oIawb4GqcdYKe1ppICoo
   LcHFI9aGHS/umSERpjyF4Fms1PIsAckGbwJrSQd8HJZZv22NT+aX8DKsn
   +eygsDIYhhWTZxGRD27wp/+Nba1Lnlacddohdy8+a09dLVavDb1cHk4K+
   Q==;
X-CSE-ConnectionGUID: GX1svOXXTRyW9JGhH3lwgg==
X-CSE-MsgGUID: zphq6RUuTim0V6ANtfRy/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75361070"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="75361070"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 05:30:37 -0800
X-CSE-ConnectionGUID: UodqWzqaQWa6JTrN63nClg==
X-CSE-MsgGUID: AKh+yjX6QJCGuB1yCLRU1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186821328"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 03 Nov 2025 05:30:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CFE0996; Mon, 03 Nov 2025 14:30:31 +0100 (CET)
Date: Mon, 3 Nov 2025 14:30:31 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
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
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 5/5] i2c: designware: Support of controller with
 IC_EMPTYFIFO_HOLD_MASTER disabled
Message-ID: <20251103133031.GJ2912318@black.igk.intel.com>
References: <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
 <20251031-i2c-dw-v2-5-90416874fcc0@bootlin.com>
 <20251103104330.GG2912318@black.igk.intel.com>
 <aQisNF9Fk-FODLFB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQisNF9Fk-FODLFB@smile.fi.intel.com>

On Mon, Nov 03, 2025 at 03:20:52PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 03, 2025 at 11:43:30AM +0100, Mika Westerberg wrote:
> > On Fri, Oct 31, 2025 at 03:35:43PM +0100, Benoît Monin wrote:
> 
> ...
> 
> > > +	return (msgs[idx - 1].flags & I2C_M_RD) == (msgs[idx].flags & I2C_M_RD);
> > 
> > You don't need the outer parens.
> 
> Priority of == is 10, while & is 11.

Indeed, agree. Then nevermind that comment :)
