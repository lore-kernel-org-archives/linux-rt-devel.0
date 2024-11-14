Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE91D9664;
	Thu, 14 Nov 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582854; cv=none; b=ZmbCtTXdMwvzxC73GWCiNiqSgH8Oyq2OSwRdmpWMh/fpXS+ch/D4TIDoNDOfB7OrIDRnHqR3cBBR6s3jYdY/22M98kBVbv/WA2m/JE7NqQ8zZcBNJviud9L8Z7+CTtEs22UKZIQm9Ymezjwmxub3X+DhrIR/OaX0ljK5IX7qbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582854; c=relaxed/simple;
	bh=gRR40SndAUINQpZzoaGb+C823qJAH75RLefirXL5ndI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDaHIQgF+Oqx9MnVcsdnX5/UFNe8MYe9H4dGu5l90JeuoyIhajR3tQ11oaJIg7ACnVtdB/KIh0XIhN8uHXU6Uayq3mmGs8GWxNk/0d9L/tOKSw5ued0C9I0HcWRuIz6Lj2Eyfb8M5EHzPM7C9cI9W15i6tCuEMJdb/oCBNjxsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOQTk0eC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpFWdLfk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOQTk0eC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpFWdLfk"
Date: Thu, 14 Nov 2024 12:14:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731582851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRR40SndAUINQpZzoaGb+C823qJAH75RLefirXL5ndI=;
	b=jOQTk0eCAw6EuTBILsaJACYPzwJLzUNz06TxVfaS/Amv/V/P5ndH6B8NH5jVklVOuRjdF/
	LIIL8Kazvr0d/vX56+9IvaU2mDhFCsTljanS8cMaqHpbc7fVpuFq4a3Ty3raoBJCew7I1z
	hxY1/d9ePwiWw++GHR4qvWto2sh6eb8e0O3pbZWWvyfKyRypRTbjQIj6gY7FXrHOuHd+5M
	hMINm9loI9ruUz6MXpFQQtq/4PlelZtpfVK32YyCVRcu6B9RQxz1H2lo7YaeYdneflsdkY
	+nOvtEU3BYrjabhDkBIUVczzOsggnmuRSm5+O0VipuTb688z2rLWJ3ZKa2qdYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731582851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRR40SndAUINQpZzoaGb+C823qJAH75RLefirXL5ndI=;
	b=zpFWdLfk6FuIP+24DjWeCi0w/vvbSjtCvDiGblalF2T60f88dnxszD9/oB586FW9lDhgK6
	iBXPAtaztEGwmWDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <20241114111409.LWKp5YEg@linutronix.de>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn>
 <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>

On 2024-11-14 19:07:37 [+0800], Huacai Chen wrote:
> Hi, Sebastian,
Hi,

> > Why is ntpd/chronyd service affecting this? Is it running at prio 99?
> > Otherwise it should not be noticed.
> No, ntpd/chronyd doesn't affect latency. But they may trigger RTC
> synchronization every 11 minutes, and RTC synchronization affects
> latency. We can keep ntpd/chronyd running but disable RTC
> synchronization by configuration, this is the least aggressive method.

What is "RTC synchronization" in this context?

> > Is lockdep complaining in any workloads?
> > Is CONFIG_DEBUG_ATOMIC_SLEEP leading to any complains?
> This needs more tests because I haven't enabled them.

That would be good. It would show if there is anything that has not yet
been noticed.

> Huacai

Sebastian
