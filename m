Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A527B353
	for <linux-rt-devel@lists.linux.dev>; Sat, 18 Oct 2025 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760817445; cv=none; b=JfAl4EIykCsddKu3VNUEB2TZhXUYTpcCHaXVcUMwdBIp/n/jnNVfUPmqbS+DFnLzf//RvI+xcHio2ujKwkZmshMaUcDEfFaYvZBMC7qRySMq+y8Q2behL0mpL5q2cXH7BVyKxXOtIkyFZ7ExNaRQpC3KvRPt63gBcIJAl8ojH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760817445; c=relaxed/simple;
	bh=C3CAlDvasJYb/FqzbSGerVnXeN+WXs2WxilVN3nwwuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi2/892BGW+mrqukz8pibgO9QvMkn3Nm9sxzMCBTtIQl5r9wYxQuwy50E1i2TSn/CI4Mhpm2QjvK/yzGxWkupjSs+vNgWGPPuu+z6xqkPDpiCwc7OY5XtzPqanuFURPwY4a84iHhUnNnNpoV5qMzLm/GtzmfwgVzcAWaRnly4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oa6QHPxB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oa6QHPxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760817444; x=1792353444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C3CAlDvasJYb/FqzbSGerVnXeN+WXs2WxilVN3nwwuI=;
  b=Oa6QHPxB4Rmd5SwB3QviI1WzqFSXSQwbKsm9s6KUkaMEgJj0w5CQYPsW
   ZokcovLwPbzOBAtrOawA1rQ9cr5odc7RUYdkzA3zhZRjish08CQ5SKpj3
   KYbSR74BtdtHsTuZ3Yisx4myF+lsXCDv1ulFeqbPAhR9UU9UgWPI4FnrR
   DH+aMVvUugd25D1+qCQgLNjg+HJa5YjaBB6t6j3My0CtZ2FY0Nbnh2ahJ
   TxCm3kxSB2GHMc9t9NuPTylaHLNJP9tiDPxSJAr35LzU1GCUWgRtiqyRI
   vncm9xEXEeWT8LhhlSppcyfCOQKLKN7QWPwYyjq5soqJ6ykWfdGF7Aj1S
   Q==;
X-CSE-ConnectionGUID: 2p16EA4zTFGj2OA1dycYnA==
X-CSE-MsgGUID: G7jPugKhQZ2tJE7Bt8YbJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62895120"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="62895120"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:57:24 -0700
X-CSE-ConnectionGUID: m6iXDhM9QlafJtnrrc72ew==
X-CSE-MsgGUID: AjgmE32zQBaIKSFOr1hV+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183013719"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:57:19 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAD3D-00000000xtg-45aS;
	Sat, 18 Oct 2025 22:57:15 +0300
Date: Sat, 18 Oct 2025 22:57:15 +0300
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
Subject: Re: [PATCH 3/3] i2c: designware: Support of controller with
 IC_EMPTYFIFO_HOLD_MASTER disabled
Message-ID: <aPPxG9SgxmHVgq_V@ashevche-desk.local>
References: <20251017-i2c-dw-v1-0-7b85b71c7a87@bootlin.com>
 <20251017-i2c-dw-v1-3-7b85b71c7a87@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017-i2c-dw-v1-3-7b85b71c7a87@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 17, 2025 at 04:59:34PM +0200, Benoît Monin wrote:
> If IC_EMPTYFIFO_HOLD_MASTER_EN parameter is 0, "Stop" and "Repeated
> Start" bits in command register doesn't exist, thus it is impossible to
> send several consecutive write messages in a single hardware batch. The
> existing implementation worked with such configuration incorrectly: all
> consequent write messages joined into a single message without any
> Start/Stop or Repeated Start conditions. For example, the following
> command:
> 
>     i2ctransfer -y 0 w1@0x55 0x00 w1@0x55 0x01
> 
> does the same as
> 
>     i2ctransfer -y 0 w2@0x55 0x00 0x01
> 
> To fix it, for the controllers that behave this way, if the next message
> to the same slave device has the same direction as the previous one, it
> is sent to the controller only after the previous message is sent and
> STOP_DET IRQ flag is raised by the controller.
> 
> This behavior is activated by compatible entries, because the state of
> the IC_EMPTYFIFO_HOLD_MASTER_EN parameter cannot be detected at runtime.
> Add the compatible entries of Mobileye SoCs needing the work-around and
> sort the entries alphabetically.
> 
> There is another possible problem with this controller configuration:
> When the CPU is putting commands to the FIFO, this process must not be
> interrupted because if FIFO buffer gets empty, the controller finishes
> the I2C transaction and generates STOP condition on the bus.
> 
> In a PREEMPT-RT kernel, interrupt handlers are by default executed in
> thread and may be interrupted, which can lead to breaking an I2C message
> by inserting an unwanted STOP.
> 
> To ensure proper operation on realtime kernel, use IRQF_NO_THREAD flag
> when requesting IRQ.

> Based on the work of Dmitry Guzman <dmitry.guzman@mobileye.com>

You may also use a tag "Originally-by".

...

>  static const struct of_device_id dw_i2c_of_match[] = {
> -	{ .compatible = "snps,designware-i2c", },
> -	{ .compatible = "mscc,ocelot-i2c", .data = (void *)MODEL_MSCC_OCELOT },
>  	{ .compatible = "baikal,bt1-sys-i2c", .data = (void *)MODEL_BAIKAL_BT1 },
> +	{ .compatible = "mobileye,eyeq6lplus-i2c", .data = (void *)NO_EMPTYFIFO_HOLD_MASTER },
> +	{ .compatible = "mobileye,eyeq7h-i2c", .data = (void *)NO_EMPTYFIFO_HOLD_MASTER },
> +	{ .compatible = "mscc,ocelot-i2c", .data = (void *)MODEL_MSCC_OCELOT },
> +	{ .compatible = "snps,designware-i2c", },

Sorting can be moved to a separate change (and while at that the inner trailing
comma can be dropped).

>  	{}
>  };

-- 
With Best Regards,
Andy Shevchenko


