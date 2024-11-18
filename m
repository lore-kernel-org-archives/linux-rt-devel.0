Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671613CA95;
	Mon, 18 Nov 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915423; cv=none; b=kqcNWh9dGHGqLOLmOumek/9yCIhXJr9+2nJKZFqA18gz54nwlfmWskZJSRfLNRoTPlUNmboeBQFUno6OSmRC7XFQAWuIzfJTUsSapAlbRAxkr1J43RoH9xGHr6NzucuHbFb/zQnBQVxacfg+uSG+W8q0NRGql8TvNAxcAHbSsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915423; c=relaxed/simple;
	bh=YyvnxTnBcTuuXnXZtwh+ACzFix1LLAzXEttk/EZpdFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAxlev98rRHnDe7u50IsrZ+tOCyWvrVMS0EQLyh50Ju+cWP8Z6Wwp6TG8zJ84kpN7TqfkdSkhhBFp58id23plkj0NzozWdIGVQvWCTxHSWlffHKQpP7Valjr7PbudYn53yEq0AFUl23vl4ZFZ0mt48AaMaNLkNtsrkbm3SJKhws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C4VPWOIh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfSIjs2e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4VPWOIh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfSIjs2e"
Date: Mon, 18 Nov 2024 08:36:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731915420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIrxfE4o6IC0+LqwFA2chdFLQyrI2KeBikkNuFo4Vkc=;
	b=C4VPWOIhdliAFcOSIg+kS4Cj7JrXi1ZKuC7m4GCxyLUg7I9HPKKcMQHK/pf5xPvpHUUs+R
	x5qlPstIxfVlHh76rmw/GgWfUomka9f6hkxc2hY52kOA5bAwD+JeLY7tVbEynC2nNnYqna
	LgpG3PRuVT6klxd9z/G62cCor9NP47apwscT76TZQWG7okPzOC1rlXiSQOotGaWh6ykjbH
	22QE0fY0sKGu9i97bfJss2Eci/gRBalkVuKcmARNDLgu7h2wVQJTUdm4VrBWNh3sOY3Wob
	l0NK5z6T2ajFQWP11E+BtQGUphazsNUO2tKTRvJy0NuGsDdOTZqxOLbO867TdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731915420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIrxfE4o6IC0+LqwFA2chdFLQyrI2KeBikkNuFo4Vkc=;
	b=AfSIjs2eVU0wR60uP2y8dkZKdmn4BTWDyl1jUoZ945MnEtOKSFsSW/Dl3C5UFzCRFmg9xo
	8iciotMjnjs7PSDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <20241118073659.MGircGsm@linutronix.de>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn>
 <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
 <20241114111409.LWKp5YEg@linutronix.de>
 <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
 <20241114113018.Ilo9ZsQo@linutronix.de>
 <CAAhV-H4jDNG8nsW30U9zE1-c6dHwy2fSjy5hkZhpWWu3=og64A@mail.gmail.com>
 <20241114132956.wafcHvaB@linutronix.de>
 <ZzYMie7ktV8ByaQF@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzYMie7ktV8ByaQF@demetrius>

On 2024-11-14 08:43:21 [-0600], Clark Williams wrote:
> We see similar problems with chronyd accessing the RTC on aarch64
> systems that use UEFI. Accessing anything via the EFI Runtime is very
> slow. Probably going to turn off 'rtcsync' in chronyd when running
> low-latency workloads. 

But isn't "we call into EFI and have no clue what happens" exactly the
reason why we disable EFI runtime services?

> Clark

Sebastian
