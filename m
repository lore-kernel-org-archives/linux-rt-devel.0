Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F831E1E0F
	for <linux-rt-devel@lists.linux.dev>; Wed, 26 Feb 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558576; cv=none; b=I/DTW1qQpjRqdUfeb89AOrCe9h+B1qfbu2bxF98Pie7DevV1ZKZZh/YfREiVYi94i3Brs0ihxizkMVdlBgzjUdXL60hlrpFregzUQ2gbR1dcxznzjrB6QYtxP7hVK2P1cC5VZEURWjclpxq5F7j8KtnwYD4aL9pH3SSIobK3N58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558576; c=relaxed/simple;
	bh=RL30Pp+x27pQ6VdoOBnCGDXZwzGVw2Dvuj1jGbNVQ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbcUxdw4+niixMVLDDzTJLhhoEzcqjdQDobz+OOckzaGDMaExHplfvhZFM5tTPfobLVKr4Hgtvfe+PK/77gEIvIPurPwjFqAUZKuDtsh0NzpV95txCb8LZzcR1OK1PQLowpD03hNGWAlhm6wLoZY1OsL7SlE9DAkAK19MIJ5oMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gc0p9kTK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gi+rkCH1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gc0p9kTK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gi+rkCH1"
Date: Wed, 26 Feb 2025 09:29:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740558573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwWpGxilYiF2FM26W1JaazrlwiSWSwm+svJOYKjovKI=;
	b=gc0p9kTKtMNTobyJFmU4W4ITXwXapmQYNuYFPUCvRGDKMeVIJL3oIVi4dOWSte3u6M8Y41
	rv6ZxbeP4jUBzarrZ1qndKuKp/ROf54k+9tRReYFA8WkubwuJMrEwwj9rmdzZs5fgmK0tA
	mT8a4h3JrGcoFEPH67udCn43+6MOH7eGNeCTtFIYmzoD8Ytc5WIO57+s86v0ilwXDhEZMu
	V/K2ZfsdiU8G6vmGjPtwvyB/9RHlt6bMdw1eW2xceH1YCswH7TtD0r4fpjmvGRlZbWWgth
	WzZieTI4y6KEY9uGv5MnT9DZ5pT0MYPgo1WLk+/61d1nBFodq99tRyHdpFvvvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740558573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwWpGxilYiF2FM26W1JaazrlwiSWSwm+svJOYKjovKI=;
	b=gi+rkCH1Rl/zSsS24JFZZnWFJ4dwoNt83GriE9ghfh8nNypDXTAZJ0h5T8CuLpDPL6zBs7
	k4Fug1FT7N++02Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: linux-rt-devel@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>,
	Frank Li <Frank.Li@nxp.com>, Ferry Toth <ftoth@exalondelft.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] usb: gadget: u_ether: prevent deadlock under RT
Message-ID: <20250226082931.-XRIDa6D@linutronix.de>
References: <20250219181556.1020029-1-ralph.siemsen@linaro.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250219181556.1020029-1-ralph.siemsen@linaro.org>

On 2025-02-19 13:15:52 [-0500], Ralph Siemsen wrote:
> [   71.106003] task:irq/507-s-f4000 state:D stack:0     pid:125   tgid:12=
5   ppid:2      flags:0x00000008
> [   71.106018] Call trace:
> [   71.106022]  __switch_to+0xf4/0x158
> [   71.106046]  __schedule+0x2b4/0x920
> [   71.106055]  schedule_rtlock+0x24/0x50
> [   71.106064]  rtlock_slowlock_locked+0x348/0xcb8
> [   71.106077]  rt_spin_lock+0x88/0xb8
> [   71.106086]  eth_start_xmit+0x30/0x1490 [u_ether]        /*****/
> [   71.106112]  ncm_tx_timeout+0x2c/0x50 [usb_f_ncm]
Explicit softirq timer as per HRTIMER_MODE_REL_SOFT

> [   71.106131]  __hrtimer_run_queues+0x180/0x378
> [   71.106143]  hrtimer_run_softirq+0x90/0x100
> [   71.106151]  handle_softirqs.isra.0+0x14c/0x360
> [   71.106165]  __local_bh_enable_ip+0x104/0x118
> [   71.106177]  __netdev_alloc_skb+0x1e0/0x210
> [   71.106192]  ncm_unwrap_ntb+0x1ec/0x528 [usb_f_ncm]
> [   71.106206]  rx_complete+0x120/0x288 [u_ether]           /*****/
Network stack

> [   71.106221]  usb_gadget_giveback_request+0x34/0xf8
> [   71.106236]  cdns3_gadget_giveback+0xe4/0x2d0 [cdns3]
Returns URB to usb-core.

> [   71.106286]  cdns3_transfer_completed+0x3b0/0x630 [cdns3]
> [   71.106320]  cdns3_device_thread_irq_handler+0x8b8/0xd18 [cdns3]

Threaded interrupt handler. Not forced-threaded but voluntary threaded
due to devm_request_threaded_irq() usage.

> [   71.106353]  irq_thread_fn+0x34/0xb8
> [   71.106364]  irq_thread+0x180/0x2f0
> [   71.106374]  kthread+0x104/0x118
> [   71.106384]  ret_from_fork+0x10/0x20
>=20
> The deadlock occurs because eth_start_xmit() and rx_complete() both
> acquire the same spinlock in the same instance of struct eth_dev.
> The nested call occurs because rx_complete() calls __netdev_alloc_skb()
> which performs a brief local_bh_disable/enable() sequence.
=E2=80=A6

Based on the backtrace the problem is within the cdns3. The driver
acquires at the beginning of its threaded routine
	spin_lock_irqsave(&priv_dev->lock, flags);

and then before returning the URB it does
	         spin_unlock(&priv_dev->lock);
                 usb_gadget_giveback_request()

so the lock is dropped but the interrupts are still disabled. This makes
me wonder why using threaded interrupts at all since interrupts are
disabled for the whole routine but then others do the same.

If you look at dwc3_thread_interrupt() they have local_bh_disable()/
enable() before acquiring the lock and this is what I would suggest
doing here, too. The NCM is probably not the only one affected but
everything doing network that may since it may recourse into softirq.

Sebastian
