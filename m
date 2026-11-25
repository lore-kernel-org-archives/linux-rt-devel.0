Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642669;
	b=ETb/24r+62srZ4XwgPBKZBS5jPd469mIqiZtOlKa6P+IRof/g0FdJseV2YKps2K3WY1J
	 e4E99AIEoeAJ9sRJcl+I2OvXSaM1bR1QkmMY0YDk6Nqwi5XeA+NRfuV9ORq+S46+3ceri
	 iXvRH6d1U7Lo5wZt6Q3g4wazDzWUHY8x9KzpN2QLm4A+f5FGvrQPAHVjAreqmeczo8S4B
	 1uE58H/k5DCYT6xLAn2A2iKHW3Qr4lU5r5kCOJqQw54n9WS4TgCryGUPace5oLBQET2yj
	 edXiv7m65xnBaD+LlGNv15iwCEEKvT32yLdJHolGeNlnVLxxNxUJjCJt7RjBRBRRKxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642669;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GFtOy/DkrylhTwGRcpVBffMCTS+bYSp5H2q2JU6u3Ac=;
	b=JYD8Ht7gQQMLBpurv1JaGdStdJvt/gfWIiozVdcb4djyzJqpKAKNkOu4ik5GNv5lL3AV
	 TDucofSCvcrAwrey5vIMjCn2loiSmRzUwp85pH21Uk7yMzHClYlQKGZFgKt42HeliBXJ5
	 2EBTpXFIzBwCrzOF+s4mNv23Ab7f89WhicwZn5vyyTf08Wmp71XErRyE45PIrdfiSZjtm
	 hi0XbmGBl6/LywWpFd3cu2vj/ja6WEefAI6EgyAI7eFhbHcBTjS8/gsZY246orDOIg8Gk
	 ifAehRc9iwTdFJ16Q3T5mW7+fI12wcVeAnTfYHmjqaZsgWZaKdNzU9OZK7dnrBJtQlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZhsBhbnS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=E6yYTzPs;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D9606A321
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 21:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7D9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZhsBhbnS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=E6yYTzPs
Date: Wed, 25 Nov 2026 22:37:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795642666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFtOy/DkrylhTwGRcpVBffMCTS+bYSp5H2q2JU6u3Ac=;
	b=ZhsBhbnSy6OkZaVsPb0JseyqVhTB5KlsqiksEeR+vwKRrl2QomZEtQoVF6UfyFOu8/qnVZ
	043Ana96Uw/w5pQxRSna19e51hJOn4ab3NxawO8S10l+0luOdk+bYTkJAwsuKAqro4JwuL
	yMR/xOwFwkd1DNJ9XxZaThlhlMLBYbLMfhJ+f7U1m+z1e/lQ8mEjLd7JXzs3nAi1Rh3Tzp
	fA1XIheFPf6rN3Bfza9uSoXarMgd9WDvNG8DJp7mKDzuLHzdQQI+hx13zql+8YhpXeruxj
	FfL9DGA8bSoC/vdXLLhWVYgZDo7uOFlWeEXOodSzKYZMGVJmblBAIcLcMTgOJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795642666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFtOy/DkrylhTwGRcpVBffMCTS+bYSp5H2q2JU6u3Ac=;
	b=E6yYTzPsC23VhwTsjyLHfO2d++T00aLB5vOrjUOjujvEL1vgYq/6QQbGivMXSRmAplmjjL
	UPb5VuFXQCCh7NBQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Zixin Wang <w1355457260@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Ogness <john.ogness@linutronix.de>, linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, clrkwllms@kernel.org,
	rostedt@goodmis.org, corbet@lwn.net, wagi@monom.org,
	atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Documentation: real-time: Add boot parameters and
 task isolation section
Message-ID: <awdVKGXEXJ94CQYE@lx-t490>
References: <20261124163202.56921-1-w1355457260@gmail.com>
 <awXN9RY3x5xEGFe4@lx-t490>
 <20261125075037.33630-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125075037.33630-1-w1355457260@gmail.com>

Hi Zixin,

On Wed, 25 Nov 2026, Zixin Wang wrote:
>
> Hi Ahmed,
>
> Thanks for the review and for pointing out the scope issue.  I have sent v6,
> which moves the runtime tuning material out of kernel-configuration.rst into
> a new Documentation/core-api/real-time/runtime-tuning.rst, and keeps the
> configuration guide focused on Kconfig options.
>
> The existing CONFIG_* section headings and anchors in kernel-configuration.rst
> are unchanged, so the documentation links generated by kconfig-checker remain
> valid.  I ran the preempt_rt rules from your v1 checker (reconstructed in the
> 7.3.5 tree, since the tool is not merged there): all 12 generated
> documentation URLs resolve to anchors in the built HTML.
>
> The C-state, EFI runtime, CPU isolation, RCU offload, and interrupt affinity
> content from v5 is now in the runtime tuning guide, and the configuration
> guide links to the relevant sections.
>

This sounds like copy-pasted output from a Claude agent ;)

In any case, thanks for following all the feedback!

All the best,
Ahmed
