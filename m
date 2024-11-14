Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59A1EE021;
	Thu, 14 Nov 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580276; cv=none; b=Q3OlrHv5unvC8tfgHSHck0ivT57XzlWo99ZorsW7GGcwqYDxa7tfpbVK2u/hsHsfN5i6WXJJrqBK5ZK59sF4I2XqJEZRZv3bIj0fXDbRdPNrHYGu31PWKalHOa+R0eDliD1rY2zAe80kyB1bQvkb4ayKq5VWar0G8GUfIkdmKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580276; c=relaxed/simple;
	bh=vdG5CdVmokvHRFmN4/BRHQ7HBd/JDil+MdMmUXAwryQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2Rs1oAWxA1+VlSAUbqa8Glus83ZIjcpv9EriChpdioKYaTzsaF9VIu++MkOK6UnvpHEWylf6IzrrT7lDtDAnv5YVNh9NJoSxt7lXKM8A8JhqG13D0hyVk6gwhuSk8MSolBG6r8I+MgvN+HdBt5OK+JhASNdo+aGrc0w8uJsElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wof7wmYZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iztws1Dn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wof7wmYZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iztws1Dn"
Date: Thu, 14 Nov 2024 11:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731580273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9k7MkyhXpQ8X1mOy+ZQJnc57XAtBRbUaywuvlSv7pgU=;
	b=Wof7wmYZ/q9Sqcq1gVnXzRWYruqhfy0SQlNLInN9L/TVFIBISZBOdHIJUJBjqr1wYRwftx
	ZA8GK33s/npeDyUj4Q4hD3ojdFU7nvzmRNOvbpeJ3y7GhIdd6QmsNCC8kb07stbHkzVreN
	RrFAs3QInvmL096MH0TXHH4My9iAtfcOxAoX4jIEm9UUtQpyvYGV7+7bBF3Zxqc5gFPvDI
	fL4dP0sTcNOPA7thKUvogGagFSayffiEmqhOZkf88GnuAVp+cnw6R6l6i3DmQaonF07TBP
	55Kgyck46nRoSzhZB4/uslTcZndhJ5JBrRnLNpJfPwi8XQSuXRKlnBHP26ps4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731580273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9k7MkyhXpQ8X1mOy+ZQJnc57XAtBRbUaywuvlSv7pgU=;
	b=iztws1DnLbFwa0FPKRZhtJLchU1YUQjWSTDzgh7fYiVuSbxmVBS1ejiaZyOF5i03/QO+AO
	XLX/pF8nFGqGFZDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <20241114103111.5W5ZY0D4@linutronix.de>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108091545.4182229-4-chenhuacai@loongson.cn>

On 2024-11-08 17:15:45 [+0800], Huacai Chen wrote:
> It is really time.
> 
> LoongArch has all the required architecture related changes, that have
> been identified over time, in order to enable PREEMPT_RT. With the recent
> printk changes, the last known road block has been addressed.
> 
> Allow to enable PREEMPT_RT on LoongArch.
> 
> Below are the latency data from cyclictest on a 4-core Loongson-3A5000
> machine, with a "make -j8" kernel building workload in the background.
> 
> 1. PREEMPT kernel with default configuration:
> 
> ./cyclictest -a -t -m -i200 -d0 -p99
> policy: fifo: loadavg: 8.78 8.96 8.64 10/296 64800
> T: 0 ( 4592) P:99 I:200 C:14838617 Min:   3 Act:    6 Avg:    8 Max:    844
> T: 1 ( 4593) P:99 I:200 C:14838765 Min:   3 Act:    9 Avg:    8 Max:    909
> T: 2 ( 4594) P:99 I:200 C:14838510 Min:   3 Act:    7 Avg:    8 Max:    832
> T: 3 ( 4595) P:99 I:200 C:14838631 Min:   3 Act:    8 Avg:    8 Max:    931
> 
> 2. PREEMPT_RT kernel with default configuration:
> 
> ./cyclictest -a -t -m -i200 -d0 -p99
> policy: fifo: loadavg: 10.38 10.47 10.35 9/336 77788
> T: 0 ( 3941) P:99 I:200 C:19439626 Min:   3 Act:   12 Avg:    8 Max:    227
> T: 1 ( 3942) P:99 I:200 C:19439624 Min:   2 Act:   11 Avg:    8 Max:    184
> T: 2 ( 3943) P:99 I:200 C:19439623 Min:   3 Act:    4 Avg:    7 Max:    223
> T: 3 ( 3944) P:99 I:200 C:19439623 Min:   2 Act:   10 Avg:    7 Max:    226
> 
> 3. PREEMPT_RT kernel with tuned configuration:
> 
> ./cyclictest -a -t -m -i200 -d0 -p99
> policy: fifo: loadavg: 10.52 10.66 10.62 12/334 109397
> T: 0 ( 4765) P:99 I:200 C:29335186 Min:   3 Act:    6 Avg:    8 Max:     62
> T: 1 ( 4766) P:99 I:200 C:29335185 Min:   3 Act:   10 Avg:    8 Max:     52
> T: 2 ( 4767) P:99 I:200 C:29335184 Min:   3 Act:    8 Avg:    8 Max:     64
> T: 3 ( 4768) P:99 I:200 C:29335183 Min:   3 Act:   12 Avg:    8 Max:     53
> 
> Main instruments of tuned configuration include: Disable the boot rom
> space in BIOS for kernel, in order to avoid speculative access to low-
> speed memory; Disable CPUFreq scaling; Disable RTC synchronization in
> the ntpd/chronyd service.

If "rom space in BIOS for kernel" is a thing you should document it
somewhere or issue a warning at boot. I don't know what the latency
impact is here and if this is needed at all during runtime.

Why is ntpd/chronyd service affecting this? Is it running at prio 99?
Otherwise it should not be noticed.

Is lockdep complaining in any workloads?
Is CONFIG_DEBUG_ATOMIC_SLEEP leading to any complains?


> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Sebastian
