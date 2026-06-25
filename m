Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210E3E7BB0
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400923; cv=none; b=Mwbo0u7jwmMJd9jF4ZbOasmYXF0Ll2RN97b9PnrzVV2TLkUUe8KP+VtXmfMNGs0I9No2zzBJhPKHePz5EdwaOa/aW0Pmxtu8YPr6R4HYob9ChiQcSp03hGY3hT2327Ga58TaEGV9E9SMI1aCHVuPB2cFurYtr/wP7EBqVs+IZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400923; c=relaxed/simple;
	bh=qGASeWrw3Q0JH+3NyM/hQ57cFZx0OzH1Nam1V6yYrh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkcCWDuAw4UZpmuGtcjpA7LDSSSN4Tv2uz629EVRx40yYbo3rW78SsK4F+TcOTtOIQGbJwDBUAA6cUXc7mKBOFDabgllDXRjjHD/Kz97kLw7oqjcBzvsuuKZuomIsH8pCAOIeGu10GNrxy6PH0B8v4cQlswAN3ElAkFKHYNd5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wdr6LBaS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7K3nlttq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wdr6LBaS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7K3nlttq"
Date: Thu, 25 Jun 2026 17:21:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782400921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhk31X59jGlwpV3n9u1wFAXzkVVHxC5YGpn2MFlFHLY=;
	b=wdr6LBaSrc6/cZA6cLZtB5pVzF1GA/PqBASb6CDpNB/Nu/LzwciFL2xWrAnK7pP7CawBbj
	ciEWOWtovG41x9TEPSbUOzfqzt5Sd3FLnt9Sx4GPZ3qJFsQl0sNXXuFm8bTe05LeUhlpz2
	AQpr/fyHDqSTlkYRogJ7KdEyWDvndk3BIEapgxy9jKLI9mvZ3KXtepsSkwQtFBIF16l/6Q
	BT9jDY40MBvg6aXEntL1cCv3thzdCi5tWTscMnsyDqRheghh8AGTdPsuLzVLQs2BJaxHA9
	KgxuHJ+8ibiAjv+kId7vTiEGvplM3hnqQ6Vw+58JhKF4ZI00zjo1XYZlekejJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782400921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhk31X59jGlwpV3n9u1wFAXzkVVHxC5YGpn2MFlFHLY=;
	b=7K3nlttqc5EEzWofyJOS/pgw2pz+WrZmUjAQRP6zMP7rPQMCTibC2HivO17r9kapZDs+If
	PsZQPM5tnQR+HPCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, clrkwllms@kernel.org,
	rostedt@goodmis.org, linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <20260625152159.WtO_S3i7@linutronix.de>
References: <aj0BpqlaCh3cVw8Q@shell.armlinux.org.uk>
 <20260625122612.43501-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625122612.43501-1-xieyuanbin1@huawei.com>

On 2026-06-25 20:26:12 [+0800], Xie Yuanbin wrote:
> ```c
> 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
> 		return;
> 
> 	if (likely(user_mode(regs)))
> 		local_irq_enable();
> 
> 	pr_alert("8<--- cut here ---\n");
> ```
> or
> ```c
> 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
> 		return;
> 
> 	if (likely(interrupts_enabled(regs)))
> 		local_irq_enable();
> 
> 	pr_alert("8<--- cut here ---\n");
> ```
> 
> Which one do you prefer? I prefer the first one, because for kernel
> fault, kernel may have encountered a serious issue,
> and enabling interrupts may be not appropriate.

Why would the latter be not appropriate?. 
Anyway, in the kernel case you do die() which disables interrupts as of
oops_begin(). It does later restore the state in oops_end() and invokes
make_task_dead(). This one will complain if either preemption or
interrupts are disabled and reset both.

Should you get that far and not panic() earlier (due to in_interrupt()
for instance) then interrupts will be later enabled before that kernel
thread is killed. So it could be done earlier or not, at this point the
system is pretty much done.

Sebastian
