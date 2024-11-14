Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA61E485;
	Thu, 14 Nov 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591000; cv=none; b=OEEoKJvsuNmf89bYnSzMefgiLDvHbZzs8t8o0FMvei9ToHp+l0rrcS8EB5JMEgvGcnY16GWnzJs1Z3Vf3aoSft8A09Yf6ENICXE2kkoqxHei1ekg1MbcmjMUZBzqLfZwGNFgiy+LOeqStjP/bgLXlxh65wr617wYKhx8KbROYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591000; c=relaxed/simple;
	bh=fpwH0qlxTUI1SUkfWWAbZyerVOs+Aa1kMRn+YqcxFM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sImWZGcilxZ+BbBhtSZfdTlgz7jFOJHBsLlN5SYrAF6hyASpKpiwDKz1yTiYwac8VSLWSchQGaLOf+wQdc2ICRexQJya+x7DfE+Q/wpKSRGrh+y8Z+wD+FtWMi28PNqs5ToqyO9f3M52P0XzZTuyLzYq89fR57dGaV0t0Qmrwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fX8S5Sdb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+B1g1otn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fX8S5Sdb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+B1g1otn"
Date: Thu, 14 Nov 2024 14:29:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731590997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpwH0qlxTUI1SUkfWWAbZyerVOs+Aa1kMRn+YqcxFM8=;
	b=fX8S5SdbAX9dNqKCns/US9h2DPLksZnd6/b0vFEDn5Da3FUOPsvsrQC7GYSHkPcTIx/0Vu
	idnpAH+3hE71Je7nouonUgitzskj75xnCdO/0ICql9RZLkxrYEs75f6G78frGAu5TnJd7T
	Crcj8X1f6J2eoSARdlEHSWuDxoxMKBVhHCVO8RuFK8mhoodlgOWWpHgRq40qxc2XtdIlV+
	HTnrViDJdGFqawjzpeDWKRQMt4JYEdkeruf3BtI3vi9f6rV1uyDYg4AxjJBEAeQChfvUvI
	NuVCBHdA9+/5cD5UX5ySxflLtciHZSjkWTZwnfgd9qHZNscxD2JhDB8DId1b7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731590997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpwH0qlxTUI1SUkfWWAbZyerVOs+Aa1kMRn+YqcxFM8=;
	b=+B1g1otnAu2TOseAY1qA8NMRuawkhGLequANchGtJI02CeofW9/ByKve4/B7Vp6wR7Ol9j
	cnuXZDzW3ydP7FAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <20241114132956.wafcHvaB@linutronix.de>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn>
 <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
 <20241114111409.LWKp5YEg@linutronix.de>
 <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
 <20241114113018.Ilo9ZsQo@linutronix.de>
 <CAAhV-H4jDNG8nsW30U9zE1-c6dHwy2fSjy5hkZhpWWu3=og64A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAhV-H4jDNG8nsW30U9zE1-c6dHwy2fSjy5hkZhpWWu3=og64A@mail.gmail.com>

On 2024-11-14 19:36:38 [+0800], Huacai Chen wrote:
> On Thu, Nov 14, 2024 at 7:30=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-11-14 19:19:26 [+0800], Huacai Chen wrote:
> > > > > > Why is ntpd/chronyd service affecting this? Is it running at pr=
io 99?
> > > > > > Otherwise it should not be noticed.
> > > > > No, ntpd/chronyd doesn't affect latency. But they may trigger RTC
> > > > > synchronization every 11 minutes, and RTC synchronization affects
> > > > > latency. We can keep ntpd/chronyd running but disable RTC
> > > > > synchronization by configuration, this is the least aggressive me=
thod.
> > > >
> > > > What is "RTC synchronization" in this context?
> > > Means the sync_hw_clock() function in kernel/time/ntp.c, it can be
> > > enabled/disabled by chronyd configuration:
> >
> > But what exactly is sync_hw_clock() doing that is causing a problem
> > here? The clock on HW is updated. The access to the RTC clock is
> > preemptible.
> This is a platform-specific problem, our RTC driver is
> drivers/rtc/rtc-loongson.c, the write operation to RTC register is
> slow.

Ach okay. So the pure read on the slow bus causes a delay because the
CPU is stalled. That is not limited to chrony but should also have an
affect if the user uses hwclock to read/ write the time.

> Huacai
=20
Sebastian
