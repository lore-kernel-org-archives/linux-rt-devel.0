Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF991F8909;
	Thu, 14 Nov 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583822; cv=none; b=qLRpybuTjnsANddbCM3QqNzR2LyFR5W2m22/F8gF0s91Oct5jstV7QESjbOWUutBoYdkJli86v3WypFdCCsOKOj2zj9OjKu6EkENSHsBhcF0zXJG+fZPjQuNpvusrUAFAANQQ1q4be1syVQmRsQkUn1tiLOqAfLc6YVyP2IFdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583822; c=relaxed/simple;
	bh=wNcFrtWrs3hAo9466ybp1NI2dm6XDdO7sIRLxrmRhQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJfM/mffgp064suKBtVhEHqZR0Vz50l9WxGL9NOMwqB1G/3yLeo6F8hAQLee5AVAju3RsMugKlN1BKikUkuoqPf2D5FM8cO+KT7WH72JeGayOKy6VkSmLEP5vGDXwVEXmiHMSjfdmHtd1Mqv8fySxa91tZ6CBAQ3PlbJ0ilrcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uzLybEb0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbWdbrm3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzLybEb0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbWdbrm3"
Date: Thu, 14 Nov 2024 12:30:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731583819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wNcFrtWrs3hAo9466ybp1NI2dm6XDdO7sIRLxrmRhQ8=;
	b=uzLybEb0/J0Q50gOadLxS0TFDyETxOo1l/Qnl8pSOIz9LDLC9MO8rgTImOiRb0bfqNV6DC
	pPY42XKbq0WEL4rpjeNAQdyO4fzx6SE79TsBC+0mTaFuNb6J0GmKoB/bg4lYD9oWHSjwzT
	GWBepx58jij2EM2zd3P2jGf/sb3Xm3jpU6xq4kJuIpwRIcN63AATIL8liPPtVEUt2uMuaC
	o7EvYrEp0GRSwLrb7oUNCzIT4bLFwaS5xq/gODKVUtfuFtC8a/eybMLEh3l/GUGbVEMxVq
	EGj27qlkpUIpNiH58QuOkGFToPGpOsdGYPDL5/xf9qGUQY4T4ruBBTBX/JWZ3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731583819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wNcFrtWrs3hAo9466ybp1NI2dm6XDdO7sIRLxrmRhQ8=;
	b=KbWdbrm3iVK0iog/B1klb+IWMfrSPBqO5wV5Pg5ecJQD0os5J93Euu/yFJ5IMbEmqumNvs
	wfJ1orHn1EMYqsDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <20241114113018.Ilo9ZsQo@linutronix.de>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn>
 <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
 <20241114111409.LWKp5YEg@linutronix.de>
 <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>

On 2024-11-14 19:19:26 [+0800], Huacai Chen wrote:
> > > > Why is ntpd/chronyd service affecting this? Is it running at prio 99?
> > > > Otherwise it should not be noticed.
> > > No, ntpd/chronyd doesn't affect latency. But they may trigger RTC
> > > synchronization every 11 minutes, and RTC synchronization affects
> > > latency. We can keep ntpd/chronyd running but disable RTC
> > > synchronization by configuration, this is the least aggressive method.
> >
> > What is "RTC synchronization" in this context?
> Means the sync_hw_clock() function in kernel/time/ntp.c, it can be
> enabled/disabled by chronyd configuration:

But what exactly is sync_hw_clock() doing that is causing a problem
here? The clock on HW is updated. The access to the RTC clock is
preemptible.

> Huacai

Sebastian
