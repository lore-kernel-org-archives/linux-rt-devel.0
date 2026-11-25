Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600514;
	b=rCxwf7eeJhXvnJeYeclZxRGp4ctmf4QgCBzvGMFagnYggMY36+w+CM16e90CLQkwY18I
	 eV1oR5AtB/vHRuWkF1JbYxBQkFsMEGAJk/odfIgb9mQeQVMXosgthr8sL1g6Y4r5++nmk
	 hL8yNbFmJOsIqp8jpIs36KCzh4u8EryZBa3tx1u6YNyeCAIDcKPZvn3+xrQXkc/NUBZCS
	 RGdyP6M+wtlpXZuyo1J0Au8Cm8kKT5SY3iZET2ginJcZAei0P8oaMXESUHi2TDhw8Iw/A
	 Ey64bf0UNwn46UzSH5ifpyMDUghoeGSKteN3vrXB9yuH0dEt7UUIpm67OvERgBtscEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600514;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=040FOdqnpTNASkay7M14wcibzu+az+nvPJ9a+Cwpw/Q=;
	b=tdoteVSNgEMwIgIVIVAHw894Nu8D4hF2vmjLlbJzBh1VrJVcI5yVe6maP1Lb4hmgnIKm
	 Pl6cSFjKpsv7kRSK1V1zmbgR9yy5witcbtGEai5E+XNbk7X8Jz4R8mVGGnnBla/Wu3aY2
	 vOX0fY6XGEti/uRWrFzkMhMoMOnMh4c1PZKW7U5PcBdIDxG9ZTQjjUZthvEPm/sSqm5cI
	 WRMdk5okOb7X/TY7DB2lKZawGEAvog/eHj7b0NqS5m7h7m2TSDoNzrIWUnePcTW8Ys+qs
	 r/PNbDIpEkU/gQwkxDHBxMScfKkpAFwtDIv3vg/7KsaGl4R1n0Y/ahdKIZ8mY/4yJLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HWLM3teW;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD782606A329
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 09:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD782606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HWLM3teW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795600513; x=1827136513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q9ObH0jG5UL8tjJetphdQtlshFhsvvHLNH8+nuFuwAU=;
  b=HWLM3teWCsTV7XSJfDWHiPaUVVFURnC4ELPzykEqvSawGPWLuDNVPn9+
   c8pIamcCkRVEbg7DFCMyqtCNScrzjmn0sn6xS1bW824hFV8cvURTezYTi
   qNBP2zGJkFA3NBsMP6nklUEoQ2XVrj6CzwU3aTU65JrlTStbfnB/tMmtZ
   sxmHhl9e65Pnm9NiR4vaVA9oAy+8lcoCkHyapLufmrBXMsorRJ8FAgurK
   cPyUo3M+IjrIiRzLFp0kgwSkRVmMDE0rITsFDRYfwTVVBSRYOZQ7LAAr9
   l6drqQ56fQfSfTKqF8CLvHMKTOEQvLSzT50/arnYnmnVAqsfSlsaq2djo
   g==;
X-CSE-ConnectionGUID: uEdDBC84Sn+LSzBqBPsDnA==
X-CSE-MsgGUID: OZWU/g+lRimnNwHsuSxoPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4384897"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4384897"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:53:54 -0800
X-CSE-ConnectionGUID: 4cNH+2CoR3W8LU1POLAoPw==
X-CSE-MsgGUID: 2ARkSPQQT5CvFBm3FVuIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11720277"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 25 Nov 2026 01:53:52 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 539A598; Wed, 25 Nov 2026 10:53:50 +0100 (CET)
Date: Wed, 25 Nov 2026 10:53:50 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: tcpm/tcpci_maxim: fix invalid wait
 context
Message-ID: <awawLjDE_AWj5Qkc@black.igk.intel.com>
References: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
 <20261123-max77759-wait-v1-1-6fa54a751bb7@linaro.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123-max77759-wait-v1-1-6fa54a751bb7@linaro.org>

On Mon, Nov 23, 2026 at 01:03:06PM +0000, André Draszik wrote:
> Lockdep reports the following with CONFIG_PROVE_RAW_LOCK_NESTING=y:
> 
>     [ BUG: Invalid wait context ]
>     swapper/0/0 is trying to lock:
>     (&dev->power.lock){-...}-{3:3}, at: pm_wakeup_dev_event+0x38/0x80
>     other info that might help us debug this:
>     context-{2:2}
>     locks held by swapper/0/0: 0, on CPU#0
>     Call trace:
>      _raw_spin_lock_irqsave+0x60/0x98
>      pm_wakeup_dev_event+0x38/0x80
>      max_tcpci_isr+0x2c/0x58 [tcpci_maxim]
>      __handle_irq_event_percpu+0xc4/0x4d8
>      handle_irq_event+0x4c/0x100
>      handle_level_irq+0xe8/0x188
> 
> max_tcpci_isr() calls pm_wakeup_event(), which acquires two spinlocks
> (spinlock_t): dev->power.lock and the lock of the device's wakeup
> source. On PREEMPT_RT, spinlock_t turns into a sleeping lock. Since the
> interrupt is requested with IRQF_ONESHOT, max_tcpci_isr() is never
> force-threaded and runs in hard irq context even on PREEMPT_RT. Taking
> a sleeping lock in hard irq context is invalid, triggering the lockdep
> report above.
> 
> Move pm_wakeup_event() to the interrupt thread max_tcpci_irq() instead.
> Drop max_tcpci_isr() altogether, since its chip->port check is already
> duplicated in max_tcpci_irq(), and request the interrupt without a
> primary handler.
> 
> Note: Moving pm_wakeup_event() to the interrupt thread doesn't allow
> the system to suspend before the event is reported:
> suspend_device_irqs() uses synchronize_irq() to wait for the interrupt
> thread to finish, and pm_wakeup_pending() is checked after
> suspend_device_irqs() returns. Once suspend_device_irqs() has armed the
> wake interrupt, the interrupt core reports the wakeup itself and
> doesn't call the driver's handlers.
> 
> Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index a19f52515429..6e202171f57a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -411,6 +411,8 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
>  	irqreturn_t irq_return = IRQ_HANDLED;
>  	int ret;
>  
> +	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
> +
>  	if (!chip->port)
>  		return IRQ_HANDLED;
>  
> @@ -430,18 +432,6 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
>  	return irq_return;
>  }
>  
> -static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
> -{
> -	struct max_tcpci_chip *chip = dev_id;
> -
> -	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
> -
> -	if (!chip->port)
> -		return IRQ_HANDLED;
> -
> -	return IRQ_WAKE_THREAD;
> -}
> -
>  static int max_tcpci_start_toggling(struct tcpci *tcpci, struct tcpci_data *tdata,
>  				    enum typec_cc_status cc)
>  {
> @@ -538,7 +528,7 @@ static int max_tcpci_probe(struct i2c_client *client)
>  
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
>  
> -	ret = devm_request_threaded_irq(&client->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
>  					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
>  					chip);
>  	if (ret < 0)
> 
> -- 
> 2.56.1.750.gf70dc682cf-goog
> 

-- 
heikki
